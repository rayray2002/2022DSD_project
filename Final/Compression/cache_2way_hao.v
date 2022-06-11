// `timescale 1 ns/10 ps
module I_cache(
        clk,
        proc_reset,
        proc_read,
        proc_write,
        proc_addr,
        proc_rdata,
        proc_wdata,
        proc_stall,
        mem_read,
        mem_write,
        mem_addr,
        mem_rdata,
        mem_wdata,
        mem_ready
    );

    localparam IDLE = 2'b00, COMPARE_TAG = 2'b01, WRITE_BACK = 2'b10, ALLOCATE = 2'b11;
    //==== input/output definition ============================
    input          clk;
    // processor interface
    input          proc_reset;
    input          proc_read, proc_write;
    input   [29:0] proc_addr;
    input   [31:0] proc_wdata;
    output         proc_stall;
    output  [31:0] proc_rdata;
    // memory interface
    input  [127:0] mem_rdata;
    input          mem_ready;
    output         mem_read, mem_write;
    output  [27:0] mem_addr;
    output [127:0] mem_wdata;

    //==== wire/reg definition ================================
    reg [155:0] block [0:3][0:1]; //valid: 1 bit, dirty: 1 bit, tag: 26 bits, block: 4 words/16 bytes/ 128 bits
    reg [155:0] next_block [0:3][0:1];
    reg [155:0] mapped_block0, mapped_block1, mapped_block, block_write;
    reg [127:0] block_data, mem_wdata_r, mem_wdata_w;
    reg [31:0] block_word, proc_rdata_r, proc_rdata_w;
    reg [27:0] mem_addr_r, mem_addr_w;
    reg [25:0] block0_tag, block1_tag, block_tag;
    reg mem_read, mem_write, set, block0_valid, block1_valid, block_valid, block_dirty, proc_stall_r, proc_stall_w, block0_hit, block1_hit, block_hit;

    reg lru [0:3];
    reg next_lru [0:3];

    reg [1:0] current_state, next_state;

    wire [25:0] tag;
    wire [1:0] index, offset;

    integer i, j, k, l, m ,n;

    assign tag    = proc_addr[29:4];
    assign index  = proc_addr[3:2]; //set index
    assign offset = proc_addr [1:0];

    assign proc_rdata = proc_rdata_r;
    assign proc_stall = proc_stall_r&(proc_read|proc_write);

    assign mem_wdata = mem_wdata_r;
    assign mem_addr  = mem_addr_r;

    //==== combinational circuit ==============================
    always @(*)
    begin
        {mapped_block0, mapped_block1} = {block[index][0], block[index][1]};
        {block0_valid, block1_valid} = {mapped_block0[155], mapped_block1[155]};
        {block0_tag, block1_tag} = {mapped_block0[153:128], mapped_block1[153:128]};

        set = lru[index]; //0: block[index][0], 1: block[index][i];

        block0_hit = (block0_tag == tag) & block0_valid;
        block1_hit = (block1_tag == tag) & block1_valid; //TRUE: block[index][1], FALSE: block[index][0]
        block_hit  = block0_hit | block1_hit;

        mapped_block = block[index][block_hit ? block1_hit : set]; //(block number) mod (number of sets)
        block_valid  = mapped_block[155];
        block_dirty  = mapped_block[154];
        block_tag    = mapped_block[153:128];
        block_data   = mapped_block[127:0];

        case (offset)
            2'b00:
            begin
                block_word  = block_data[31:0];
                block_write = {1'b1, 1'b1, tag, block_data[127:32], proc_wdata}; //dirty
            end
            2'b01:
            begin
                block_word  = block_data[63:32];
                block_write = {1'b1, 1'b1, tag, block_data[127:64], proc_wdata, block_data[31:0]}; //dirty
            end
            2'b10:
            begin
                block_word  = block_data[95:64];
                block_write = {1'b1, 1'b1, tag, block_data[127:96], proc_wdata, block_data[63:0]}; //dirty
            end
            2'b11:
            begin
                block_word  = block_data[127:96];
                block_write = {1'b1, 1'b1, tag, proc_wdata, block_data[95:0]}; //dirty
            end
            default :
            begin
                block_word  = 32'b0;
                block_write = 155'b0;
            end
        endcase
    end

    //next-state logic
    always @(*)
    begin
        case (current_state)
            IDLE:
            begin
                if (proc_read | proc_write)
                    next_state = COMPARE_TAG;
                else
                    next_state = IDLE;
            end
            COMPARE_TAG:
            begin
                if (block_hit)
                    next_state = IDLE; //hit
                else if (~block_dirty)
                    next_state = ALLOCATE; //miss & clean
                else if (block_dirty)
                    next_state = WRITE_BACK; //miss & dirty
                else
                    next_state = COMPARE_TAG;
            end
            WRITE_BACK:
            begin
                if (mem_ready)
                    next_state = ALLOCATE; //memory ready
                else
                    next_state = WRITE_BACK; //memory not ready
            end
            ALLOCATE:
            begin
                if (mem_ready)
                    next_state = COMPARE_TAG; //memory ready
                else
                    next_state = ALLOCATE; //memory not ready
            end
            default :
                next_state = IDLE;
        endcase
    end

    //output logic
    always @(*)
    begin
        //default
        for (i = 0; i < 4; i = i + 1)
        begin
            for (j = 0; j < 2; j = j + 1)
                next_block[i][j] = block[i][j];
            next_lru[i] = lru[i];
        end
        proc_rdata_w = proc_rdata_r;
        mem_addr_w = mem_addr_r;
        mem_wdata_w = mem_wdata_r;

        case (current_state)
            IDLE:
            begin
                proc_stall_w = (proc_read | proc_write) ? 1'b1 : 1'b0;
                mem_read     = 1'b0;
                mem_write    = 1'b0;
            end
            COMPARE_TAG:
            begin
                mem_read  = 1'b0;
                mem_write = 1'b0;
                if (proc_read)
                begin
                    if (block_hit)
                    begin //read hit
                        proc_stall_w = 1'b0;
                        proc_rdata_w = block_word;
                        next_lru[index] = ~block1_hit;
                    end
                    else
                    begin //read miss
                        proc_stall_w    = 1'b1;
                        if (block_dirty)
                        begin //write back
                            mem_addr_w  = {block_tag, index};
                            mem_wdata_w = block_data;
                        end
                        else
                            mem_addr_w = proc_addr[29:2]; //write allocate
                    end
                end
                else if (proc_write)
                begin
                    if (block_hit)
                    begin //write hit
                        proc_stall_w = 1'b0;
                        next_block[index][block1_hit] = block_write;
                        next_lru[index] = ~block1_hit;
                    end
                    else
                    begin //write miss
                        proc_stall_w    = 1'b1;
                        if (block_dirty)
                        begin //write back
                            mem_addr_w  = {block_tag, index};
                            mem_wdata_w = block_data;
                        end
                        else
                            mem_addr_w = proc_addr[29:2]; //write allocate
                    end
                end
                else
                    proc_stall_w = 1'b0;
            end
            WRITE_BACK:
            begin
                proc_stall_w = 1'b1;
                mem_read     = 1'b0;
                if (mem_ready)
                begin
                    mem_write  = 1'b0;
                    mem_addr_w = proc_addr[29:2];
                    next_block[index][set] = {1'b1, 1'b0, tag, block_data}; //clean
                end
                else
                    mem_write    = 1'b1;
            end
            ALLOCATE:
            begin
                proc_stall_w = 1'b1;
                mem_write    = 1'b0;
                if (mem_ready)
                begin
                    mem_read = 1'b0;
                    next_block[index][set] = {1'b1, 1'b0, tag, mem_rdata};
                    next_lru[index] = ~set;
                end
                else
                    mem_read = 1'b1;
            end
            default :
            begin
                proc_stall_w = 1'b0;
                mem_read     = 1'b0;
                mem_write    = 1'b0;
            end
        endcase
    end


    //==== sequential circuit =================================
    always@( posedge clk )
    begin
        if( proc_reset )
        begin
            for (k = 0; k < 4; k = k + 1)
            begin
                for (l = 0; l < 2; l = l + 1)
                    block[k][l] <= 156'b0;
                lru[k] <= 1'b0;
            end
            proc_rdata_r <= 32'b0;
            proc_stall_r <= 1'b0;
            mem_addr_r <= 28'b0;
            mem_wdata_r <= 128'b0;
            current_state <= IDLE;
        end
        else
        begin
            for (m = 0; m < 4; m = m + 1)
            begin
                for (n = 0; n < 2; n = n + 1)
                    block[m][n] <= next_block[m][n];
                lru[m] <= next_lru[m];
            end
            proc_rdata_r <= proc_rdata_w;
            proc_stall_r <= proc_stall_w;
            mem_addr_r <= mem_addr_w;
            mem_wdata_r <= mem_wdata_w;
            current_state <= next_state;
        end
    end

endmodule

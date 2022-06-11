module L2_cache(
        clk,
        proc_reset,
        /*I cache interface*/
        proc_read_I,
        proc_write_I,
        proc_addr_I,
        proc_rdata_I,
        proc_wdata_I,
        proc_stall_I,
        mem_read_I,
        mem_write_I,
        mem_addr_I,
        mem_rdata_I,
        mem_wdata_I,
        mem_ready_I,
        /*D cache interface*/
        proc_read_D,
        proc_write_D,
        proc_addr_D,
        proc_rdata_D,
        proc_wdata_D,
        proc_stall_D,
        mem_read_D,
        mem_write_D,
        mem_addr_D,
        mem_rdata_D,
        mem_wdata_D,
        mem_ready_D
    );

    //==== input/output definition ============================
    input          clk;
    input          proc_reset;
    /*for I_mem*/
    // processor interface
    input          proc_read_I, proc_write_I;
    input   [27:0] proc_addr_I;
    input   [127:0] proc_wdata_I;
    output         proc_stall_I;
    output reg [127:0] proc_rdata_I;
    // memory interface
    input  [127:0] mem_rdata_I;
    input          mem_ready_I;
    output         mem_read_I, mem_write_I;
    output reg [27:0] mem_addr_I;
    output reg [127:0] mem_wdata_I;
    /*for D_mem*/
    // processor interface
    input          proc_read_D, proc_write_D;
    input   [27:0] proc_addr_D;
    input   [127:0] proc_wdata_D;
    output         proc_stall_D;
    output reg [127:0] proc_rdata_D;
    // memory interface
    input  [127:0] mem_rdata_D;
    input          mem_ready_D;
    output         mem_read_D, mem_write_D;
    output reg [27:0] mem_addr_D;
    output reg [127:0] mem_wdata_D;
    //params
    parameter TAG_WIDTH = 23;
    parameter BLOCK_NUMBER = 64;
    parameter BLOCK_WIDTH = $clog2(BLOCK_NUMBER);
    parameter INITIAL = 0, RESET = 1, PROCESS = 2, WRITE_I = 3, READ_I = 4, WRITE_D = 5, READ_D = 6;
    //==== wire/reg definition ================================
    reg isdirty_I, isdirty_D, source_D, source_I;
    reg writemiss_I, writemiss_D, readmiss_I, readmiss_D;
    reg writemiss_D_rear, writemiss_D_front, writemiss_I_rear, writemiss_I_front;
    reg readmiss_D_rear, readmiss_D_front, readmiss_I_rear, readmiss_I_front;
    reg readrequest, readrequest_nxt;

    reg [255:0]             block_data      [0:BLOCK_NUMBER-1];//data in cache
    reg [TAG_WIDTH*2-1:0]   block_tag       [0:BLOCK_NUMBER-1];//tag in cache
    reg [1:0]               block_valid     [0:BLOCK_NUMBER-1];//0==not valid, 1==valid
    reg [1:0]               block_dirty     [0:BLOCK_NUMBER-1];//0==not dirty, 1==dirty
    reg [1:0]               block_source    [0:BLOCK_NUMBER-1];//0==from I_mem, 1==from D_mem
    reg                     block_LRU       [0:BLOCK_NUMBER-1];//0==data in [127:0], 1==data in [255:128]
    reg [2:0] Q_NOW, Q_NEXT;

    integer i;
    //==== combinational circuit ==============================
    assign proc_stall_I = (writemiss_I||readmiss_I||(Q_NOW!=PROCESS)) ? 1 : 0;
    assign proc_stall_D = (writemiss_D||readmiss_D||(Q_NOW!=PROCESS)) ? 1 : 0;
    assign mem_write_D  = (Q_NOW==WRITE_D) ? 1 : 0;
    assign mem_write_I  = (Q_NOW==WRITE_I) ? 1 : 0;
    assign mem_read_D   = (Q_NOW==READ_D)  ? 1 : 0;
    assign mem_read_I   = (Q_NOW==READ_I)  ? 1 : 0;

    // proc block index
    wire [BLOCK_WIDTH-1:0] block_index_D;
    wire [BLOCK_WIDTH-1:0] block_index_I;
    assign block_index_D = proc_addr_D[BLOCK_WIDTH-1:0];
    assign block_index_I = proc_addr_I[BLOCK_WIDTH-1:0];
    // mem block index
    wire [BLOCK_WIDTH-1:0] mem_index_D;
    wire [BLOCK_WIDTH-1:0] mem_index_I;
    assign mem_index_D = mem_addr_D[BLOCK_WIDTH-1:0];
    assign mem_index_I = mem_addr_I[BLOCK_WIDTH-1:0];
    //

    always@(*)
    begin
        //isdirty logic
        isdirty_D = block_LRU[block_index_D] ? block_dirty[block_index_D][1] : block_dirty[block_index_D][0];
        isdirty_I = block_LRU[block_index_I] ? block_dirty[block_index_I][1] : block_dirty[block_index_I][0];
        //source logic
        source_D = block_LRU[block_index_D] ? block_source[block_index_D][1] : block_source[block_index_D][0];
        source_I = block_LRU[block_index_I] ? block_source[block_index_I][1] : block_source[block_index_I][0];
    end

    always@(*)
    begin
        //mem_addr_D logic
        if (Q_NOW == WRITE_D)
        begin
            mem_addr_D = block_LRU[block_index_D] ? {block_tag[block_index_D][TAG_WIDTH*2-1:TAG_WIDTH], block_index_D} : {block_tag[block_index_D][TAG_WIDTH-1:0], block_index_D};
        end
        else
        begin
            mem_addr_D = proc_addr_D;
        end
        //mem_addr_I logic
        if (Q_NOW == WRITE_I)
        begin
            mem_addr_I = block_LRU[block_index_I] ? {block_tag[block_index_I][TAG_WIDTH*2-1:TAG_WIDTH], block_index_I} : {block_tag[block_index_I][TAG_WIDTH-1:0], block_index_I};
        end
        else
        begin
            mem_addr_I = proc_addr_I;
        end
    end

    always@(*)
    begin
        //proc_rdata_D logic (compare to dm, we need to search by tag)
        if (proc_addr_D[27:BLOCK_WIDTH] == block_tag[block_index_D][TAG_WIDTH-1:0] && block_source[block_index_D][0])
        begin
            proc_rdata_D = block_data[block_index_D][127:0];
        end
        else if (proc_addr_D[27:BLOCK_WIDTH] == block_tag[block_index_D][TAG_WIDTH*2-1:TAG_WIDTH] && block_source[block_index_D][1])
        begin
            proc_rdata_D = block_data[block_index_D][255:128];
        end
        else
        begin
            proc_rdata_D = 0;
        end
        //proc_rdata_I logic
        if (proc_addr_I[27:BLOCK_WIDTH] == block_tag[block_index_I][TAG_WIDTH-1:0] && (~block_source[block_index_I][0]))
        begin
            proc_rdata_I = block_data[block_index_I][127:0];
        end
        else if (proc_addr_I[27:BLOCK_WIDTH] == block_tag[block_index_I][TAG_WIDTH*2-1:TAG_WIDTH] && (~block_source[block_index_I][1]))
        begin
            proc_rdata_I = block_data[block_index_I][255:128];
        end
        else
        begin
            proc_rdata_I = 0;
        end
    end

    always@(*)
    begin
        //mem_wdata_D logic
        mem_wdata_D = block_LRU[mem_index_D] ? block_data[mem_index_D][255:128] : block_data[mem_index_D][127:0];
        //mem_wdata_I logic
        mem_wdata_I = block_LRU[mem_index_I] ? block_data[mem_index_I][255:128] : block_data[mem_index_I][127:0];
        //writemiss_D logic
        if(proc_write_D)
        begin
            writemiss_D_rear = ((block_tag[block_index_D][TAG_WIDTH-1:0] == proc_addr_D[27:BLOCK_WIDTH]) && block_valid[block_index_D][0] && block_source[block_index_D][0]) ? 1 : 0;
            writemiss_D_front = ((block_tag[block_index_D][TAG_WIDTH*2-1:TAG_WIDTH] == proc_addr_D[27:BLOCK_WIDTH]) && block_valid[block_index_D][1] && block_source[block_index_D][1]) ? 1 : 0;
            writemiss_D = ~(writemiss_D_rear | writemiss_D_front);
        end
        else
        begin
            writemiss_D = 0;
            writemiss_D_rear = 0;
            writemiss_D_front = 0;
        end
        //writemiss_I logic
        if(proc_write_I)
        begin
            writemiss_I_rear = ((block_tag[block_index_I][TAG_WIDTH-1:0] == proc_addr_I[27:BLOCK_WIDTH]) && block_valid[block_index_I][0] && (~block_source[block_index_I][0])) ? 1 : 0;
            writemiss_I_front = ((block_tag[block_index_I][TAG_WIDTH*2-1:TAG_WIDTH] == proc_addr_I[27:BLOCK_WIDTH]) && block_valid[block_index_I][1] && (~block_source[block_index_I][1])) ? 1 : 0;
            writemiss_I = ~(writemiss_I_rear | writemiss_I_front);
        end
        else
        begin
            writemiss_I = 0;
            writemiss_I_rear = 0;
            writemiss_I_front = 0;
        end
        //readmiss_D logic
        if(proc_read_D)
        begin
            readmiss_D_rear = ((block_tag[block_index_D][TAG_WIDTH-1:0] == proc_addr_D[27:BLOCK_WIDTH]) && block_valid[block_index_D][0] && block_source[block_index_D][0]) ? 1 : 0;
            readmiss_D_front = ((block_tag[block_index_D][TAG_WIDTH*2-1:TAG_WIDTH] == proc_addr_D[27:BLOCK_WIDTH]) && block_valid[block_index_D][1] &&block_source[block_index_D][1]) ? 1 : 0;
            readmiss_D = ~(readmiss_D_rear | readmiss_D_front);
        end
        else
        begin
            readmiss_D = 0;
            readmiss_D_rear = 0;
            readmiss_D_front = 0;
        end
        //readmiss_I logic
        if(proc_read_I)
        begin
            readmiss_I_rear = ((block_tag[block_index_I][TAG_WIDTH-1:0] == proc_addr_I[27:BLOCK_WIDTH]) && block_valid[block_index_I][0] &&(~block_source[block_index_I][0])) ? 1 : 0;
            readmiss_I_front = ((block_tag[block_index_I][TAG_WIDTH*2-1:TAG_WIDTH] == proc_addr_I[27:BLOCK_WIDTH]) && block_valid[block_index_I][1] &&(~block_source[block_index_I][1])) ? 1 : 0;
            readmiss_I = ~(readmiss_I_rear | readmiss_I_front);
        end
        else
        begin
            readmiss_I = 0;
            readmiss_I_rear = 0;
            readmiss_I_front = 0;
        end
    end
    //fsm logic
    always@(*)
    begin
        if(proc_reset)
        begin
            Q_NEXT = RESET;
            readrequest_nxt = 1'b0;
        end
        else
        begin
            case(Q_NOW)
                INITIAL:
                begin
                    Q_NEXT = (proc_reset)?RESET:INITIAL;
                    readrequest_nxt = 1'b0;
                end
                RESET:
                begin
                    Q_NEXT = (~proc_reset)?PROCESS:RESET;
                    readrequest_nxt = 1'b0;
                end
                PROCESS:
                begin
                    if(readmiss_I | writemiss_I)
                    begin
                        Q_NEXT = (isdirty_I)?((source_I)?WRITE_D:WRITE_I):READ_I;
                        readrequest_nxt = 1'b0;
                    end
                    else if(readmiss_D | writemiss_D)
                    begin
                        Q_NEXT = (isdirty_D)?((source_D)?WRITE_D:WRITE_I):READ_D;
                        readrequest_nxt = 1'b1;
                    end
                    else
                    begin
                        Q_NEXT = PROCESS;
                        readrequest_nxt = readrequest;
                    end
                end
                WRITE_I:
                begin
                    Q_NEXT = (mem_ready_I)?((readrequest)?READ_D:READ_I):WRITE_I;
                    readrequest_nxt = readrequest;
                end
                READ_I:
                begin
                    Q_NEXT = (mem_ready_I)?PROCESS:READ_I;
                    readrequest_nxt = readrequest;
                end
                WRITE_D:
                begin
                    Q_NEXT = (mem_ready_D)?((readrequest)?READ_D:READ_I):WRITE_D;
                    readrequest_nxt = readrequest;
                end
                READ_D:
                begin
                    Q_NEXT = (mem_ready_D)?PROCESS:READ_D;
                    readrequest_nxt = readrequest;
                end
                default:
                begin
                    Q_NEXT = INITIAL;
                    readrequest_nxt = 1'b0;
                end
            endcase
        end
    end

    //==== sequential circuit =================================
    always@( posedge clk )
    begin
        if( proc_reset )
        begin
            for(i=0; i<BLOCK_NUMBER; i=i+1)
            begin
                block_data[i] <= 0;
                block_tag[i] <= 0;
                block_valid[i] <= 0;
                block_dirty[i] <= 0;
                block_LRU[i] <= 0;
                block_source[i] <= 0;
            end
        end
        else
        begin
            case(Q_NOW)
                PROCESS:
                begin
                    //block update (write hit)
                    if(proc_write_D&&~writemiss_D)
                    begin//only D write hit, since I is a read only cache
                        if(proc_addr_D[27:BLOCK_WIDTH]==block_tag[proc_addr_D[BLOCK_WIDTH-1:0]][TAG_WIDTH-1:0]&&block_source[proc_addr_D[BLOCK_WIDTH-1:0]][0])
                        begin
                            block_dirty[block_index_D][0] <= 1'b1;
                            block_tag[block_index_D][TAG_WIDTH-1:0] <= proc_addr_D[27:BLOCK_WIDTH];
                            block_LRU[block_index_D] <= 1'b1;
                            block_source[block_index_D][0] <= 1'b1;
                            block_data[block_index_D][127:0] <= proc_wdata_D;
                        end
                        else
                        begin
                            block_dirty[block_index_D][1] <= 1'b1;
                            block_tag[block_index_D][TAG_WIDTH*2-1:TAG_WIDTH] <= proc_addr_D[27:BLOCK_WIDTH];
                            block_LRU[block_index_D] <= 1'b0;
                            block_source[block_index_D][1] <= 1'b1;
                            block_data[block_index_D][255:128] <= proc_wdata_D;
                        end
                    end
                    else
                    begin//no write hit
                        for(i=0; i<BLOCK_NUMBER; i=i+1)
                        begin
                            block_data[i] <= block_data[i];
                            block_tag[i] <= block_tag[i];
                            block_dirty[i] <= block_dirty[i];
                            block_LRU[i] <= block_LRU[i];
                            block_source[i] <= block_source[i];
                        end
                    end
                    //read hit
                    if(proc_read_D&&~readmiss_D&&proc_read_I&&~readmiss_I)
                    begin//I and D both read hit
                        if(block_index_D==block_index_I)
                        begin//I and D both read same block
                            block_LRU[block_index_D] <= (proc_addr_D[27:BLOCK_WIDTH] == block_tag[block_index_D][TAG_WIDTH-1:0]) ? 1'b0 : 1'b1;//treat D read hit as LRU
                        end
                        else
                        begin//I and D read different block
                            //D LRU update
                            block_LRU[block_index_D] <= (proc_addr_D[27:BLOCK_WIDTH]==block_tag[block_index_D][TAG_WIDTH-1:0]) ? 1'b1 : 1'b0;
                            //I LRU update
                            block_LRU[block_index_I] <= (proc_addr_I[27:BLOCK_WIDTH]==block_tag[block_index_I][TAG_WIDTH-1:0]) ? 1'b1 : 1'b0;
                        end
                    end
                    else if(proc_read_D && ~readmiss_D)
                    begin//only D read hit
                        block_LRU[block_index_D] <= (proc_addr_D[27:BLOCK_WIDTH]==block_tag[block_index_D][TAG_WIDTH-1:0]) ?1'b1 : 1'b0;
                    end
                    else if(proc_read_I && ~readmiss_I)
                    begin//only I read hit
                        block_LRU[block_index_I] <= (proc_addr_I[27:BLOCK_WIDTH]==block_tag[block_index_I][TAG_WIDTH-1:0]) ? 1'b1 : 1'b0;
                    end
                    else
                    begin
                        for(i=0; i<BLOCK_NUMBER; i=i+1)
                            block_LRU[i] <= block_LRU[i];
                    end
                end
                READ_D:
                begin
                    //read miss for D
                    if(mem_ready_D)
                    begin
                        if(~block_LRU[mem_addr_D[BLOCK_WIDTH-1:0]])
                        begin
                            block_data[mem_addr_D[BLOCK_WIDTH-1:0]][127:0] <= mem_rdata_D;
                            block_tag[mem_addr_D[BLOCK_WIDTH-1:0]][TAG_WIDTH-1:0] <= mem_addr_D[27:BLOCK_WIDTH];
                            block_dirty[mem_addr_D[BLOCK_WIDTH-1:0]][0] <= 1'b0;
                            block_valid[mem_addr_D[BLOCK_WIDTH-1:0]][0] <= 1'b1;
                            block_LRU[mem_addr_D[BLOCK_WIDTH-1:0]] <= 1'b1;
                            block_source[mem_addr_D[BLOCK_WIDTH-1:0]][0] <= 1'b1;
                        end
                        else
                        begin
                            block_data[mem_addr_D[BLOCK_WIDTH-1:0]][255:128] <= mem_rdata_D;
                            block_tag[mem_addr_D[BLOCK_WIDTH-1:0]][TAG_WIDTH*2-1:TAG_WIDTH] <= mem_addr_D[27:BLOCK_WIDTH];
                            block_dirty[mem_addr_D[BLOCK_WIDTH-1:0]][1] <= 1'b0;
                            block_valid[mem_addr_D[BLOCK_WIDTH-1:0]][1] <= 1'b1;
                            block_LRU[mem_addr_D[BLOCK_WIDTH-1:0]] <= 1'b0;
                            block_source[mem_addr_D[BLOCK_WIDTH-1:0]][1] <= 1'b1;
                        end
                    end
                    else
                    begin
                        for(i=0; i<BLOCK_NUMBER; i=i+1)
                        begin
                            block_data[i] <= block_data[i];
                            block_tag[i] <= block_tag[i];
                            block_dirty[i] <= block_dirty[i];
                            block_valid[i] <= block_valid[i];
                            block_LRU[i] <= block_LRU[i];
                            block_source[i] <= block_source[i];
                        end
                    end
                end
                READ_I:
                begin
                    //read miss for I
                    if(mem_ready_I)
                    begin
                        if(~block_LRU[mem_addr_I[BLOCK_WIDTH-1:0]])
                        begin
                            block_data[mem_index_I][127:0] <= mem_rdata_I;
                            block_tag[mem_index_I][TAG_WIDTH-1:0] <= mem_addr_I[27:BLOCK_WIDTH];
                            block_dirty[mem_index_I][0] <= 1'b0;
                            block_valid[mem_index_I][0] <= 1'b1;
                            block_LRU[mem_index_I] <= 1'b1;
                            block_source[mem_index_I][0] <= 1'b0;
                        end
                        else
                        begin
                            block_data[mem_index_I][255:128] <= mem_rdata_I;
                            block_tag[mem_index_I][TAG_WIDTH*2-1:TAG_WIDTH] <= mem_addr_I[27:BLOCK_WIDTH];
                            block_dirty[mem_index_I][1] <= 1'b0;
                            block_valid[mem_index_I][1] <= 1'b1;
                            block_LRU[mem_index_I] <= 1'b0;
                            block_source[mem_index_I][1] <= 1'b0;
                        end
                    end
                    else
                    begin
                        for(i=0; i<BLOCK_NUMBER; i=i+1)
                        begin
                            block_data[i] <= block_data[i];
                            block_tag[i] <= block_tag[i];
                            block_dirty[i] <= block_dirty[i];
                            block_valid[i] <= block_valid[i];
                            block_LRU[i] <= block_LRU[i];
                            block_source[i] <= block_source[i];
                        end
                    end
                end
                default:
                begin
                    for(i=0; i<BLOCK_NUMBER; i=i+1)
                    begin
                        block_data[i] <= block_data[i];
                        block_tag[i] <= block_tag[i];
                        block_dirty[i] <= block_dirty[i];
                        block_valid[i] <= block_valid[i];
                        block_LRU[i] <= block_LRU[i];
                        block_source[i] <= block_source[i];
                    end
                end
            endcase
        end
    end

    always@(posedge clk)
    begin
        Q_NOW <= Q_NEXT;
        readrequest <= readrequest_nxt;
    end

endmodule

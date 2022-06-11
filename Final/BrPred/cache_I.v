module cache_I(//L1cacheI_2wayX4setX4word
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
    output  [29:0] mem_addr;
    output [127:0] mem_wdata;

    //==== wire/reg definition ================================
    reg            mem_read,mem_read_next;
    reg     [29:0] mem_addr,mem_addr_next;
    //   reg    [127:0] mem_wdata;

    reg       state_w;
    reg       state;
    reg      [3:0] valid1, valid2,valid1_next,valid2_next;
    //   reg      [3:0] dirty1, dirty2,dirty1_next,dirty2_next;
    //  reg            be_dirty,be_dirty_next;
    reg      [3:0] lru,lru_next;             // 0:data1 1:data2
    reg     [29:4] tag1    [0:3], tag2    [0:3],tag1_next[0:3] , tag2_next[0:3];
    reg    [127:0] data1   [0:3], data2   [0:3], data1_next[0:3], data2_next[0:3];
    wire           hit1, hit2;
    wire     [3:2] set = proc_addr[3:2];
    wire     [1:0] off = proc_addr[1:0];
    wire    [6:0] temp;
    //==== combinational circuit ==============================
    localparam IDLE = 2'd0;
    // localparam WB   = 2'd3;
    localparam RD   = 2'd1;
    integer i;
    assign temp = (off << 5);
    assign proc_stall = ~(hit1 | hit2) && (proc_read);
    assign proc_rdata = hit1
           ? data1[set][temp+:32]
           : data2[set][temp+:32];
    assign mem_write = 1'b0;
    assign hit1 = valid1[set] & (tag1[set] == proc_addr[29:4]);
    assign hit2 = valid2[set] & (tag2[set] == proc_addr[29:4]);

    always@(*)
    begin
        case (state)
            IDLE:
                state_w = proc_stall;
            RD:
                state_w = ~mem_ready;
            default:
                state_w = IDLE;
        endcase
    end


    always@(*)
    begin
        mem_read_next   = mem_read;
        mem_addr_next   = mem_addr;
        valid1_next     = valid1;
        valid2_next     = valid2;
        lru_next        = lru;
        for(i = 0; i < 4; i = i + 1)
        begin
            tag1_next[i] = tag1[i];
            tag2_next[i] = tag2[i];
        end
        for(i = 0; i < 4; i = i + 1)
        begin
            data1_next[i] = data1[i];
            data2_next[i] = data2[i];
        end

        case (state)
            IDLE:
            begin
                if (proc_stall)
                begin
                    mem_read_next = 1;
                    mem_addr_next = proc_addr[29:0];
                end
                if (proc_read & (hit1 | hit2))
                    lru_next[set] = hit1;
            end
            RD:
                if (mem_ready)
                begin
                    mem_read_next   = 0;
                    if (~lru[set])
                    begin
                        valid1_next[set] = 1;
                        tag1_next  [set] = proc_addr[29:4];
                        data1_next [set] = mem_rdata;
                    end
                    else
                    begin
                        valid2_next[set] = 1;
                        tag2_next  [set] = proc_addr[29:4];
                        data2_next [set] = mem_rdata;
                    end
                end
        endcase
    end

    always@(*)
    begin


    end
    //==== sequential circuit =================================
    always@( posedge clk )
    begin
        if( proc_reset )
        begin
            mem_read    <= 0;
            state       <= IDLE;
            valid1      <= 4'b0;
            valid2      <= 4'b0;
            lru         <= 4'b0;
            mem_addr    <=0;
            for(i = 0; i < 4; i = i + 1)
            begin
                tag1[i] <=  0;
                tag2[i] <=  0;
                data1[i] <= 0;
                data2[i] <= 0;
            end
        end
        else
        begin
            state   <= state_w;
            lru <= lru_next;
            mem_addr   <= mem_addr_next;
            mem_read   <=mem_read_next;
            valid2 <= valid2_next;
            valid1 <= valid1_next;
            for(i=0 ;i<4;i=i+1)
            begin
                tag1[i] <= tag1_next[i];
                tag2[i] <= tag2_next[i];
                data1[i] <=data1_next[i];
                data2[i] <= data2_next[i];
            end
        end
    end
endmodule

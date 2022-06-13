module L2cache (
    //32-set 256-word
    input              clk        ,
    input              proc_reset ,
    input              L1i_read_i ,
    input              L1i_write_i,
    input      [ 27:0] L1i_addr_i ,
    input      [127:0] L1i_wdata_i,
    output  reg[127:0] L1i_rdata_o,
    output             L1i_ready  ,
    output reg         memi_read  ,
    output reg         memi_write ,
    output reg [ 27:0] memi_addr  ,
    input      [127:0] memi_rdata ,
    output     [127:0] memi_wdata ,
    input              memi_ready ,
    input              L1d_read_i ,
    input              L1d_write_i,
    input      [ 27:0] L1d_addr_i ,
    input      [127:0] L1d_wdata_i,
    output  reg[127:0] L1d_rdata_o,
    output             L1d_ready  ,
    output reg         memd_read  ,
    output reg         memd_write ,
    output reg [ 27:0] memd_addr  ,
    input      [127:0] memd_rdata ,
    output     [127:0] memd_wdata ,
    input              memd_ready
);

//// Constants ////
    localparam STATE_IDLE        = 3'd0;
    localparam STATE_ALLOCATE_I  = 3'd2;
    localparam STATE_READY_I     = 3'd4;
    localparam STATE_WRITEBACK_D = 3'd1;
    localparam STATE_ALLOCATE_D  = 3'd3;
    localparam STATE_READY_D     = 3'd5;


//// Wire/Reg Declaration ////
    wire proc_access;
    wire I_access   ;
    wire D_access   ;
    reg  access, access_nxt;

    wire [153:0] sram_rdata;
    reg  [153:0] sram_wdata;
    wire [ 22:0] sram_tag  ;
    wire [  4:0] sram_index;

    wire [153:0] sram_data ;
    wire [ 27:0] sram_addr ;
    wire         sram_hit  ;
    wire         sram_dirty;
    reg          sram_write;

    wire [1:0] proc_addr_offset;

    reg [2:0] state    ;
    reg [2:0] state_nxt;

    integer i;


//// Submodule Instantiation ////
    assign I_access    = L1i_read_i;
    assign D_access    = L1d_read_i | L1d_write_i;
    assign proc_access = I_access | D_access;
    assign sram_addr   = (I_access ? L1i_addr_i : L1d_addr_i);

    cache_sram_l2 cache_sram_l2 (
        .clk    (clk       ),
        .rst    (proc_reset),
        
        .addr_i (sram_addr ),
        .wdata_i(sram_wdata),
        .write_i(sram_write),
        .I_D    (I_access  ),
        
        .rdata_o(sram_rdata),
        .hit_o  (sram_hit  )
    );


//// Finite-State Machine ////
// Next State Logic
    always @* begin
        state_nxt = state;
        access_nxt = access;

        case (state)
            STATE_IDLE : begin
                if (proc_access && !sram_hit) begin
                    access_nxt = I_access;
                    if (sram_dirty) begin
                        state_nxt = STATE_WRITEBACK_D;
                    end
                    else begin
                        if (I_access) begin
                            state_nxt = STATE_ALLOCATE_I;
                        end else begin
                            state_nxt = STATE_ALLOCATE_D;
                        end
                    end
                end
            end

            STATE_WRITEBACK_D : begin
                if (memd_ready) begin
                    if (access) begin
                        state_nxt = STATE_ALLOCATE_I;
                    end else begin
                        state_nxt = STATE_ALLOCATE_D;
                    end
                end
            end

            STATE_ALLOCATE_I : begin
                if (memi_ready) begin
                    state_nxt = STATE_READY_I;
                end
            end

            STATE_ALLOCATE_D : begin
                if (memd_ready) begin
                    state_nxt = STATE_READY_D;
                end
            end

            default : begin
                state_nxt = STATE_IDLE;
            end
        endcase
    end

// State Register
    always @(posedge clk) begin
        if (proc_reset) begin
            state       <= STATE_IDLE;
            L1i_rdata_o <= 0;
            L1d_rdata_o <= 0;
        end
        else begin
            state <= state_nxt;
            if (I_access) begin
                L1i_rdata_o <= sram_data;
            end
            if (D_access) begin
                L1d_rdata_o <= sram_data;
            end
        end
    end

// Output Logic
    always @* begin
        memi_read  = 0;
        memi_write = 0;
        memi_addr  = L1i_addr_i;
        memd_read  = 0;
        memd_write = 0;
        memd_addr  = L1d_addr_i;
        sram_write = 0;

        case (state)
            STATE_IDLE : begin
                sram_write = L1d_write_i && sram_hit;
            end

            STATE_WRITEBACK_D : begin
                memd_write = 1;
            end

            STATE_ALLOCATE_I : begin
                memi_read = 1;
            end

            STATE_ALLOCATE_D : begin
                memd_read = 1;
            end

            STATE_READY_I, STATE_READY_D : begin
                sram_write = 1;
            end
        endcase
    end


//// Combinational Logic ////
    // assign proc_access  = proc_read_i || proc_write_i;
    assign L1i_ready = I_access && sram_hit;
    assign L1d_ready = D_access && sram_hit;

    assign memi_wdata = sram_data;
    assign memd_wdata = sram_data;

    // assign L1i_rdata_o = sram_data;
    // assign L1d_rdata_o = sram_data;

    assign sram_dirty = sram_rdata[151];
    // assign sram_tag   = sram_rdata[150:128];
    assign sram_data = sram_rdata[127:0];

    assign sram_tag = sram_addr[27:5];
    // assign sram_index = sram_addr[4:0];

    always @(*) begin
        // I/D(1), valid(1), dirty(1), tag(23), word0(32), word1(32), word2(32), word3(32)
        case (state)
            STATE_READY_D : sram_wdata = {3'b010, sram_tag, memd_rdata};
            STATE_READY_I : sram_wdata = {3'b110, sram_tag, memi_rdata};
            default       : sram_wdata = {3'b011, sram_tag, L1d_wdata_i};
        endcase
    end
endmodule

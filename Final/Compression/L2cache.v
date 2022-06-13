module L2cache (
    //32-set 256-word
    input              clk        ,
    input              proc_reset ,
    input              L1i_read_i ,
    input              L1i_write_i,
    input      [ 27:0] L1i_addr_i ,
    input      [127:0] L1i_wdata_i,
    output reg [127:0] L1i_rdata_o,
    output             L1i_ready  ,
    output reg         memi_read  ,
    output reg         memi_write ,
    output     [ 27:0] memi_addr  ,
    input      [127:0] memi_rdata ,
    output     [127:0] memi_wdata ,
    input              memi_ready ,
    input              L1d_read_i ,
    input              L1d_write_i,
    input      [ 27:0] L1d_addr_i ,
    input      [127:0] L1d_wdata_i,
    output reg [127:0] L1d_rdata_o,
    output             L1d_ready  ,
    output reg         memd_read  ,
    output reg         memd_write ,
    output reg [ 27:0] memd_addr  ,
    input      [127:0] memd_rdata ,
    output     [127:0] memd_wdata ,
    input              memd_ready
);


//// Constants ////
    localparam STATE_IDLE      = 3'd0;
    localparam STATE_WRITEBACK = 3'd1;
    localparam STATE_ALLOCATE  = 3'd2;
    localparam STATE_READY     = 3'd3;
    // localparam STATE_WAIT      = 3'd4;

    localparam STATE_I = 1'd0;
    localparam STATE_D = 1'd1;

//// Wire/Reg Declaration ////
    wire proc_access;
    wire I_access   ;
    wire D_access   ;
    wire conflict   ;
    reg  access, access_nxt;

    wire [154:0] sram_rdata;
    wire [154:0] sram_wdata;
    wire [ 23:0] sram_tag  ;
    wire [  3:0] sram_index;

    wire [ 27:0] I_sram_addr ;
    wire [154:0] I_sram_wdata;
    reg          I_sram_write;
    reg          I_sram_read ;

    wire [ 27:0] D_sram_addr ;
    wire [154:0] D_sram_wdata;
    reg          D_sram_write;
    reg          D_sram_read ;

    wire [27:0] sram_addr ;
    wire        sram_write;

    wire [153:0] sram_data ;
    wire         sram_hit  ;
    wire         sram_dirty;

    wire [1:0] proc_addr_offset;

    reg [1:0] I_state    ;
    reg [1:0] I_state_nxt;

    reg [1:0] D_state    ;
    reg [1:0] D_state_nxt;

    reg SRAM_state    ;
    reg SRAM_state_nxt;

    wire permission;
    wire I_request ;
    wire D_request ;

    integer i;


//// Submodule Instantiation ////
    assign permission = 1;
    assign I_access   = L1i_read_i;
    assign D_access   = L1d_read_i | L1d_write_i;

    assign I_request = I_sram_read | I_sram_write;
    assign D_request = D_sram_read | D_sram_write;

    assign proc_access = I_access | D_access;
    assign conflict    = I_access & D_access;

    cache_sram_l2 cache_sram_l2 (
        .clk    (clk                     ),
        .rst    (proc_reset              ),
        
        .addr_i (sram_addr               ),
        .wdata_i(sram_wdata              ),
        .write_i(sram_write              ),
        .I_D    (conflict ? 1'b0 : I_access),
        
        .rdata_o(sram_rdata              ),
        .hit_o  (sram_hit                )
    );


//// Finite-State Machine ////
// Next State Logic
    always @* begin
        I_state_nxt = I_state;

        case (I_state)
            STATE_IDLE : begin
                // if (conflict && permission)
                if (~conflict || ~permission) begin
                    if (I_access && !sram_hit) begin
                        if (sram_dirty)
                            I_state_nxt = STATE_WRITEBACK;
                        else
                            I_state_nxt = STATE_ALLOCATE;
                    end
                end
                else begin
                    I_state_nxt = STATE_IDLE;
                end
            end

            STATE_WRITEBACK : begin
                if (memd_ready) begin
                    I_state_nxt = STATE_ALLOCATE;
                end
            end

            STATE_ALLOCATE : begin
                if (memi_ready) begin
                    I_state_nxt = STATE_READY;
                end
            end

            STATE_READY : begin
                I_state_nxt = STATE_IDLE;
            end
        endcase
    end

    always @* begin
        D_state_nxt = D_state;

        case (D_state)
            STATE_IDLE : begin
                if (~conflict || permission) begin
                    if (D_access && !sram_hit) begin
                        if (sram_dirty)
                            D_state_nxt = STATE_WRITEBACK;
                        else
                            D_state_nxt = STATE_ALLOCATE;
                    end
                end
            end

            STATE_WRITEBACK : begin
                if (memd_ready) begin
                    D_state_nxt = STATE_ALLOCATE;
                end
            end

            STATE_ALLOCATE : begin
                if (memd_ready) begin
                    D_state_nxt = STATE_READY;
                end
            end

            STATE_READY : begin
                D_state_nxt = STATE_IDLE;
            end
        endcase
    end

    always @* begin
        if (conflict)
            SRAM_state_nxt = ~SRAM_state;
        else
            SRAM_state_nxt = SRAM_state;
    end

// State Register
    always @(posedge clk) begin
        if (proc_reset) begin
            I_state     <= STATE_IDLE;
            D_state     <= STATE_IDLE;
            SRAM_state  <= I_state;
            L1i_rdata_o <= 0;
            L1d_rdata_o <= 0;
        end
        else begin
            I_state    <= I_state_nxt;
            D_state    <= D_state_nxt;
            SRAM_state <= SRAM_state_nxt;
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
        memi_read    = 0;
        memi_write   = 0;
        I_sram_write = 0;
        I_sram_read  = 0;

        memd_read    = 0;
        memd_write   = 0;
        D_sram_write = 0;
        D_sram_read  = 0;

        memd_addr = L1d_addr_i;

        case (I_state)
            STATE_IDLE : begin
                I_sram_read = L1i_read_i;
            end

            STATE_WRITEBACK : begin
                memd_write = 1;
                memd_addr  = {sram_rdata[151:128], L1i_addr_i[3:0]};
            end

            STATE_ALLOCATE : begin
                memi_read = 1;
            end

            STATE_READY : begin
                I_sram_write = 1;
            end
        endcase

        case (D_state)
            STATE_IDLE : begin
                D_sram_write = L1d_write_i & sram_hit & permission;
                D_sram_read  = L1d_read_i;
            end

            STATE_WRITEBACK : begin
                memd_write = 1;
                memd_addr  = {sram_rdata[151:128], L1d_addr_i[3:0]};
            end

            STATE_ALLOCATE : begin
                memd_read = 1;
            end

            STATE_READY : begin
                D_sram_write = 1;
            end
        endcase
    end


//// Combinational Logic ////
    // assign proc_access  = proc_read_i || proc_write_i;
    assign L1i_ready = conflict ? (permission ? 0 : (I_access && sram_hit)) : (I_access && sram_hit);
    assign L1d_ready = conflict ? (permission ? (D_access && sram_hit) : 0) : (D_access && sram_hit);

    assign memi_wdata = sram_data;
    assign memd_wdata = sram_data;

    assign memi_addr = L1i_addr_i;
    // assign memd_addr = L1d_addr_i;

    assign sram_dirty = sram_rdata[152];
    assign sram_data  = sram_rdata[127:0];
    assign sram_tag   = sram_addr[27:4];

    assign sram_addr  = conflict ? (~permission ? L1i_addr_i : L1d_addr_i) : (I_access ? L1i_addr_i : L1d_addr_i);
    assign sram_write = conflict ? (~permission ? I_sram_write : D_sram_write) : (I_access ? I_sram_write : D_sram_write);
    assign sram_wdata = conflict ? (~permission ? I_sram_wdata : D_sram_wdata) : (I_access ? I_sram_wdata : D_sram_wdata);

    assign I_sram_wdata = {3'b110, sram_tag, memi_rdata};
    assign D_sram_wdata = (D_state == STATE_READY) ? {3'b010, sram_tag, memd_rdata} : {3'b011, sram_tag, L1d_wdata_i};
endmodule

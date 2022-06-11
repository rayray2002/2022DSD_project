module I_cache (
  input              clk         ,
  // processor interface
  input              proc_reset_i,
  input              proc_read_i ,
  input              proc_write_i,
  input      [ 30:0] proc_addr_i ,
  output reg [ 31:0] proc_rdata_o,
  input      [ 31:0] proc_wdata_i,
  output             proc_stall_o,
  // memory interface
  output reg         mem_read_o  ,
  output reg         mem_write_o ,
  output reg [ 27:0] mem_addr_o  ,
  input      [127:0] mem_rdata_i ,
  output     [127:0] mem_wdata_o ,
  input              mem_ready_i
);


//// Parameters ////

//// Constants ////
  localparam STATE_IDLE = 3'd0;
// localparam STATE_WRITEBACK   = 3'd1;
  localparam STATE_NEXTLINE = 3'd1;
  localparam STATE_ALLOCATE = 3'd2;
  localparam STATE_READY    = 3'd3;


//// Wire/Reg Declaration ////
  wire proc_access;

// 2-way
  wire [155:0] sram_rdata     ;
  reg  [155:0] sram_wdata     ;
  wire [ 25:0] sram_tag       ;
  wire [ 25:0] proc_addr_tag  ;
  wire [  1:0] proc_addr_index;

  wire [127:0] sram_data ;
  wire         sram_hit  ;
  wire         sram_dirty;
  reg          sram_write;

  wire [2:0] proc_addr_offset;

  reg [2:0] state    ;
  reg [2:0] state_nxt;

// compression
  wire        last_word          ;
  wire        compressed         ;
  reg         fetch_next, fetch_next_nxt, fetch_next_stall, fetch_next_stall_nxt;
  reg  [29:0] sram_addr          ;
  reg  [31:0] sram_data_word     ;
  reg  [15:0] prev_last_half_word;

  assign last_word = (proc_addr_offset == 3'b111);
// assign compressed = ~((~proc_addr_i[0] ? sram_data_word[25:24] : sram_data_word[9:8]) == 2'b11);
  assign compressed = ~(sram_data_word[25:24] == 2'b11);

  always @* begin
    if (fetch_next) begin
      proc_rdata_o = {prev_last_half_word, sram_data[31:16]};
      sram_addr    = (proc_addr_i >> 1) + 1'b1;
    end
    else begin
      proc_rdata_o = sram_data_word;
      sram_addr    = (proc_addr_i >> 1);
    end
  end

  integer i;


//// Submodule Instantiation ////
  cache_sram_2way cache_sram_2way_U (
    .clk    (clk         ),
    .rst    (proc_reset_i),
    
    .addr_i (sram_addr   ),
    .wdata_i(sram_wdata  ),
    .write_i(sram_write  ),
    
    .rdata_o(sram_rdata  ),
    .hit_o  (sram_hit    )
  );


//// Finite-State Machine ////
// Next State Logic
  always @* begin
    state_nxt            = state;
    fetch_next_nxt       = fetch_next;
    fetch_next_stall_nxt = fetch_next_stall;
    case (state)
      STATE_IDLE : begin
        if (proc_access && !sram_hit) begin
          state_nxt = STATE_ALLOCATE;
        end
        if (last_word & ~compressed & ~fetch_next) begin
          state_nxt      = STATE_NEXTLINE;
          fetch_next_nxt = 1;
        end else begin
          fetch_next_nxt = 0;
        end
        fetch_next_stall_nxt = 1;
      end

      // STATE_WRITEBACK: begin
      //     if (mem_ready_i) begin
      //         state_nxt = STATE_ALLOCATE;
      //     end
      // end

      STATE_NEXTLINE : begin
        if (!sram_hit) begin
          state_nxt = STATE_ALLOCATE;
        end else begin
          state_nxt = STATE_READY;
        end
      end

      STATE_ALLOCATE : begin
        if (mem_ready_i) begin
          state_nxt = STATE_READY;
        end
      end

      STATE_READY : begin
        state_nxt = STATE_IDLE;
        if (fetch_next)
          fetch_next_stall_nxt = 0;
      end
    endcase
  end

// State Register
  always @(posedge clk) begin
    if (proc_reset_i) begin
      state               <= STATE_IDLE;
      fetch_next          <= 0;
      fetch_next_stall    <= 1;
      prev_last_half_word <= 0;
    end
    else begin
      state            <= state_nxt;
      fetch_next       <= fetch_next_nxt;
      fetch_next_stall <= fetch_next_stall_nxt;
      if (~fetch_next)
        prev_last_half_word <= sram_data_word[31:16];
    end
  end

// Output Logic
  always @* begin
    mem_read_o  = 0;
    mem_write_o = 0;
    mem_addr_o  = proc_addr_i[30:3];
    sram_write  = 0;

    case (state)
      STATE_IDLE : begin
        sram_write = proc_write_i && sram_hit;
      end

      // STATE_WRITEBACK: begin
      //     mem_write_o = 1;
      //     mem_addr_o  = { sram_tag, proc_addr_index };
      // end

      STATE_NEXTLINE : begin
      end

      STATE_ALLOCATE : begin
        mem_read_o = 1;
        // mem_addr_o  = proc_addr_i[30:3];
        mem_addr_o = sram_addr[29:2];
      end

      STATE_READY : begin
        sram_write = 1;
      end
    endcase
  end


//// Combinational Logic ////
  assign proc_access  = proc_read_i || proc_write_i;
  assign proc_stall_o = proc_access && (!sram_hit || (last_word & ~compressed & fetch_next_stall));

  assign mem_wdata_o = sram_data;

// wire [127:0] sram_big_endian;
// assign sram_big_endian = {sram_data[7:0], sram_data[15:8], sram_data[23:16], sram_data[31:24], sram_data[39:32], sram_data[47:40], sram_data[55:48], sram_data[63:56], sram_data[71:64], sram_data[79:72], sram_data[87:80], sram_data[95:88], sram_data[103:96], sram_data[111:104], sram_data[119:112], sram_data[127:120]};
  always @* begin
    // case(proc_addr_offset>>1)
    //     2'b00: sram_data_word = sram_data[ 31: 0];
    //     2'b01: sram_data_word = sram_data[ 63:32];
    //     2'b10: sram_data_word = sram_data[ 95:64];
    //     2'b11: sram_data_word = sram_data[127:96];
    // endcase
    case(proc_addr_offset)
      3'b000 : sram_data_word = sram_data[ 31:  0];
      3'b001 : sram_data_word = {sram_data[ 15: 0], sram_data[ 63: 48]};
      3'b010 : sram_data_word = sram_data[ 63: 32];
      3'b011 : sram_data_word = {sram_data[ 47: 32], sram_data[ 95: 80]};
      3'b100 : sram_data_word = sram_data[ 95: 64];
      3'b101 : sram_data_word = {sram_data[ 79: 64], sram_data[ 127: 112]};
      3'b110 : sram_data_word = sram_data[127: 96];
      3'b111 : sram_data_word = {sram_data[111: 96], 16'b0};
    endcase
  end

// 2-way
  assign sram_dirty = sram_rdata[154];
  assign sram_tag   = sram_rdata[153:128];
  assign sram_data  = sram_rdata[127:0];

  assign proc_addr_tag    = proc_addr_i[30:5];
  assign proc_addr_index  = proc_addr_i[4:3];
  assign proc_addr_offset = proc_addr_i[2:0];

  always @* begin
    // valid(1), dirty(1), tag(26), word0(32), word1(32), word2(32), word3(32)
    sram_wdata = { 2'b11, proc_addr_tag, sram_data };

    // if (state == STATE_READY) begin
    // allocate
    sram_wdata[154]   = 0; // not dirty
    sram_wdata[127:0] = mem_rdata_i;
    // end
    // else begin
    // write hit
    // sram_wdata[154] = 1; // dirty
    // for (i = 0; i < 32; i = i + 1) begin
    //     sram_wdata[(proc_addr_offset[1:0]<<5) + i] = proc_wdata_i[i];
    // end
    // end
  end


//// Sequential Logic ////


endmodule
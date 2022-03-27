`include "shift_left_add.v"
`include "shift_right_add.v"

module divide20(
           input clk,
           input rst,
           input signed [37:0] data_i,
           output signed [32:0] data_o
       );

wire signed [31:0] shift4;
wire signed [31:0] shift8;
wire signed [31:0] shift16;
wire signed [31:0] shift6;

assign shift6 = (data_i >>> 6);

shift_right_add #(4) shift4_add (
              .clk(clk),
              .rst(rst),
              .data_i(shift6),
              .data_o(shift4)
          );


shift_right_add #(8) shift8_add  (
              .clk(clk),
              .rst(rst),
              .data_i(shift4),
              .data_o(shift8)
          );


shift_right_add #(16) shift16_add (
              .clk(clk),
              .rst(rst),
              .data_i(shift8),
              .data_o(shift16)
          );


shift_left_add #(1) shift1_add(
              .clk(clk),
              .rst(rst),
              .data_i(shift16),
              .data_o(data_o)
          );


endmodule

`include "shift_left_add.v"
`include "shift_right_4_add.v"
`include "shift_right_8_add.v"
`include "shift_right_16_add.v"

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

shift_right_4_add shift4_add (
                    .clk(clk),
                    .rst(rst),
                    .data_i(shift6),
                    .data_o(shift4)
                );
// defparam shift4_add.SHIFT = 4;


shift_right_8_add shift8_add  (
                    .clk(clk),
                    .rst(rst),
                    .data_i(shift4),
                    .data_o(shift8)
                );
// defparam shift8_add.SHIFT = 8;


shift_right_16_add shift16_add (
                    .clk(clk),
                    .rst(rst),
                    .data_i(shift8),
                    .data_o(shift16)
                );
// defparam shift16_add.SHIFT = 16;


shift_left_add shift1_add(
                   .clk(clk),
                   .rst(rst),
                   .data_i(shift16),
                   .data_o(data_o)
               );
// defparam shift1_add.SHIFT = 1;


endmodule

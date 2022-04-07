`include "shift_left_add.v"
`include "shift_right_4_add.v"
`include "shift_right_8_add.v"
`include "shift_right_16_add.v"

module divide20(
           input clk,
           input rst,
           input signed [`REG_WIDTH+6:0] data_i,
           output signed [`REG_WIDTH+1:0] data_o
       );

// wire signed [31:0] big_in;
wire signed [`REG_WIDTH+6:0] shift4;
wire signed [`REG_WIDTH+6:0] shift8;
wire signed [`REG_WIDTH+6:0] shift16;
wire signed [`REG_WIDTH+7:0] shift1;

assign data_o = (shift1 >>> 6);

shift_right_4_add shift4_add (
                    .clk(clk),
                    .rst(rst),
                    .data_i(data_i),
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
                   .data_o(shift1)
               );
// defparam shift1_add.SHIFT = 1;


endmodule

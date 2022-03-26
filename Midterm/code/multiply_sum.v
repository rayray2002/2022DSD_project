// `include "pipeline_reg.v"
`include "multiply_sum_1.v"
`include "multiply_sum_2.v"
`include "multiply_sum_3.v"


module multiply_sum(
           input clk,
           input rst,
           input signed [15:0] b_i,
           input signed [31:0] data1_i,
           input signed [31:0] data2_i,
           input signed [31:0] data3_i,

           output signed [31:0] sum
       );

wire signed [31:0] shift2_add;
wire signed [31:0] shift2;
wire signed [31:0] add_b;
wire signed [31:0] multiply6;
wire signed [31:0] multiply13;
wire signed [31:0] minus;

multiply_sum_1 multiply_sum_1(
                   clk,
                   rst,
                   b_i,
                   data1_i,
                   data2_i,
                   data3_i,

                   shift2_add,
                   shift2,
                   add_b,
                   multiply6
               );

multiply_sum_2 multiply_sum_2(
                   clk,
                   rst,
                   shift2_add,
                   shift2,
                   add_b,
                   multiply6,

                   multiply13,
                   minus
               );

multiply_sum_3 multiply_sum_3(
                   clk,
                   rst,
                   multiply13,
                   minus,

                   sum
               );

endmodule

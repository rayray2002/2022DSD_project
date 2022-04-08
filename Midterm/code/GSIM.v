`timescale 1ns/10ps

`include "const.v"
`include "control.v"
`include "b_register.v"
`include "x_register.v"
`include "add_prev_next.v"
`include "multiply_sum.v"
`include "divide20.v"


module GSIM (
           clk,
           reset,
           in_en,
           b_in,
           out_valid,
           x_out
       );
// port declarations
input   clk;
input   reset;
input   in_en;
output  out_valid;
input   [15:0]  b_in;
output signed [`REG_WIDTH:0]  x_out;

// reg & wire declarations
wire [3:0]  count;
wire signed [15:0]  b_o;
wire signed [`REG_WIDTH:0]  xTarget_in;
wire signed [`REG_WIDTH:0]  xTarget_o;
wire signed [`REG_WIDTH:0]  x_o;
wire signed [`REG_WIDTH:0]  xP1;
wire signed [`REG_WIDTH:0]  xP2;
wire signed [`REG_WIDTH:0]  xP3;
wire signed [`REG_WIDTH:0]  xM1;
wire signed [`REG_WIDTH:0]  xM2;
wire signed [`REG_WIDTH:0]  xM3;
wire signed [`REG_WIDTH+1:0]  data1;
wire signed [`REG_WIDTH+1:0]  data2;
wire signed [`REG_WIDTH+1:0]  data3;
wire signed [`REG_WIDTH+6:0]  sum;
wire signed [`REG_WIDTH+1:0]  x_new;
wire signed [`REG_WIDTH+2:0]  x_sum;

// instances declarations
control control(
            clk,
            reset,
            in_en,
            out_valid,
            count
        );
        
b_register b_register(
               clk,
               in_en,
               reset,
               b_in,
               b_o
           );

x_register x_register(
               clk,
               in_en,
               xTarget_in,
               xTarget_o,
               xP1,
               xM1,
               xP2,
               xM2,
               xP3,
               xM3,
               x_o
           );

add_prev_next stage1(
                  clk,
                  in_en,
                  count[3:0],
                  xP1,
                  xM1,
                  xP2,
                  xM2,
                  xP3,
                  xM3,
                  data1,
                  data2,
                  data3
              );

multiply_sum stage234(
                 clk,
                 in_en,
                 b_o,
                 data1,
                 data2,
                 data3,
                 sum
             );

divide20 stage5678(
             clk,
             in_en,
             sum,
             x_new
         );

assign x_sum = x_new + xTarget_o;
assign xTarget_in = x_sum >>> 1;
// assign xTarget_in = x_new*0.5 + xTarget_o*0.5;
// assign xTarget_in = (x_new + xTarget_o)>>>1;
assign x_out = x_o;

endmodule

// `include "pipeline_reg.v"

module multiply_sum_2(
           input clk,
           input rst,
           input signed [34:0] shift2_add_i,
           input signed [34:0] shift2_i,
           input signed [32:0] add_b_i,
           input signed [35:0] multiply6_i,

           output reg signed [36:0] multiply13_o,
           output reg signed [35:0] minus_o
       );

reg signed [36:0] multiply13;
reg signed [35:0] minus;

always @(*) begin
    multiply13 = shift2_add_i + (shift2_i<<1);
    minus = add_b_i - multiply6_i;
end

always @(posedge clk) begin
    if (rst) begin
        multiply13_o <= 0;
        minus_o <= 0;
    end
    else begin
        multiply13_o <= multiply13;
        minus_o <= minus;
    end
end

// pipeline_reg D1(
//                  clk,
//                  rst,
//                  multiply13,
//                  multiply13_o
//              );

// pipeline_reg D2(
//                  clk,
//                  rst,
//                  minus,
//                  minus_o
//              );

endmodule

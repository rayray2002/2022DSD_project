// `include "pipeline_reg.v"

module multiply_sum_3(
           input clk,
           input rst,
           input signed [31:0] multiply13_i,
           input signed [31:0] minus_i,

           output reg signed [31:0] sum_o
       );

reg signed [31:0] sum;


always @(*) begin
    sum = multiply13_i + minus_i;
end

always @(posedge clk) begin
    if (rst) begin
        sum_o <= 0;
    end else begin
        sum_o <= sum;
    end
end

// pipeline_reg D1(
//                  clk,
//                  rst,
//                  sum,
//                  sum_o
//              );

endmodule

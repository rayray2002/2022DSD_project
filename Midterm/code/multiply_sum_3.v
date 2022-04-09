// `include "pipeline_reg.v"
`include "const.v"

module multiply_sum_3(
           input clk,
           input rst,
           input signed [`REG_WIDTH+5:0] multiply13_i,
           input signed [`REG_WIDTH+4:0] minus_i,

           output reg signed [`REG_WIDTH+6:0] sum_o
       );

// reg signed [`REG_WIDTH+6:0] sum;


always @(*) begin
    sum_o = multiply13_i + minus_i;
end

endmodule

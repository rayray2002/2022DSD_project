// `include "pipeline_reg.v"
`include "const.v"

module multiply_sum_2(
           input clk,
           input rst,
           input signed [`REG_WIDTH+4:0] shift2_add_i,
           input signed [`REG_WIDTH+3:0] shift2_i,
           input signed [`REG_WIDTH+1:0] add_b_i,
           input signed [`REG_WIDTH+4:0] multiply6_i,

           output reg signed [`REG_WIDTH+5:0] multiply13_o,
           output reg signed [`REG_WIDTH+4:0] minus_o
       );

// reg signed [`REG_WIDTH+5:0] multiply13;
// reg signed [`REG_WIDTH+4:0] minus;

always @(*) begin
    multiply13_o = shift2_add_i + (shift2_i<<1);
    minus_o = add_b_i - multiply6_i;
end

// always @(*) begin
// // always @(posedge clk) begin
//     if (rst) begin
//         multiply13_o <= 0;
//         minus_o <= 0;
//     end
//     else begin
//         multiply13_o <= multiply13;
//         minus_o <= minus;
//     end
// end

endmodule

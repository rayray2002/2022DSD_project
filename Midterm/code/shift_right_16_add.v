`include "const.v"

module shift_right_16_add (
           input clk,
           input rst,
           input signed [`REG_WIDTH+6:0] data_i,
           output reg signed [`REG_WIDTH+6:0] data_o
       );

parameter SHIFT = 16;

// reg signed [`REG_WIDTH+6:0] out;

always @(*) begin
    data_o = ((data_i >>> SHIFT) + data_i);
end

// always @(*) begin
// // always @(posedge clk) begin
//     if (rst) begin
//         data_o <= 0;
//     end else begin
//         data_o <= out;
//     end
// end

endmodule

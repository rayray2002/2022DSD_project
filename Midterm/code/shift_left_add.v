`include "const.v"

module shift_left_add (
           input clk,
           input rst,
           input signed [`REG_WIDTH+6:0] data_i,
           output reg signed [`REG_WIDTH+1:0] data_o
       );

parameter SHIFT = 1;

reg signed [`REG_WIDTH+6:0] out;
wire signed [`REG_WIDTH+7:0] shifted;

assign shifted = data_i << SHIFT;

always @(*) begin
    out = shifted + data_i;
end

always @(posedge clk) begin
    if (rst) begin
        data_o <= 0;
    end else begin
        data_o <= (out >>> 6);
    end
end

endmodule

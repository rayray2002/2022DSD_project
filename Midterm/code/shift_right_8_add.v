module shift_right_8_add (
           input clk,
           input rst,
           input signed [31:0] data_i,
           output reg signed [31:0] data_o
       );

parameter SHIFT = 8;

reg signed [31:0] out;

always @(*) begin
    out = ((data_i >>> SHIFT) + data_i);
end

always @(posedge clk) begin
    if (rst) begin
        data_o <= 0;
    end else begin
        data_o <= out;
    end
end

endmodule
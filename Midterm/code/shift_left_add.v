module shift_left_add (
           input clk,
           input rst,
           input signed [37:0] data_i,
           output reg signed [38:0] data_o
       );

parameter SHIFT = 1;

reg signed [37:0] out;
wire signed [38:0] shifted;

assign shifted = data_i << SHIFT;

always @(*) begin
    out = shifted + data_i;
end

always @(posedge clk) begin
    if (rst) begin
        data_o <= 0;
    end else begin
        data_o <= out;
    end
end

endmodule

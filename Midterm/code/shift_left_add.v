module shift_left_add #(parameter SHIFT = 4)(
           input clk,
           input rst,
           input signed [31:0] data_i,
           output reg signed [32:0] data_o
       );

reg signed [32:0] out;
wire signed [32:0] shifted;

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

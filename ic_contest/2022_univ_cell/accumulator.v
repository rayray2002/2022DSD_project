module accumulator (
           input clk,
           input rst,
           input [7:0] i_cost,
           input [2:0] i_count,
           output reg [7:0] o_cost
       );

reg [7:0] sum;

always @(posedge clk) begin
    if (rst) begin
        sum <= 0;
    end else begin
        sum <= i_cost + sum;
    end
end

endmodule

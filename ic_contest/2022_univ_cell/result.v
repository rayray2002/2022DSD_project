module result (
           input clk,
           input rst,
           input sumFinish,
           input [10:0] i_sum,
           output reg [3:0] matchCount,
           output reg [10:0] minCost
       );

always @(posedge sumFinish or posedge rst) begin
    if (rst) begin
        matchCount <= 0;
        minCost <= 10'b1111111111;
    end else begin
        if (i_sum < minCost) begin
            minCost <= i_sum;
            matchCount <= 1;
        end else begin
            if (i_sum == minCost) begin
                matchCount <= matchCount + 1;
            end
        end
    end
end
endmodule

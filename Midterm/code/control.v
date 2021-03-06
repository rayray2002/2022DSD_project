module control(
           input clk,
           input reset,
           input in_en,
           output out_valid,
           output [3:0] count_o
       );

parameter ITERATIONS = 12;

reg signed [ITERATIONS:0] count;

assign count_o = count[3:0];

always @(posedge clk) begin
    if (in_en|reset) begin
        count <= -1;
    end
    else begin
        count <= count + 1;
    end
end

assign out_valid = ~count[ITERATIONS] & count[ITERATIONS-1] & count[ITERATIONS-2] & count[ITERATIONS-3];

endmodule

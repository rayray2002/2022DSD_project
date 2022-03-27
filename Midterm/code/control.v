module control(
           input clk,
           input reset,
           input in_en,
           output out_valid,
           output signed [3:0] count_o
       );

reg signed [12:0] count;

assign count_o = count[3:0];

always @(posedge clk) begin
    if (in_en|reset) begin
        count <= -1;
    end
    else begin
        count <= count + 1;
    end
end

assign out_valid = ~count[12] & count[11];

endmodule

module control(
           input clk,
           input reset,
           input in_en,
           output out_valid,
           output reg signed [15:0] count
       );

// reg [12:0] count;

always @(posedge clk) begin
    if (in_en|reset) begin
        count <= -1;
    end
    else begin
        count <= count + 1;
    end
end

assign out_valid = ~count[15] & count[14];

endmodule

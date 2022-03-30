module control (
           input clk,
           input rst,
           input permute_valid,
           output out_valid,
           output [2:0] W,
           output count8
       );

reg [18:0] count;

assign W = count[2:0];
// assign out_valid = (count == 1000);
assign out_valid = count[10];
assign count8 = count[3];

always @(posedge clk) begin
    if (rst) begin
        count <= 0;
    end else begin
        if (count[4] && ~permute_valid) begin
            count <= count;
        end else begin
            count <= count + 1;
        end
    end
end
endmodule

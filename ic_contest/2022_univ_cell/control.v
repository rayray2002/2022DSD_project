module control (
           input clk,
           input rst,
           input permute_valid,
           input sum_valid,
           output reg permute_out,
           output reg sum_out,
           output out_valid,
           //    output [2:0] W,
           output reg sum_start
       );

parameter PERMUTE = 0;
parameter ACCUMULATE = 1;
parameter RESULT = 2;
reg [1:0] state;

reg [18:0] count;

assign out_valid = count[18:0] == 19'h9d7f;

always @(*) begin
    permute_out = 0;
    sum_out = 0;
    // sum_start = 0;

    if (state == PERMUTE) begin
        permute_out = 1;
    end else if (state == ACCUMULATE) begin
        // sum_start = 1;
    end else if (state == RESULT) begin
        sum_out = 1;
    end
end

always @(posedge clk) begin
    if (rst) begin
        count <= 0;
        state <= ACCUMULATE;
    end else begin
        if (state == PERMUTE) begin
            if (permute_valid) begin
                state <= ACCUMULATE;
                sum_start <= 1;
            end
        end else if (state == ACCUMULATE) begin
            sum_start <= 0;
            if (sum_valid) begin
                state <= RESULT;
            end
        end else if (state == RESULT) begin
            state <= PERMUTE;
            count <= count + 1;
        end
    end
end
endmodule

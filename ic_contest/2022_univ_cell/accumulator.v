module accumulator (
           input clk,
           input rst,
           input [7:0] i_cost,
           input sum_out,
           output reg [10:0] o_cost,
           output reg [2:0] count,
           output reg finish
       );

parameter ADD = 0;
parameter OUT = 1;

reg state;

reg [10:0] cost;

// assign finish = (state == OUT);

always @(posedge clk) begin
    if (rst) begin
        // finish <= 0;
        state <= ADD;
        count <= 0;
        cost <= 0;
        o_cost <= 0;
    end else begin
        if (state == ADD) begin
            if (count == 3'b111) begin
                state <= OUT;
                count <= 0;
            end else begin
                count <= count + 1;
            end
            finish <= 0;
            cost <= i_cost + cost;
        end else if (state == OUT) begin
            finish <= 1;
            o_cost <= cost;
            if (sum_out) begin
                cost <= 0;
                state <= ADD;
            end
        end
    end
end

endmodule

module result (
           input clk,
           input rst,
           input read,
           input [7:0] i_sum,
           output reg [3:0] o_num
       );

reg [3:0] num;
reg [7:0] sum_min;

always @(posedge clk or negedge rst) begin
    if (rst) begin
        num <= 0;
        o_num <= 0;
        sum_min <= 0;
    end else begin
       
        if (i_sum < sum_min) begin
            sum_min <= i_sum;
            num <= 1;
        end else begin
            
            if (i_sum == sum_min) begin
                num <= num + 1;
            end
        end
    end

    
    if (read) begin
        o_num <= num;
        num <= 0;
        sum_min <= 0;
    end
end
endmodule

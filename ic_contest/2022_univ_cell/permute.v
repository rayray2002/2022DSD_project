module permute (
           input [2:0] W,
           input clk,
           input rst,
           input finish,
           output valid,
           output [2:0] J
       );

parameter FIND_PIVOT = 1;
parameter SWAP = 2;
parameter REVERSE = 3;
parameter OUT = 4;

reg [2:0] permutaion [0:7];
reg [2:0] permutaion_out [0:7];
reg [3:0] pivotIndex;
reg [3:0] swapIndex;
reg [2:0] state;
integer i;

reg [7:0] tmp [0:7];

assign J = permutaion[W];
assign valid = (state == OUT);

always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i<8; i=i+1) begin
            permutaion[i] <= 7-i;
            permutaion_out[i] <= 7-i;
        end
        pivotIndex <= 0;
        swapIndex <= 0;
        state <= FIND_PIVOT;
    end else begin
        if (state == FIND_PIVOT) begin
            if (permutaion[pivotIndex] > permutaion[pivotIndex+1])
                state <= SWAP;
            pivotIndex <= pivotIndex + 1;

        end else if (state == SWAP) begin
            if (permutaion[swapIndex] > permutaion[pivotIndex]) begin
                state <= REVERSE;
                permutaion[swapIndex] <= permutaion[pivotIndex];
                permutaion[pivotIndex] <= permutaion[swapIndex];
            end else
                swapIndex <= swapIndex + 1;

        end else if (state == REVERSE) begin
            // suppose the xth to 8th need to be reversed
            case (swapIndex)
                2: begin
                    permutaion[0] <= permutaion[1];
                    permutaion[1] <= permutaion[0];
                end
                3: begin
                    permutaion[0] <= permutaion[2];
                    permutaion[2] <= permutaion[0];
                end
                4: begin
                    permutaion[0] <= permutaion[3];
                    permutaion[1] <= permutaion[2];
                    permutaion[2] <= permutaion[1];
                    permutaion[3] <= permutaion[0];
                end
                5: begin
                    permutaion[0] <= permutaion[4];
                    permutaion[1] <= permutaion[3];
                    permutaion[3] <= permutaion[1];
                    permutaion[4] <= permutaion[0];
                end
                6: begin
                    permutaion[0] <= permutaion[5];
                    permutaion[1] <= permutaion[4];
                    permutaion[2] <= permutaion[3];
                    permutaion[3] <= permutaion[2];
                    permutaion[4] <= permutaion[1];
                    permutaion[5] <= permutaion[0];
                end
                7: begin
                    permutaion[0] <= permutaion[6];
                    permutaion[1] <= permutaion[5];
                    permutaion[2] <= permutaion[4];
                    permutaion[4] <= permutaion[2];
                    permutaion[5] <= permutaion[1];
                    permutaion[6] <= permutaion[0];
                end
                default: begin
                    for (i = 0; i < 8; i = i + 1) begin
                        permutaion[i] <= permutaion[i];
                    end
                end
            endcase
            state <= OUT;
        end else begin
            if (finish) begin
                for (i = 0; i<8; i=i+1) begin
                    permutaion_out[i] <= permutaion[i];
                end
                pivotIndex <= 0;
                swapIndex <= 0;
                state <= FIND_PIVOT;
            end else
                state <= OUT;
        end
    end
end

endmodule


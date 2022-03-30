module permute (
           input [2:0] W,
           input clk,
           input rst,
           input finish,
           output valid,
           output [2:0] J
       );

parameter FIND_PIVOT = 0;
parameter SWAP = 1;
parameter REVERSE = 2;
parameter OUT = 3;

reg [2:0] permutaion [0:7];
reg [2:0] permutaion_out [0:7];
reg [2:0] pivotIndex;
reg [2:0] swapIndex;
reg [2:0] index;
reg [3:0] swapTarget;
reg [1:0] state;
integer i;

assign J = permutaion[W];
assign valid = (state == OUT);

always @(posedge clk) begin
    if (rst) begin
        for (i = 0; i < 8; i = i + 1) begin
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
            index <= pivotIndex;
            pivotIndex <= pivotIndex + 1;
            swapTarget <= 4'b1111;
            // swapIndex <= pivotIndex;

        end else if (state == SWAP) begin
            if ((permutaion[index] > permutaion[pivotIndex]) && (swapTarget > permutaion[index])) begin
                // swapTarget <= permutaion[swapIndex];
                swapIndex <= index;
                swapTarget <= permutaion[index];
                
            end else if (index == 0) begin
                permutaion[swapIndex] <= permutaion[pivotIndex];
                permutaion[pivotIndex] <= permutaion[swapIndex];
                state <= REVERSE;
            end else
                index <= index - 1;

        end else if (state == REVERSE) begin
            // suppose the xth to 8th need to be reversed
            case (pivotIndex)
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
                for (i = 0; i < 8; i = i + 1) begin
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


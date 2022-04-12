module Control(
           Op_i,
           NoOp_i,
           ALUOp_o,
           ALUSrc_o,
           RegWrite_o,
           MemRead_o,
           MemWrite_o,
           MemtoReg_o,
           Branch_o
       );

input [6: 0] Op_i;
input NoOp_i;
output reg [1: 0] ALUOp_o = 2'b0;
output reg ALUSrc_o = 1'b0; // 0: register, 1: immediate
output reg RegWrite_o = 1'b0;
output reg MemRead_o = 1'b0;
output reg MemWrite_o = 1'b0;
output reg MemtoReg_o = 1'b0;
output reg Branch_o = 1'b0;


always @ * begin
    if (NoOp_i) begin
        ALUOp_o = 2'b0;
        ALUSrc_o = 0;
        RegWrite_o = 0;
        MemRead_o = 0;
        MemWrite_o = 0;
        MemtoReg_o = 0;
        Branch_o = 0;
    end
    else begin
        case (Op_i)
            // R-type: and, xor, sub, add, mul, sll
            7'b0110011: begin
                ALUOp_o = 2'b10;
                ALUSrc_o = 0;
                RegWrite_o = 1;
                MemRead_o = 0;
                MemWrite_o = 0;
                MemtoReg_o = 0;
                Branch_o = 0;
            end

            // I-type addi, srai
            7'b0010011: begin
                ALUOp_o = 2'b01;
                ALUSrc_o = 1;
                RegWrite_o = 1;
                MemRead_o = 0;
                MemWrite_o = 0;
                MemtoReg_o = 0;
                Branch_o = 0;
            end

            // lw
            7'b0000011: begin
                ALUOp_o = 2'b00;
                ALUSrc_o = 1;
                RegWrite_o = 1;
                MemRead_o = 1;
                MemWrite_o = 0;
                MemtoReg_o = 1;
                Branch_o = 0;
            end

            // sw
            7'b0100011: begin
                ALUOp_o = 2'b00;
                ALUSrc_o = 1;
                RegWrite_o = 0;
                MemRead_o = 0;
                MemWrite_o = 1;
                // MemtoReg_o = X;
                Branch_o = 0;
            end

            // beq
            7'b1100011: begin
                ALUOp_o = 2'b11;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                MemRead_o = 0;
                MemWrite_o = 0;
                // MemtoReg_o = X;
                Branch_o = 1;
            end

            default: begin
                ALUOp_o = 2'b0;
                ALUSrc_o = 0;
                RegWrite_o = 0;
                MemRead_o = 0;
                MemWrite_o = 0;
                MemtoReg_o = 0;
                Branch_o = 0;
            end
        endcase
    end
end

endmodule

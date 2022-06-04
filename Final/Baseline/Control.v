module Control(
    Op_i,
    NoOp_i,
    jalr_o,
    jal_o,
    branch_o,
    MemRead_o,
    MemtoReg_o,
    ALUOp_o,
    MemWrite_o,
    ALUSrc_o,
    RegWrite_o 
);

input [6:0] Op_i;
input NoOp_i;
output reg jalr_o;
output reg jal_o;
output reg branch_o;
output reg MemRead_o;
output reg MemtoReg_o;
output reg [1:0] ALUOp_o;
output reg MemWrite_o;
output reg ALUSrc_o; // 0: register, 1: immediate
output reg RegWrite_o;

always @(*) begin
    ALUOp_o = Op_i[4:3];
    if (NoOp_i) begin
            jalr_o = 0;
            jal_o = 0;
            ALUOp_o = 2'b0;
            ALUSrc_o = 0;
            RegWrite_o = 0;
            MemRead_o = 0;
            MemWrite_o = 0;
            MemtoReg_o = 0;
            branch_o = 0;
        end
    else begin
        case (Op_i)
            // R-type: and, sub, add, slt
            7'b0110011: begin
                jalr_o = 0;
                jal_o = 0;
                branch_o = 0;
                MemRead_o = 0;
                MemtoReg_o = 0;
                // ALUOp_o = 2'b10;
                MemWrite_o = 0;
                ALUSrc_o = 0;
                RegWrite_o = 1;
            end

            // I-type addi, srai
            7'b0010011:
            begin
                jalr_o = 0;
                jal_o = 0;
                branch_o = 0;
                MemRead_o = 0;
                MemtoReg_o = 0;
                // ALUOp_o = 2'b10;
                MemWrite_o = 0;
                ALUSrc_o = 1;
                RegWrite_o = 1;
            end

            // sw
            7'b0100011: begin
                jalr_o = 0;
                jal_o = 0;
                branch_o = 0;
                MemRead_o = 0;
                MemtoReg_o = 0;
                // ALUOp_o = 2'b00;
                MemWrite_o = 1;
                ALUSrc_o = 1;
                RegWrite_o = 0;
            end

            // lw
            7'b0000011: begin
                jalr_o = 0;
                jal_o = 0;
                branch_o = 0;
                MemRead_o = 1;
                MemtoReg_o = 1;
                // ALUOp_o = 2'b00;
                MemWrite_o = 0;
                ALUSrc_o = 1;
                RegWrite_o = 1;
            end

            // beq
            7'b1100011: begin
                jalr_o = 0;
                jal_o = 0;
                branch_o = 1;
                MemRead_o = 0;
                MemtoReg_o = 0;
                // ALUOp_o = 2'b00;
                MemWrite_o = 0;
                ALUSrc_o = 0;
                RegWrite_o = 0;
            end

            // jal
            7'b1101111: begin
                jalr_o = 0;
                jal_o = 1;
                branch_o = 1;
                MemRead_o = 0;
                MemtoReg_o = 0;
                // ALUOp_o = 2'b00;
                MemWrite_o = 0;
                ALUSrc_o = 0;
                RegWrite_o = 1;
            end

            // jalr
            7'b1100111: begin
                jalr_o = 1;
                jal_o = 0;
                branch_o = 1;
                MemRead_o = 0;
                MemtoReg_o = 0;
                // ALUOp_o = 2'b00;
                MemWrite_o = 0;
                ALUSrc_o = 0;
                RegWrite_o = 1;
            end
            
            // noop
            default: begin
                jalr_o = 0;
                jal_o = 0;
                branch_o = 0;
                MemRead_o = 0;
                MemtoReg_o = 0;
                // ALUOp_o = 2'b00;
                MemWrite_o = 0;
                ALUSrc_o = 0;
                RegWrite_o = 0;
            end
        endcase
    end
end

endmodule

// module Control(
//         Op_i,
//         NoOp_i,
//         ALUOp_o,
//         ALUSrc_o,
//         RegWrite_o,
//         MemRead_o,
//         MemWrite_o,
//         MemtoReg_o,
//         Branch_o
//     );

//     input [6: 0] Op_i;
//     input NoOp_i;
//     output reg [1: 0] ALUOp_o = 2'b0;
//     output reg ALUSrc_o = 1'b0; // 0: register, 1: immediate
//     output reg RegWrite_o = 1'b0;
//     output reg MemRead_o = 1'b0;
//     output reg MemWrite_o = 1'b0;
//     output reg MemtoReg_o = 1'b0;
//     output reg Branch_o = 1'b0;


//     always @ *
//     begin
//         if (NoOp_i)
//         begin
//             ALUOp_o = 2'b0;
//             ALUSrc_o = 0;
//             RegWrite_o = 0;
//             MemRead_o = 0;
//             MemWrite_o = 0;
//             MemtoReg_o = 0;
//             Branch_o = 0;
//         end
//         else
//         begin
//             case (Op_i)
//                 // R-type: and, xor, sub, add, mul, sll
//                 7'b0110011:
//                 begin
//                     ALUOp_o = 2'b10;
//                     ALUSrc_o = 0;
//                     RegWrite_o = 1;
//                     MemRead_o = 0;
//                     MemWrite_o = 0;
//                     MemtoReg_o = 0;
//                     Branch_o = 0;
//                 end

//                 // I-type addi, srai
//                 7'b0010011:
//                 begin
//                     ALUOp_o = 2'b01;
//                     ALUSrc_o = 1;
//                     RegWrite_o = 1;
//                     MemRead_o = 0;
//                     MemWrite_o = 0;
//                     MemtoReg_o = 0;
//                     Branch_o = 0;
//                 end

//                 // lw
//                 7'b0000011:
//                 begin
//                     ALUOp_o = 2'b00;
//                     ALUSrc_o = 1;
//                     RegWrite_o = 1;
//                     MemRead_o = 1;
//                     MemWrite_o = 0;
//                     MemtoReg_o = 1;
//                     Branch_o = 0;
//                 end

//                 // sw
//                 7'b0100011:
//                 begin
//                     ALUOp_o = 2'b00;
//                     ALUSrc_o = 1;
//                     RegWrite_o = 0;
//                     MemRead_o = 0;
//                     MemWrite_o = 1;
//                     // MemtoReg_o = X;
//                     Branch_o = 0;
//                 end

//                 // beq
//                 7'b1100011:
//                 begin
//                     ALUOp_o = 2'b11;
//                     ALUSrc_o = 0;
//                     RegWrite_o = 0;
//                     MemRead_o = 0;
//                     MemWrite_o = 0;
//                     // MemtoReg_o = X;
//                     Branch_o = 1;
//                 end

//                 // jal
//                 7'b1101111:
//                 begin
//                     ALUOp_o = 2'bx;
//                     ALUSrc_o = 0;
//                     RegWrite_o = 0;
//                     MemRead_o = 0;
//                     MemWrite_o = 0;
//                     // MemtoReg_o = X;
//                     Branch_o = 1;
//                 end

//                 default:
//                 begin
//                     ALUOp_o = 2'b0;
//                     ALUSrc_o = 0;
//                     RegWrite_o = 0;
//                     MemRead_o = 0;
//                     MemWrite_o = 0;
//                     MemtoReg_o = 0;
//                     Branch_o = 0;
//                 end
//             endcase
//         end
//     end

// endmodule

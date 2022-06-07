module Imm_Gen (
    instruction_i,
    imm_o
);

input [31:0] instruction_i;
output reg [31:0] imm_o;

always @(*) begin
    case (instruction_i[6:0])
        // I-type
        7'b0000011, 7'b1100111: imm_o = {{20{instruction_i[31]}}, instruction_i[31:20]}; // lw
        // S-type
        7'b0100011: imm_o = {{20{instruction_i[31]}}, instruction_i[31:25], instruction_i[11:7]};
        // B-type
        7'b1100011: imm_o = {{20{instruction_i[31]}}, instruction_i[7], instruction_i[30:25], instruction_i[11:8], 1'b0};
        // J-type
        7'b1101111: imm_o = {{12{instruction_i[31]}}, instruction_i[19:12], instruction_i[20], instruction_i[30:21], 1'b0};
        default: imm_o = {{20{instruction_i[31]}}, instruction_i[31:20]};
    endcase
end

endmodule

// module Imm_Gen(
//            instr_i,
//            imm_o
//        );

// input [31: 0] instr_i;
// output reg signed [31: 0] imm_o = 32'b0;

// always @(instr_i)begin
//     casex (instr_i[6: 0])
//         7'b00x0011:
//             imm_o <= {{21{instr_i[31]}}, instr_i[30: 20]}; // I-Type, lw
//         7'b0100011:
//             imm_o <= {{21{instr_i[31]}}, instr_i[30: 25], instr_i[11: 7]}; //sw
//         7'b1100011:
//             imm_o <= {{21{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8]}; //beq
//     endcase
// end

// endmodule

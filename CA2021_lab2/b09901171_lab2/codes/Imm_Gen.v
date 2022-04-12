module Imm_Gen(
           instr_i,
           imm_o
       );

input [31: 0] instr_i;
output reg signed [31: 0] imm_o = 32'b0;

always @(instr_i)begin
    casex (instr_i[6: 0])
        7'b00x0011:
            imm_o <= {{21{instr_i[31]}}, instr_i[30: 20]}; // I-Type, lw
        7'b0100011:
            imm_o <= {{21{instr_i[31]}}, instr_i[30: 25], instr_i[11: 7]}; //sw
        7'b1100011:
            imm_o <= {{21{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8]}; //beq
    endcase
end

endmodule

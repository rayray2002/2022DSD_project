`define ADD 4'b0010
`define SUB 4'b0110
`define MUL 4'b1000

`define AND 4'b0000
`define OR  4'b0001
`define XOR 4'b1010

`define SLL 4'b1011
`define SRA 4'b1100

module ALU_Control(
           funct_i,
           ALUOp_i,
           ALUCtrl_o
       );

input [9: 0] funct_i;
input [1: 0] ALUOp_i;
output reg [3: 0] ALUCtrl_o = 4'b0;

always @ * begin
    casex ({ALUOp_i, funct_i})
        12'bx1_xxxxxxx_000:
            ALUCtrl_o <= `ADD; // addi
        12'bx1_0100000_101:
            ALUCtrl_o <= `SRA; // srai

        12'b1x_0000000_000:
            ALUCtrl_o <= `ADD; // add
        12'b1x_0100000_000:
            ALUCtrl_o <= `SUB; // sub
        12'b1x_0000001_000:
            ALUCtrl_o <= `MUL; // mul

        12'b1x_0000000_111:
            ALUCtrl_o <= `AND; // and
        12'b1x_0000000_100:
            ALUCtrl_o <= `XOR; // xor
        12'b1x_0000000_110:
            ALUCtrl_o <= `OR;  // or

        12'b1x_0000000_001:
            ALUCtrl_o <= `SLL; // sll

        12'b00_xxxxxxx_xxx:
            ALUCtrl_o <= `ADD; // lw, sw
    endcase
end

endmodule

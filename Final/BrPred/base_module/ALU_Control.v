// ALU ctrl
`define ADD 4'b0010
`define SUB 4'b0110
`define AND 4'b0000
`define OR  4'b0001
`define XOR 4'b0011
`define SLT 4'b1000
`define SLL 4'b1001
`define SRL 4'b1010
`define SRA 4'b1011

module ALU_Control(
    funct3_i,
    funct7_5_i,
    ALUOp_i,
    ALUCtrl_o
);

input  [2:0] funct3_i;
input  funct7_5_i;
input  [1:0]  ALUOp_i;
output reg [3:0]  ALUCtrl_o;

always @(*) begin
    casex ({funct7_5_i, funct3_i, ALUOp_i})
        // 6'bx_xxx_00: ALUCtrl_o = ADD;
        // 6'bx_xxx_01: ALUCtrl_o = ADD;
        // 6'b0_000_10: ALUCtrl_o = ADD;
        6'b1_000_10: ALUCtrl_o = `SUB;
        6'bx_010_10: ALUCtrl_o = `SLT;
        6'bx_100_10: ALUCtrl_o = `XOR;
        6'bx_110_10: ALUCtrl_o = `OR;
        6'bx_111_10: ALUCtrl_o = `AND;
        6'bx_001_10: ALUCtrl_o = `SLL;
        6'b0_101_10: ALUCtrl_o = `SRL;
        6'b1_101_10: ALUCtrl_o = `SRA;
        default: ALUCtrl_o = `ADD;
    endcase
end

endmodule
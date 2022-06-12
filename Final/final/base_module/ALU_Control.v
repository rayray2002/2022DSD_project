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

module ALU_Control (
    input      [2:0] funct3_i ,
    input            funct7_i ,
    input      [1:0] ALUOp_i  ,
    output reg [3:0] ALUCtrl_o
);

    always @(*)
        begin
            // $display({funct7_i, funct3_i, ALUOp_i});
            // $display("%b %b", {funct7_i, funct3_i, ALUOp_i}, ALUCtrl_o);

            if ({funct7_i, funct3_i, ALUOp_i} == 6'b000001)
                ALUCtrl_o = 4'b0010; // ADD
            else if ({funct7_i, funct3_i, ALUOp_i} == 6'b100001)
                ALUCtrl_o = 4'b0110; // SUB
            else if ({funct3_i, ALUOp_i} == 5'b00010)
                ALUCtrl_o = 4'b0010; // ADDI
            else if ({funct7_i, funct3_i, ALUOp_i} == 6'b011101)
                ALUCtrl_o = 4'b0000; // AND
            else if ({funct3_i, ALUOp_i} == 5'b11110)
                ALUCtrl_o = 4'b0000; // ANDI
            else if ({funct7_i, funct3_i, ALUOp_i} == 6'b011001)
                ALUCtrl_o = 4'b0001; // OR
            else if ({funct3_i, ALUOp_i} == 5'b11010)
                ALUCtrl_o = 4'b0001; // ORI
            else if ({funct7_i, funct3_i, ALUOp_i} == 6'b010001)
                ALUCtrl_o = 4'b0011; // XOR
            else if ({funct3_i, ALUOp_i} == 5'b10010)
                ALUCtrl_o = 4'b0011; // XORI
            else if ({funct7_i, funct3_i, ALUOp_i} == 6'b000110)
                ALUCtrl_o = 4'b1001; // SLLI
            else if ({funct7_i, funct3_i, ALUOp_i} == 6'b110110)
                ALUCtrl_o = 4'b1011; // SRAI
            else if ({funct7_i, funct3_i, ALUOp_i} == 6'b010110)
                ALUCtrl_o = 4'b1010; // SRLI
            else if ({funct7_i, funct3_i, ALUOp_i} == 6'b001001)
                ALUCtrl_o = 4'b1000; // SLT
            else if ({funct3_i, ALUOp_i} == 5'b01010)
                ALUCtrl_o = 4'b1000; // SLTI
            else if ({funct3_i, ALUOp_i} == 5'b00000)
                ALUCtrl_o = 4'b0110; // BEQ
            else
                ALUCtrl_o = 4'b0010; // default
            // $display("%b %b", {funct7_i, funct3_i, ALUOp_i}, ALUCtrl_o);
        end
endmodule

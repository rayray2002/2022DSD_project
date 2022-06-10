module PC_Control(
    input [31:0] imm_ext,
    input [31:0] PC_i,
    input [31:0] PC_branch,
    input [31:0] PC_jalr,
    input jal_i,
    input IF_jalr_i,
    input jalr_i,
    input branch,
    input miss,

    output [31:0] PC_o,
    output [31:0] PC_plus_o,
    output [31:0] PC_imm_o
);

wire [31:0] PC_1;
wire [31:0] PC_2;
wire [31:0] PC_3;

assign PC_plus_o = PC_i + 4;
assign PC_imm_o = PC_i + imm_ext;

assign PC_1 = (jal_i | branch) ? PC_imm_o : (IF_jalr_i ? PC_i : PC_plus_o);
// assign PC_2 = branch ? PC_imm : PC_plus_o;
// assign PC_2 = (miss ? PC_branch : PC_1);
// assign PC_o = jalr_i ? PC_jalr : PC_2;
assign PC_o = miss ? PC_branch : (jalr_i ? PC_jalr : PC_1);

endmodule

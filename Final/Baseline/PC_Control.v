module PC_Control(
    input [31:0] imm_ext,
    input [31:0] PC_i,
    // input [31:0] PC_ID,
    input [31:0] PC_imm,
    input [31:0] PC_jalr,
    input jal_i,
    input jalr_i,
    input branch,
    input miss,

    output [31:0] PC_o,
    output [31:0] PC_plus_o
    // output [31:0] PC_imm_o
);

wire [31:0] PC_nxt;
wire [31:0] PC_1;
wire [31:0] PC_2;
wire [31:0] PC_3;

assign PC_plus_o = PC_i + 4;
// assign PC_imm_o = PC_i + imm_ext;

assign PC_1 = (jal_i|branch) ? PC_imm : PC_plus_o;
// assign PC_2 = branch ? PC_imm : PC_plus_o;
// assign PC_2 = miss ? PC_ID : PC_1;
assign PC_o = jalr_i ? PC_jalr : PC_1;

endmodule

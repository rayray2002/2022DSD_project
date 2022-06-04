module PC_Control(
    jal_i,
    jalr_i,
    branch_i,
    zero_i,
    imm_i,
    ALU_Result,
    PC_i,
    PC_o,
    RD_o
);

input jal_i;
input jalr_i;
input branch_i;
input zero_i;
input [31:0] imm_i;
input [31:0] ALU_Result;
input [31:0] PC_i;
output reg [31:0] PC_o;
output reg [31:0] RD_o;

reg [31:0] PC_add;

always @(*) begin
    // PC_add = PC_i + 4;
    PC_add = {PC_i[31:2] + 1'b1, PC_i[1:0]};
    RD_o = PC_add;

    PC_o = PC_add;
    if (jalr_i)
        PC_o = ALU_Result;
    else if ((branch_i & zero_i) | jal_i)
        PC_o = imm_i + PC_i;
    else
        PC_o = PC_add;
end

endmodule

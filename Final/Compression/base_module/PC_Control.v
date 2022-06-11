module PC_Control (
    input  [31:0] imm_ext    ,
    input  [31:0] PC_i       ,
    input  [31:0] PC_branch  ,
    input  [31:0] PC_branch_target,
    input  [31:0] PC_jalr    ,
    input  [31:0] PC_jal     ,
    input         jal_i      ,
    input         jalr_i     ,
    input         IF_jalr_i  ,
    input         IF_jal_i   ,
    input         branch_pred,
    input         compressed ,
    input         miss       ,
    output [31:0] PC_o       ,
    output [31:0] PC_plus_o  ,
    output [31:0] PC_imm_o
);
    wire IF_jump;

    assign IF_jump = IF_jalr_i | IF_jal_i;

    assign PC_plus_o = compressed ? {PC_i[31:1]+1'b1, PC_i[0]} : {PC_i[31:2]+1'b1, PC_i[1:0]};
    // assign PC_imm_o  = PC_i + imm_ext;

    assign PC_o = miss ? PC_branch :
        (jalr_i ? PC_jalr :
            (jal_i ? PC_jal :
                (branch_pred ? PC_branch_target :
                    (IF_jump ? PC_i : PC_plus_o))));

endmodule

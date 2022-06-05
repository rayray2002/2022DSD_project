module ID_EX(
        clk_i,
        rst_i,
        ctrl_i,
        ctrl_o,
        RS1data_i,
        RS1data_o,
        RS2data_i,
        RS2data_o,
        jump_i,
        jump_o,
        pc_plus_i,
        pc_plus_o,
        imm_i,
        imm_o,
        funct_i,
        funct_o,
        RS1addr_i,
        RS1addr_o,
        RS2addr_i,
        RS2addr_o,
        RDaddr_i,
        RDaddr_o,
        Stall_i,
        flush_i
    );

    input clk_i, rst_i, Stall_i, flush_i;
    input [6: 0] ctrl_i;
    output reg [6: 0] ctrl_o;
    input [31: 0] RS1data_i;
    output reg [31: 0] RS1data_o;
    input [31: 0] RS2data_i;
    output reg [31: 0] RS2data_o;
    input jump_i;
    output reg jump_o;
    input [31: 0] pc_plus_i;
    output reg [31: 0] pc_plus_o;
    input [31: 0] imm_i;
    output reg [31: 0] imm_o;
    input [9: 0] funct_i;
    output reg [9: 0] funct_o;
    input [4: 0] RS1addr_i;
    output reg [4: 0] RS1addr_o;
    input [4: 0] RS2addr_i;
    output reg [4: 0] RS2addr_o;
    input [4: 0] RDaddr_i;
    output reg [4: 0] RDaddr_o;

    always @(posedge clk_i)
    begin
        if (Stall_i) begin
            ctrl_o <= ctrl_o;
            RS1data_o <= RS1data_o;
            RS2data_o <= RS2data_o;
            jump_o <= jump_o;
            pc_plus_o <= pc_plus_o;
            imm_o <= imm_o;
            funct_o <= funct_o;
            RS1addr_o <= RS1addr_o;
            RS2addr_o <= RS2addr_o;
            RDaddr_o <= RDaddr_o;
        end
        else if (~rst_i | flush_i) begin
            ctrl_o <= 7'b0;
            RS1data_o <= 32'b0;
            RS2data_o <= 32'b0;
            jump_o <= 1'b0;
            pc_plus_o <= 32'b0;
            imm_o <= 32'b0;
            funct_o <= 10'b0;
            RS1addr_o <= 5'b0;
            RS2addr_o <= 5'b0;
            RDaddr_o <= 5'b0;
        end
        else if (~Stall_i) begin
            ctrl_o <= ctrl_i;
            RS1data_o <= RS1data_i;
            RS2data_o <= RS2data_i;
            jump_o <= jump_i;
            pc_plus_o <= pc_plus_i;
            imm_o <= imm_i;
            funct_o <= funct_i;
            RS1addr_o <= RS1addr_i;
            RS2addr_o <= RS2addr_i;
            RDaddr_o <= RDaddr_i;
        end
    end

endmodule

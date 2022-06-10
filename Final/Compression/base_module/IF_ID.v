module IF_ID(
        clk,
        rst_n,
        instr_i,
        instr_o,
        pc_plus_i,
        pc_plus_o,
        pc_i,
        pc_o,
        BP_hit_i,
        BP_hit_o,
        Stall_i
    );

    input clk, rst_n, Stall_i;
    input [31: 0] instr_i;
    output reg [31: 0] instr_o;
    input [31: 0] pc_plus_i;
    output reg [31: 0] pc_plus_o;
    input [31: 0] pc_i;
    input BP_hit_i;
    output reg BP_hit_o;
    output reg [31: 0] pc_o;

    always @(posedge clk) begin
        if (~rst_n) begin
            instr_o <= 32'b0;
            pc_plus_o <= 32'b0;
            pc_o <= 32'b0;
            BP_hit_o <= 0;
        end
        else if (~Stall_i) begin
            instr_o <= instr_i;
            pc_plus_o <= pc_plus_i;
            pc_o <= pc_i;
            BP_hit_o <= BP_hit_i;
        end
        else begin
            instr_o <= instr_o;
            pc_plus_o <= pc_plus_o;
            pc_o <= pc_o;
            BP_hit_o <= BP_hit_o;
        end
    end

endmodule

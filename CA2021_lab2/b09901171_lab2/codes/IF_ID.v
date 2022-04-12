module IF_ID(
           clk_i,
           rst_i,
           instr_i,
           instr_o,
           pc_i,
           pc_o,
           Stall_i,
           Flush_i
       );

input clk_i, rst_i, Stall_i, Flush_i;
input [31: 0] instr_i;
output reg [31: 0] instr_o;
input [31: 0] pc_i;
output reg [31: 0] pc_o;

always @(posedge clk_i or posedge rst_i)begin
    if (rst_i) begin
        instr_o <= 32'b0;
        pc_o <= 32'b0;
    end
    else if (Flush_i) begin
        instr_o <= 32'b0;
    end
    else if (~Stall_i) begin
        instr_o <= instr_i;
        pc_o <= pc_i;
    end
end

endmodule

module MEM_WB(
        clk,
        rst_n,
        ctrl_i,
        ctrl_o,
        ALUResult_i,
        ALUResult_o,
        MemData_i,
        MemData_o,
        RDaddr_i,
        RDaddr_o,
        Stall_i
    );

    input clk, rst_n, Stall_i;
    input [1: 0] ctrl_i;
    output reg [1: 0] ctrl_o;
    input signed [31: 0] ALUResult_i;
    output reg signed [31: 0] ALUResult_o;
    input signed [31: 0] MemData_i;
    output reg signed [31: 0] MemData_o;
    input [4: 0] RDaddr_i;
    output reg [4: 0] RDaddr_o;

    always @(posedge clk) begin
        if (~rst_n) begin
            ctrl_o <= 4'b0;
            ALUResult_o <= 32'b0;
            MemData_o <= 32'b0;
            RDaddr_o <= 5'b0;
        end
        else if (~Stall_i) begin
            ctrl_o <= ctrl_i;
            ALUResult_o <= ALUResult_i;
            MemData_o <= MemData_i;
            RDaddr_o <= RDaddr_i;
        end
        else begin
            ctrl_o <= ctrl_o;
            ALUResult_o <= ALUResult_o;
            MemData_o <= MemData_o;
            RDaddr_o <= RDaddr_o;
        end
    end

endmodule

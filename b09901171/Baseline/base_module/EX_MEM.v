module EX_MEM(
        clk,
        rst_n,
        ctrl_i,
        ctrl_o,
        ALUResult_i,
        ALUResult_o,
        RS2data_i,
        RS2data_o,
        RDaddr_i,
        RDaddr_o,
        Stall_i,
        flush_i
    );

    input clk, rst_n, Stall_i, flush_i;
    input [3: 0] ctrl_i;
    output reg [3: 0] ctrl_o;
    input signed [31: 0] ALUResult_i;
    output reg signed [31: 0] ALUResult_o;
    input signed [31: 0] RS2data_i;
    output reg signed [31: 0] RS2data_o;
    input [4: 0] RDaddr_i;
    output reg [4: 0] RDaddr_o;

    always @(posedge clk) begin
        if (~rst_n) begin
            ctrl_o <= 4'b0;
            ALUResult_o <= 32'b0;
            RS2data_o <= 32'b0;
            RDaddr_o <= 5'b0;
        end
        else if (~Stall_i) begin
            ctrl_o <= ctrl_i;
            ALUResult_o <= ALUResult_i;
            RS2data_o <= RS2data_i;
            RDaddr_o <= RDaddr_i;
        end
        else if (flush_i) begin
            ctrl_o <= 4'b0;
            ALUResult_o <= 32'b0;
            RS2data_o <= 32'b0;
            RDaddr_o <= 5'b0;
        end
        else begin
            ctrl_o <= ctrl_o;
            ALUResult_o <= ALUResult_o;
            RS2data_o <= RS2data_o;
            RDaddr_o <= RDaddr_o;
        end
    end

endmodule

module PC
    (
        clk,
        rst_n,
        stall_i,
        PCWrite_i,
        pc_i,
        pc_o
    );

    // Ports
    input               clk;
    input               rst_n;
    input               stall_i;
    input               PCWrite_i;
    input   [31:0]      pc_i;
    output  [31:0]      pc_o;

    // Wires & Registers
    reg     [31:0]      pc_o;


    always@(posedge clk) begin
        if(~rst_n)
            pc_o <= 32'b0;
        else if (PCWrite_i && ~stall_i) //  && PCWrite_i ~stall_i &&
            pc_o <= pc_i;
        else
            pc_o <= pc_o;
    end

endmodule

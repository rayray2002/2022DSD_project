`include "const.v"

module b_register (
           input clk,
           input wen,
           input rst,
           input signed [15:0] b_i,
           output signed [15:0] b_o
       );

// wire & reg declarations
reg signed [15:0] registers [0:15];
integer i, tmp;

// combinational logic

// sequential logic
always @(posedge clk) begin
    if (rst)
        for (i = 0; i < 16; i = i + 1) begin
            registers[i] <= 0;
        end
    else begin
        if (wen)
            registers[0] <= b_i;
        else
            registers[0] <= registers[`STEP];

        // rotate registers
        for (i = 1; i < 16; i = i + 1) begin
            tmp = (i+`STEP)%16;
            registers[i] <= registers[tmp];
        end
    end
end

// assign
assign b_o = registers[0];

endmodule

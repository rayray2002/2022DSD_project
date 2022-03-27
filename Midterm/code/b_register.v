module b_register (
           input clk,
           input wen,
           input rst,
           input signed [15: 0] b_i,
           output signed [15:0] b_o
       );

// wire & reg declarations
reg signed [15:0] registers [0:15];
integer i;

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
            registers[0] <= registers[1];

        // rotate registers
        for (i = 1; i < 15; i = i + 1) begin
            registers[i] <= registers[i+1];
        end
        registers[15] <= registers[0];
    end
end

// assign
assign b_o = registers[15];

endmodule

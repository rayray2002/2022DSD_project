`include "const.v"

module b_register (
           input clk,
           input wen,
           input rst,
           input [3:0] count,
           input signed [15:0] b_i,
           output signed [15:0] b_o
       );

// wire & reg declarations
reg signed [15:0] registers [0:15];
wire count4;
integer i, tmp;

assign count4 = count[1] & count[0];

// combinational logic

// sequential logic
always @(posedge clk) begin
    if (rst)
        for (i = 0; i < 16; i = i + 1) begin
            registers[i] <= 0;
        end
    else begin
        if (wen) begin
            registers[0] <= b_i;

            for (i = 1; i < 16; i = i + 1) begin
                tmp = (i+1)%16;
                registers[i] <= registers[tmp];
            end
        end else begin
            // registers[0] <= registers[`STEP];

            // rotate registers
            if (~count4) begin
                for (i = 0; i < 16; i = i + 1) begin
                    tmp = (i+`STEP)%16;
                    registers[i] <= registers[tmp];
                end
            end else begin
                if (count[3]&count[2]&count[1]&count[0]) begin
                    for (i = 0; i < 16; i = i + 1) begin
                        tmp = (i+1)%16;
                        registers[i] <= registers[tmp];
                    end
                end else begin
                    for (i = 0; i < 16; i = i + 1) begin
                        tmp = (i+`STEP+1)%16;
                        registers[i] <= registers[tmp];
                    end
                end
            end
        end
    end
end

// assign
assign b_o = registers[13];

endmodule

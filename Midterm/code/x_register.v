// `include "pipeline_reg.v"

module x_register (
           input clk,
           input rst,
           input signed [31:0] dataTarget_i,
           output signed [31:0] dataTarget_o,

           output reg signed [31:0] dataP1_o,
           output reg signed [31:0] dataM1_o,
           output reg signed [31:0] dataP2_o,
           output reg signed [31:0] dataM2_o,
           output reg signed [31:0] dataP3_o,
           output reg signed [31:0] dataM3_o,

           output signed [31:0] data_o
       );

// parameters
parameter TARGET = 7;

// wire & reg declarations
reg signed [31:0] registers [0:15];
integer i;

// combinational logic

// sequential logic
always @(posedge clk) begin
    if (rst)
        for (i = 0; i < 16; i = i + 1) begin
            // registers[i] <= (i+1)<<16;
            registers[i] <= 32'b0;
        end
    else begin
        registers[TARGET-1] <= dataTarget_i;

        // rotate registers
        for (i = 0; i < 15; i = i + 1) begin
            if (i != TARGET-1)
                registers[i] <= registers[i+1];
        end
        registers[15] <= registers[0];
    end
end

always @(posedge clk) begin
    if (rst) begin
        dataP1_o <= 0;
        dataP2_o <= 0;
        dataP3_o <= 0;
        dataM1_o <= 0;
        dataM2_o <= 0;
        dataM3_o <= 0;
    end
    else begin
        dataP1_o <= registers[1];
        dataP2_o <= registers[2];
        dataP3_o <= registers[3];
        dataM1_o <= registers[15];
        dataM2_o <= registers[14];
        dataM3_o <= registers[13];
    end
end

// assign
assign dataTarget_o = registers[TARGET];
assign data_o = registers[15];

endmodule

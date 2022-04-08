// `include "pipeline_reg.v"
`include "const.v"

module x_register (
           input clk,
           input rst,
           input signed [`REG_WIDTH:0] dataTarget_i,
           output signed [`REG_WIDTH:0] dataTarget_o,

           output reg signed [`REG_WIDTH:0] dataP1_o,
           output reg signed [`REG_WIDTH:0] dataM1_o,
           output reg signed [`REG_WIDTH:0] dataP2_o,
           output reg signed [`REG_WIDTH:0] dataM2_o,
           output reg signed [`REG_WIDTH:0] dataP3_o,
           output reg signed [`REG_WIDTH:0] dataM3_o,

           output signed [`REG_WIDTH:0] data_o
       );

parameter PREV = (`TARGET-`STEP>=0) ? `TARGET-`STEP : `TARGET-`STEP+16;

// wire & reg declarations
reg signed [`REG_WIDTH:0] registers [0:15];
integer i;
integer tmp;

// combinational logic

// sequential logic
always @(posedge clk) begin
    if (rst)
        for (i = 0; i < 16; i = i + 1) begin
            registers[i] <= 0;
        end
    else begin
        registers[PREV] <= dataTarget_i;

        // rotate registers
        for (i = 0; i < 16; i = i + 1) begin
            if (i != PREV) begin
                tmp = (i+`STEP)%16;
                registers[i] <= registers[tmp];
            end
        end
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
assign dataTarget_o = registers[`TARGET];
assign data_o = registers[15][`REG_WIDTH:`REG_WIDTH-31];

endmodule

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
parameter TARGET = 9;

// wire & reg declarations
reg signed [31:0] registers [0:15];
integer i;

// combinational logic

// sequential logic
always @(posedge clk) begin
    if (rst)
        for (i = 0; i < 16; i = i + 1) begin
            registers[i] <= i+1;
            // registers[i] <= 32'b0;
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

// instances
// pipeline_reg P1(
//                  clk,
//                  rst,
//                  registers[1],
//                  dataP1_o
//              );

// pipeline_reg P2(
//                  clk,
//                  rst,
//                  registers[2],
//                  dataP2_o
//              );

// pipeline_reg P3(
//                  clk,
//                  rst,
//                  registers[3],
//                  dataP3_o
//              );

// pipeline_reg M1(
//                  clk,
//                  rst,
//                  registers[15],
//                  dataM1_o
//              );

// pipeline_reg M2(
//                  clk,
//                  rst,
//                  registers[14],
//                  dataM2_o
//              );

// pipeline_reg M3(
//                  clk,
//                  rst,
//                  registers[13],
//                  dataM3_o
//              );

// assign
assign dataTarget_o = registers[TARGET];
assign data_o = registers[0];

endmodule

`include "pipeline_reg.v"

module add_prev_next(
           input clk,
           input rst,
           input [3:0] count,
           input signed [`REG_WIDTH:0] dataP1_i,
           input signed [`REG_WIDTH:0] dataM1_i,
           input signed [`REG_WIDTH:0] dataP2_i,
           input signed [`REG_WIDTH:0] dataM2_i,
           input signed [`REG_WIDTH:0] dataP3_i,
           input signed [`REG_WIDTH:0] dataM3_i,

           output reg signed [`REG_WIDTH+1:0] data1_o,
           output reg signed [`REG_WIDTH+1:0] data2_o,
           output reg signed [`REG_WIDTH+1:0] data3_o
       );

reg signed [`REG_WIDTH:0] dataP1;
reg signed [`REG_WIDTH:0] dataM1;
reg signed [`REG_WIDTH:0] dataP2;
reg signed [`REG_WIDTH:0] dataM2;
reg signed [`REG_WIDTH:0] dataP3;
reg signed [`REG_WIDTH:0] dataM3;
reg signed [`REG_WIDTH+1:0] data1;
reg signed [`REG_WIDTH+1:0] data2;
reg signed [`REG_WIDTH+1:0] data3;

always @(*) begin
    dataP3 = (count[3] & count[2] & (count[1] | count[0])) ? 0 : dataP3_i;
    dataP2 = (count[3] & count[2] & count[1]) ? 0 : dataP2_i;
    dataP1 = (count[3] & count[2] & count[1] & count[0]) ? 0 : dataP1_i;

    dataM3 = ~count[3] & ~count[2] & ~(count[1] & count[0]) ? 0 : dataM3_i;
    dataM2 = ~count[3] & ~count[2] & ~count[1] ? 0 : dataM2_i;
    dataM1 = ~count[3] & ~count[2] & ~count[1] & ~count[0] ? 0 : dataM1_i;

    data1 = dataP1 + dataM1;
    data2 = dataP2 + dataM2;
    data3 = dataP3 + dataM3;
end

always @(posedge clk) begin
    if (rst) begin
        data1_o <= 0;
        data2_o <= 0;
        data3_o <= 0;
    end
    else begin
        data1_o <= data1;
        data2_o <= data2;
        data3_o <= data3;
    end
end


// pipeline_reg D1(
//                  clk,
//                  rst,
//                  data1,
//                  data1_o
//              );

// pipeline_reg D2(
//                  clk,
//                  rst,
//                  data2,
//                  data2_o
//              );

// pipeline_reg D3(
//                  clk,
//                  rst,
//                  data3,
//                  data3_o
//              );

endmodule

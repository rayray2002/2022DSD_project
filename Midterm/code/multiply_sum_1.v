// `include "pipeline_reg.v"
`include "const.v"

module multiply_sum_1(
           input clk,
           input rst,
           input signed [15:0] b_i,
           input signed [`REG_WIDTH+1:0] data1_i,
           input signed [`REG_WIDTH+1:0] data2_i,
           input signed [`REG_WIDTH+1:0] data3_i,

           output reg signed [`REG_WIDTH+4:0] shift2_add_o,
           output reg signed [`REG_WIDTH+3:0] shift2_o,
           output reg signed [`REG_WIDTH+1:0] add_b_o,
           output reg signed [`REG_WIDTH+4:0] multiply6_o
       );

reg signed [`REG_WIDTH+4:0] shift2_add;
reg signed [`REG_WIDTH+3:0] shift2;
reg signed [`REG_WIDTH+1:0] add_b;
reg signed [`REG_WIDTH+4:0] multiply6;

always @(*) begin
    shift2 = data1_i << 2;
    shift2_add = data1_i + shift2;

    add_b = data3_i + (b_i<<(`REG_WIDTH-15));

    multiply6 = (data2_i<<1) + (data2_i<<2);
end

always @(posedge clk) begin
    if (rst) begin
        shift2_add_o <= 0;
        shift2_o <= 0;
        add_b_o <= 0;
        multiply6_o <= 0;
    end
    else begin
        shift2_add_o <= shift2_add;
        shift2_o <= shift2;
        add_b_o <= add_b;
        multiply6_o <= multiply6;
    end
end

// pipeline_reg D1(
//                  clk,
//                  rst,
//                  shift2_add,
//                  shift2_add_o
//              );

// pipeline_reg D2(
//                  clk,
//                  rst,
//                  shift2,
//                  shift2_o
//              );

// pipeline_reg D3(
//                  clk,
//                  rst,
//                  add_b,
//                  add_b_o
//              );

// pipeline_reg D4(
//                  clk,
//                  rst,
//                  multiply6,
//                  multiply6_o
//              );

endmodule

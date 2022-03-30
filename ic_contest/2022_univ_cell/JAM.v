`include "control.v"
`include "accumulator.v"
`include "permute.v"
`include "result.v"

module JAM (
           input CLK,
           input RST,
           output [2:0] W,
           output [2:0] J,
           input [7:0] Cost,
           output [3:0] MatchCount,
           output [10:0] MinCost,
           output Valid
       );

wire permute_valid, sumFinish, permute_out, sum_start, sum_out;
wire [10:0] totalCost;

permute permute (
            W(W),
            .clk(CLK),
            .rst(RST),
            .valid(permute_valid),
            .J(J),
            .finish(sum_start)
        );

accumulator accumulator (
                .clk(CLK),
                .rst(RST),
                .i_cost(Cost),
                .count(W),
                .o_cost(totalCost),
                .sum_out(sum_out),
                .finish(sumFinish)
            );

control control (
            .clk(CLK),
            .rst(RST),
            .permute_valid(permute_valid),
            .sum_valid(sumFinish),
            .out_valid(Valid),
            .permute_out(permute_out),
            .sum_out(sum_out),
            .sum_start(sum_start)
        );

result result (
           .clk(CLK),
           .rst(RST),
           .sumFinish(sumFinish),
           .i_sum(totalCost),
           .matchCount(MatchCount),
           .minCost(MinCost)
       );

endmodule



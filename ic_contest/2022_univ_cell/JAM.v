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
           output [9:0] MinCost,
           output Valid
       );

reg t_valid;

wire permute_valid, count8;
wire [9:0] totalCost;


permute permute (
            .W(W),
            .clk(CLK),
            .rst(RST),
            .valid(permute_valid),
            .J(J),
            .finish(count8)
        );

accumulator accumulator (
                .clk(CLK),
                .rst(RST),
                .i_cost(Cost),
                .i_count(W),
                .o_cost()
            );

control control (
            .clk(CLK),
            .rst(RST),
            .permute_valid(permute_valid),
            .W(W),
            .out_valid(Valid),
            .count8(count8)
        );

endmodule



`ifndef _PIPELINE_REG_V_
`define _PIPELINE_REG_V_

module pipeline_reg(
           input clk,
           input rst,
           input [`REG_WIDTH:0] data_i,
           output reg [`REG_WIDTH:0] data_o
       );

always @(posedge clk) begin
    if (rst) begin
        data_o <= 0;
    end
    else begin
        data_o <= data_i;
    end
end

endmodule

`endif

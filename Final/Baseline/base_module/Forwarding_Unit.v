module Forwarding_Unit (
    input      [4:0] RS1_i         ,
    input      [4:0] RS2_i         ,
    input      [4:0] MEM_RD_i      ,
    input      [4:0] WB_RD_i       ,
    input            MEM_RegWrite_i,
    input            WB_RegWrite_i ,
    output reg [1:0] FowardA_o     ,
    output reg [1:0] FowardB_o
);

    always @(*) begin
        if (MEM_RegWrite_i && MEM_RD_i != 0 && MEM_RD_i == RS1_i)
            FowardA_o = 2'b10;
        else if (WB_RegWrite_i && WB_RD_i != 0 && WB_RD_i == RS1_i)
            FowardA_o = 2'b01;
        else
            FowardA_o = 2'b00;

        if (MEM_RegWrite_i && MEM_RD_i != 0 && MEM_RD_i == RS2_i)
            FowardB_o = 2'b10;
        else if (WB_RegWrite_i && WB_RD_i != 0 && WB_RD_i == RS2_i)
            FowardB_o = 2'b01;
        else
            FowardB_o = 2'b00;
    end

endmodule

module MUX4 (
    input      [31:0] data00_i,
    input      [31:0] data01_i,
    input      [31:0] data10_i,
    input      [31:0] data11_i,
    input      [ 1:0] select_i,
    output reg [31:0] data_o
);

    always @(*) begin
        case (select_i)
            2'b00   : data_o = data00_i;
            2'b01   : data_o = data01_i;
            2'b10   : data_o = data10_i;
            default : data_o = data11_i;
        endcase
    end

endmodule

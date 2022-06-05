module MUX4 (
        data00_i,
        data01_i,
        data10_i,
        data11_i,
        select_i,
        data_o
    );

    input [31: 0] data00_i, data01_i, data10_i, data11_i;
    input [1: 0] select_i;
    output reg [31: 0] data_o;

    always @(*) begin
        case (select_i)
            2'b00: data_o = data00_i;
            2'b01: data_o = data01_i;
            2'b10: data_o = data10_i;
            2'b11: data_o = data11_i;
        endcase
    end

endmodule

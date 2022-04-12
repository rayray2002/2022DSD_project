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
output [31: 0] data_o;

wire [31: 0] o1, o2;

MUX32 MUX1(data00_i, data01_i, select_i[0], o1);
MUX32 MUX2(data10_i, data11_i, select_i[0], o2);
MUX32 MUX3(o1, o2, select_i[1], data_o);

endmodule

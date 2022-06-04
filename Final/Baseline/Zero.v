module Zero (
           RS1data_i,
           RS2data_i,
           Branch_i,
           Flush_o
       );

input [31:0] RS1data_i, RS2data_i;
input Branch_i;
output Flush_o;

assign Flush_o = (RS1data_i == RS2data_i) & Branch_i;

endmodule

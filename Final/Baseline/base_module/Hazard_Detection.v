module Hazard_Detection (
           ID_RS1_i,
           ID_RS2_i,
           EX_RDaddr_i,
           EX_MEMRead_i,
           NoOP_o,
           PCWrite_o,
           Stall_o
       );

input [4:0] ID_RS1_i, ID_RS2_i, EX_RDaddr_i;
input EX_MEMRead_i;
output NoOP_o;
output PCWrite_o;
output Stall_o;

assign NoOP_o = EX_MEMRead_i & (EX_RDaddr_i == ID_RS1_i | EX_RDaddr_i == ID_RS2_i);
assign Stall_o = NoOP_o;
assign PCWrite_o = ~Stall_o;

endmodule

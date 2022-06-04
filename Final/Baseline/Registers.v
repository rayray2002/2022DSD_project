module Registers
(
    clk,
    rst_n,
    RS1addr_i,
    RS2addr_i,
    RDaddr_i, 
    RDdata_i,
    RegWrite_i, 
    RS1data_o, 
    RS2data_o
);

// Ports
input               clk;
input               rst_n;
input   [4:0]       RS1addr_i;
input   [4:0]       RS2addr_i;
input   [4:0]       RDaddr_i;
input signed  [31:0]      RDdata_i;
input               RegWrite_i;
output signed [31:0]      RS1data_o; 
output signed [31:0]      RS2data_o;

// Register File
reg signed [31:0]      register        [0:31];

integer i;

// Read Data      
assign  RS1data_o = register[RS1addr_i];
assign  RS2data_o = register[RS2addr_i];

// Write Data   
always @(posedge clk) begin
    if (~rst_n)
        for (i = 0; i < 32; i = i + 1) 
            register[i] <= 32'b0;

    else if (RegWrite_i && RDaddr_i) 
        register[RDaddr_i] <= RDdata_i;
end

   
endmodule 

// module Registers
// (
//     clk_i,
//     RS1addr_i,
//     RS2addr_i,
//     RDaddr_i, 
//     RDdata_i,
//     RegWrite_i, 
//     RS1data_o, 
//     RS2data_o 
// );

// // Ports
// input               clk_i;
// input   [4:0]       RS1addr_i;
// input   [4:0]       RS2addr_i;
// input   [4:0]       RDaddr_i;
// input   [31:0]      RDdata_i;
// input               RegWrite_i;
// output  [31:0]      RS1data_o; 
// output  [31:0]      RS2data_o;

// // Register File
// reg signed    [31:0]      register        [0:31];

// // Read Data      
// assign  RS1data_o = (RS1addr_i == RDaddr_i && RegWrite_i && RS1addr_i != 0)? RDdata_i : register[RS1addr_i];
// assign  RS2data_o = (RS2addr_i == RDaddr_i && RegWrite_i && RS2addr_i != 0)? RDdata_i : register[RS2addr_i];

// // Write Data   
// always@(posedge clk_i) begin
//     if(RegWrite_i && RDaddr_i != 0)
//         register[RDaddr_i] <= RDdata_i;
// end

// endmodule 

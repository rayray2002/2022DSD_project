`define ADD 4'b0010
`define SUB 4'b0110
`define MUL 4'b1000

`define AND 4'b0000
`define OR  4'b0001
`define XOR 4'b1010

`define SLL 4'b1011
`define SRA 4'b1100

module ALU(
           data1_i,
           data2_i,
           ALUCtrl_i,
           data_o,
           Zero_o
       );

input signed [31: 0] data1_i;
input signed [31: 0] data2_i;
input [3: 0] ALUCtrl_i;
output reg signed [31: 0] data_o;
output Zero_o;

assign Zero_o = (data_o == 0);

always @ * begin
    case (ALUCtrl_i)
        `ADD:
            data_o <= data1_i + data2_i;
        `SUB:
            data_o <= data1_i - data2_i;
        `MUL:
            data_o <= data1_i * data2_i;

        `AND:
            data_o <= data1_i & data2_i;
        `OR:
            data_o <= data1_i | data2_i;
        `XOR:
            data_o <= data1_i ^ data2_i;

        `SLL:
            data_o <= data1_i << data2_i;
        `SRA:
            data_o <= data1_i >>> data2_i[4: 0];
    endcase
end

endmodule

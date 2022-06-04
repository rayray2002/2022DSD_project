// ALU ctrl
`define ADD 4'b0010
`define SUB 4'b0110
`define AND 4'b0000
`define OR  4'b0001
`define XOR 4'b0011
`define SLT 4'b1000
`define SLL 4'b1001
`define SRL 4'b1010
`define SRA 4'b1011

module ALU(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o,
    Zero_o
);

input signed [31:0] data1_i; 
input signed [31:0] data2_i;
input  [3:0]  ALUCtrl_i;
output reg signed [31:0] data_o;
output Zero_o;

wire signed [31:0] Adder_o;
wire [32:0] data1_extend;
wire [32:0] data2_extend;
wire overflow;
wire neg;

assign neg = ALUCtrl_i[3] || ALUCtrl_i[2];

assign data1_extend = {data1_i[31], data1_i};
assign data2_extend = {data2_i[31], data2_i} ^ {33{neg}};

assign {overflow, Adder_o} = data1_extend + data2_extend + neg;

assign Zero_o = (data_o == 0);

always @(*) begin
    case(ALUCtrl_i)
        `ADD, `SUB: data_o = Adder_o;
        `AND: data_o = data1_i & data2_i;
        `OR: data_o = data1_i | data2_i;
        `XOR: data_o = data1_i ^ data2_i;
        `SLT: data_o = overflow;
    
        `SLL: data_o = data1_i << data2_i[4:0];
        `SRL: data_o = data1_i >> data2_i[4:0];
        `SRA: data_o = data1_i >>> data2_i[4:0];

        default: data_o = Adder_o;
    endcase
end

endmodule


module CPU (
           clk_i,
           rst_i,
           start_i,

           mem_data_i, 
            mem_ack_i,     
            mem_data_o, 
            mem_addr_o,     
            mem_enable_o, 
            mem_write_o
       );

// Ports
input clk_i ;
input rst_i ;
input start_i;

input [256-1:0] mem_data_i;
input mem_ack_i;
output [256-1:0] mem_data_o;
output [32-1:0] mem_addr_o;  
output mem_enable_o;
output mem_write_o;

// IF
wire [31: 0] IF_pc_i, IF_pc_o, IF_instr, IF_pc4;

// ID
wire [31: 0] ID_instr;
wire signed [31: 0] ID_RS1data, ID_RS2data, ID_imm_ext, ID_pc_o, ID_branch_addr;
wire [6: 0] ID_ctrl;
wire NoOP, PCWrite, Stall, Flush, Branch;

// EX
wire signed [31: 0] EX_RS1data, EX_RS2data, EX_imm_ext, EX_ALUdata1, EX_ALU_data2, EX_ALURS2, EX_ALUResult;
wire [9: 0] EX_funct;
wire [6: 0] EX_ctrl;
wire [4: 0] EX_RDaddr, EX_RS1addr, EX_RS2addr;
wire [3: 0] EX_ALUCtrl;
wire [1: 0] EX_ALUOp, EX_FowardA, EX_FowardB;
wire EX_zero;

// Mem
wire signed [31: 0] MEM_ALUResult, MEM_RS2data, MEM_MemData;
wire [4: 0] MEM_RDaddr;
wire [3: 0] MEM_ctrl;
wire MEM_Stall;

// WB
wire signed [31: 0] WB_ALUResult, WB_MemData, WB_RDdata;
wire [4: 0] WB_RDaddr;
wire [1: 0] WB_ctrl;

// IF stage
MUX32 MUX_PC (
          .data1_i (IF_pc4),
          .data2_i (ID_branch_addr),
          .select_i(Flush),
          .data_o (IF_pc_i)
      );

Adder Add_PC (
          .data1_in(IF_pc_o),
          .data2_in(4 ),
          .data_o (IF_pc4)
      );

PC PC (
       .clk_i (clk_i ),
       .rst_i (rst_i ),
       .start_i(start_i),
       .PCWrite_i(PCWrite),
       .pc_i (IF_pc_i ),
       .pc_o (IF_pc_o ),
       .stall_i (MEM_Stall)
   );

Instruction_Memory Instruction_Memory (
                       .addr_i (IF_pc_o ),
                       .instr_o(IF_instr)
                   );

IF_ID IF_ID (
          .clk_i(clk_i),
          .rst_i (rst_i ),
          .instr_i(IF_instr),
          .instr_o(ID_instr),
          .pc_i(IF_pc_o),
          .pc_o(ID_pc_o),
          .Stall_i(Stall | MEM_Stall),
          .Flush_i(Flush)
      );

// ID stage
Registers Registers (
              .clk_i (clk_i ),
              .RS1addr_i (ID_instr[19: 15]),
              .RS2addr_i (ID_instr[24: 20]),
              .RDaddr_i  (WB_RDaddr ),
              .RDdata_i  (WB_RDdata ),
              .RegWrite_i(WB_ctrl[0] ),
              .RS1data_o (ID_RS1data ),
              .RS2data_o (ID_RS2data )
          );

Imm_Gen Imm_Gen (
            .instr_i(ID_instr),
            .imm_o(ID_imm_ext)
        );

Control Control (
            .Op_i (ID_instr[6: 0]),
            .NoOp_i(NoOP),
            .RegWrite_o(ID_ctrl[0]),
            .MemtoReg_o(ID_ctrl[1]),
            .MemRead_o (ID_ctrl[2]),
            .MemWrite_o(ID_ctrl[3]),
            .ALUOp_o (ID_ctrl[5: 4]),
            .ALUSrc_o (ID_ctrl[6]),
            .Branch_o (Branch)
        );

Adder Add_addr (
          .data1_in(ID_imm_ext << 1),
          .data2_in(ID_pc_o),
          .data_o (ID_branch_addr)
      );

Zero Zero (
         .RS1data_i(ID_RS1data),
         .RS2data_i(ID_RS2data),
         .Branch_i(Branch),
         .Flush_o(Flush)
     );

Hazard_Detection Hazard_Detection (
                     .RS1_i(ID_instr[19: 15]),
                     .RS2_i(ID_instr[24: 20]),
                     .EX_RDaddr_i(EX_RDaddr),
                     .EX_MEMRead_i(EX_ctrl[2]),
                     .NoOP_o(NoOP),
                     .PCWrite_o(PCWrite),
                     .Stall_o(Stall)
                 );

ID_EX ID_EX(
          .clk_i(clk_i),
          .rst_i(rst_i),
          .ctrl_i(ID_ctrl),
          .ctrl_o(EX_ctrl),
          .RS1data_i(ID_RS1data),
          .RS1data_o(EX_RS1data),
          .RS2data_i(ID_RS2data),
          .RS2data_o(EX_RS2data),
          .imm_i(ID_imm_ext),
          .imm_o(EX_imm_ext),
          .funct_i({ID_instr[31: 25], ID_instr[14: 12]}),
          .funct_o(EX_funct),
          .RS1addr_i(ID_instr[19: 15]),
          .RS1addr_o(EX_RS1addr),
          .RS2addr_i(ID_instr[24: 20]),
          .RS2addr_o(EX_RS2addr),
          .RDaddr_i(ID_instr[11: 7]),
          .RDaddr_o(EX_RDaddr),
          .Stall_i(MEM_Stall)
      );

// EX stage
Forwarding_Unit Forwarding_Unit (
                    .RS1_i(EX_RS1addr),
                    .RS2_i(EX_RS2addr),
                    .MEM_RD_i(MEM_RDaddr),
                    .WB_RD_i(WB_RDaddr),
                    .MEM_RegWrite_i(MEM_ctrl[0]),
                    .WB_RegWrite_i(WB_ctrl[0]),
                    .FowardA_o(EX_FowardA),
                    .FowardB_o(EX_FowardB)
                );

MUX4 MUXA (
         .data00_i(EX_RS1data),
         .data01_i(WB_RDdata),
         .data10_i(MEM_ALUResult),
         .select_i(EX_FowardA),
         .data_o(EX_ALUdata1)
     );

MUX4 MUXB (
         .data00_i(EX_RS2data),
         .data01_i(WB_RDdata),
         .data10_i(MEM_ALUResult),
         .select_i(EX_FowardB),
         .data_o(EX_ALURS2)
     );

MUX32 MUX_ALUSrc (
          .data1_i (EX_ALURS2),
          .data2_i (EX_imm_ext ),
          .select_i(EX_ctrl[6]),
          .data_o (EX_ALU_data2 )
      );

ALU ALU (
        .data1_i (EX_ALUdata1 ),
        .data2_i (EX_ALU_data2 ),
        .ALUCtrl_i(EX_ALUCtrl ),
        .data_o (EX_ALUResult),
        .Zero_o (EX_zero )
    );

ALU_Control ALU_Control (
                .funct_i (EX_funct),
                .ALUOp_i (EX_ctrl[5: 4]),
                .ALUCtrl_o(EX_ALUCtrl)
            );

EX_MEM EX_MEM (
           .clk_i(clk_i),
           .rst_i(rst_i),
           .ctrl_i(EX_ctrl[3: 0]),
           .ctrl_o(MEM_ctrl),
           .ALUResult_i(EX_ALUResult),
           .ALUResult_o(MEM_ALUResult),
           .RS2data_i(EX_ALURS2),
           .RS2data_o(MEM_RS2data),
           .RDaddr_i(EX_RDaddr),
           .RDaddr_o(MEM_RDaddr),
           .Stall_i(MEM_Stall)
       );

// Mem stage
dcache_controller dcache (
    // System clock, reset and stall
    .clk_i(clk_i), 
    .rst_i(rst_i),
    
    // to Data Memory interface        
    .mem_data_i(mem_data_i), 
    .mem_ack_i(mem_ack_i),     
    .mem_data_o(mem_data_o), 
    .mem_addr_o(mem_addr_o),     
    .mem_enable_o(mem_enable_o), 
    .mem_write_o(mem_write_o),
    
    // to CPU interface    
    .cpu_data_i(MEM_RS2data), 
    .cpu_addr_i(MEM_ALUResult),     
    .cpu_MemRead_i(MEM_ctrl[2]), 
    .cpu_MemWrite_i(MEM_ctrl[3]), 
    .cpu_data_o(MEM_MemData), 
    .cpu_stall_o(MEM_Stall)
);

// Data_Memory Data_Memory (
//                 .clk_i (clk_i ),
//                 .addr_i (MEM_ALUResult),
//                 .MemRead_i (MEM_ctrl[2] ),
//                 .MemWrite_i(MEM_ctrl[3] ),
//                 .data_i (MEM_RS2data ),
//                 .data_o (MEM_MemData )
//             );

MEM_WB MEM_WB(
           .clk_i(clk_i),
           .rst_i(rst_i),
           .ctrl_i(MEM_ctrl[1: 0]),
           .ctrl_o(WB_ctrl),
           .ALUResult_i(MEM_ALUResult),
           .ALUResult_o(WB_ALUResult),
           .MemData_i(MEM_MemData),
           .MemData_o(WB_MemData),
           .RDaddr_i(MEM_RDaddr),
           .RDaddr_o(WB_RDaddr),
           .Stall_i(MEM_Stall)
       );

// WB stage
MUX32 MUX_RegSrc (
          .data1_i (WB_ALUResult),
          .data2_i (WB_MemData ),
          .select_i(WB_ctrl[1] ),
          .data_o (WB_RDdata )
      );

endmodule


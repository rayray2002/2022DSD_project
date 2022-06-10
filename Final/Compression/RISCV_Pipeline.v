`include "config.v"

module RISCV_Pipeline (
        input         clk,
        input         rst_n,
        /*I_cache interface*/
        output        ICACHE_ren,
        output        ICACHE_wen,
        output [30:0] ICACHE_addr,
        output [31:0] ICACHE_wdata,
        input         ICACHE_stall,
        input  [31:0] ICACHE_rdata,
        /*D_cache interface*/
        output        DCACHE_ren,
        output        DCACHE_wen,
        output [29:0] DCACHE_addr,
        output [31:0] DCACHE_wdata,
        input         DCACHE_stall,
        input  [31:0] DCACHE_rdata,
        //--------------PC-----------------
		output [31:0] PC
    );

    // IF
    wire [31: 0] IF_pc_i, IF_pc_o, IF_instr, IF_instr_raw, IF_pc_plus, IF_pc_imm, IF_imm;
    wire IF_jal, IF_jalr, IF_BPHit, IF_compressed;

    // ID
    wire [31: 0] ID_instr, ID_pc_plus, ID_pc_imm, ID_pc;
    wire signed [31: 0] ID_RS1data, ID_RS2data, ID_imm_ext, ID_pc_o;
    wire [6: 0] ID_ctrl;
    wire [4: 0] ID_RS1addr, ID_RS2addr;
    wire [1: 0] ID_Foward1, ID_Foward2;
    wire NoOP, PCWrite, Stall, Flush, Branch, ID_jalr, jal, Branch_taken, ID_BPHit;

    assign ID_RS1addr = ID_instr[19: 15];
    assign ID_RS2addr = ID_instr[24: 20];

    // EX
    wire [31: 0] EX_pc_plus, EX_ALUResult_final, EX_pc_imm, EX_imm_addr, EX_RS1data_jalr, EX_jalr_addr;
    wire [31: 0] EX_RS1data, EX_RS2data, EX_imm_ext, EX_ALUdata1, EX_ALU_data2, EX_ALURS2, EX_ALUResult;
    wire [9: 0] EX_funct;
    wire [6: 0] EX_ctrl;
    wire [4: 0] EX_RDaddr, EX_RS1addr, EX_RS2addr;
    wire [3: 0] EX_ALUCtrl;
    wire [1: 0] EX_ALUOp, EX_FowardA, EX_FowardB, EX_Op;
    wire EX_zero, EX_jump, EX_Branch, EX_func3_0, EX_jalr, EX_miss, EX_BPHit;

    // Mem
    wire signed [31: 0] MEM_ALUResult, MEM_RS2data, MEM_MemData;
    wire [4: 0] MEM_RDaddr;
    wire [3: 0] MEM_ctrl;
    wire MEM_Stall;

    // WB
    wire signed [31: 0] WB_ALUResult, WB_MemData, WB_RDdata;
    wire [4: 0] WB_RDaddr;
    wire [1: 0] WB_ctrl;

    // Assign
    assign ICACHE_ren  	= 1'b1;
    assign ICACHE_wen  	= 1'b0;
    assign ICACHE_addr 	= IF_pc_o[31:1];//[31:2];
    assign ICACHE_wdata = 32'd0;
    assign MEM_Stall = ICACHE_stall | DCACHE_stall;
    assign IF_instr_raw = {ICACHE_rdata[7:0], ICACHE_rdata[15:8], ICACHE_rdata[23:16], ICACHE_rdata[31:24]};

    assign DCACHE_ren = MEM_ctrl[2];
    assign DCACHE_wen = MEM_ctrl[3];
    assign DCACHE_addr = MEM_ALUResult[31:2];
    assign DCACHE_wdata = {MEM_RS2data[7:0], MEM_RS2data[15:8], MEM_RS2data[23:16], MEM_RS2data[31:24]};
    // assign DCACHE_wdata = MEM_RS2data; //MEM_MemData;// MEM_RS2data;//
    assign MEM_MemData = {DCACHE_rdata[7:0], DCACHE_rdata[15:8], DCACHE_rdata[23:16], DCACHE_rdata[31:24]};

    assign PC = IF_pc_o;

    // IF stage
    // MUX32 MUX_PC (
    //           .data1_i (IF_pc4),
    //           .data2_i (ID_branch_addr),
    //           .select_i(Flush),
    //           .data_o (IF_pc_i)
    //       );

    // Adder Add_PC (
    //           .data1_in(IF_pc_o),
    //           .data2_in(4 ),
    //           .data_o (IF_pc4)
    //       );

    assign IF_jal = (IF_instr[4:3] == 2'b01);
    assign IF_jalr = (IF_instr[4:2] == 3'b001);
    assign IF_branch = (IF_instr[6:2] == 5'b11000);
    PC_Control PC_Control(
            .imm_ext(IF_imm),
            .PC_i(IF_pc_o),
            .PC_branch(EX_imm_addr),
            .PC_jalr(EX_jalr_addr),
            .jal_i(IF_jal),
            .IF_jalr_i(IF_jalr|ID_jalr),
            .jalr_i(EX_jalr),
            .branch(IF_BPHit),
            .compressed(IF_compressed),
            .miss(EX_miss),
            .PC_o(IF_pc_i),
            .PC_plus_o(IF_pc_plus),
            .PC_imm_o(IF_pc_imm)
        );

    PC PC_module (
           .clk(clk ),
           .rst_n(rst_n ),
           .PCWrite_i(PCWrite),
           .pc_i (IF_pc_i ),
           .pc_o (IF_pc_o ),
           .stall_i (MEM_Stall)
       );

    Decompressor Decompressor (
        .PC_2(IF_pc_o[1]),
        .inst_raw(IF_instr_raw),
        .inst(IF_instr),
        .compr(IF_compressed)
    );

    BrPred_local_2bit #(
        .NUM_INDEX_BIT(4)
    ) BrPred(
        .clk               (clk),
        .rst_n             (rst_n),
        .branch            (IF_branch),
    
        .BranchTaken_i     (Branch_taken),
        .miss              (EX_miss),
        .WriteAddr_i       (EX_pc_plus),
    
        .ReadAddr_i        (IF_pc_plus),
        .Hit_o             (IF_BPHit)
    );
    
    Jump_Imm_Gen Jump_Imm_Gen(
        .instruction_i(IF_instr),
        .imm_o(IF_imm)
    );

    IF_ID IF_ID (
              .clk(clk),
              .rst_n (rst_n ),
              .instr_i((EX_jalr | ID_jalr | EX_miss) ? 32'b0 : IF_instr),
              .instr_o(ID_instr),
              .pc_plus_i(IF_pc_plus),
              .pc_plus_o(ID_pc_plus),
              .pc_i(IF_pc_imm),
              .pc_o(ID_pc_imm),
              .BP_hit_i(IF_BPHit),
              .BP_hit_o(ID_BPHit),
              .Stall_i(Stall | MEM_Stall)
          );

    // ID stage
    Registers Registers (
                  .clk       (clk ),
                  .rst_n     (rst_n),
                  .RS1addr_i (ID_RS1addr),
                  .RS2addr_i (ID_RS2addr),
                  .RDaddr_i  (WB_RDaddr ),
                  .RDdata_i  (WB_RDdata ),
                  .RegWrite_i(WB_ctrl[0] ),
                  .RS1data_o (ID_RS1data ),
                  .RS2data_o (ID_RS2data )
              );

    // Forwarding_Unit Forwarding_Unit_ID (
    //             .RS1_i(ID_RS1addr),
    //             .RS2_i(),
    //             .MEM_RD_i(EX_RDaddr),
    //             .WB_RD_i(MEM_RDaddr),
    //             .MEM_RegWrite_i(EX_ctrl[0]),
    //             .WB_RegWrite_i(MEM_ctrl[0]),
    //             .FowardA_o(ID_Foward1),
    //             .FowardB_o()
    //         );
    // MUX4 MUX_RS1 (
    //         .data00_i(ID_RS1data),
    //         .data01_i(MEM_ALUResult),
    //         .data10_i(EX_ALUResult_final),
    //         .data11_i(),
    //         .select_i(ID_Foward1),
    //         .data_o(ID_RS1data_jalr)
    //     );

    // MUX4 MUX_RS2 (
    //         .data00_i(ID_RS2data_raw),
    //         .data01_i(MEM_ALUResult),
    //         .data10_i(EX_ALUResult_final),
    //         .data11_i(),
    //         .select_i(ID_Foward2),
    //         .data_o(ID_RS2data)
    //     );

    Imm_Gen Imm_Gen (
                .instruction_i(ID_instr),
                .imm_o(ID_imm_ext)
            );

    Control Control (
                .Op_i (ID_instr[6: 0]),
                .NoOp_i(NoOP),
                .jalr_o(ID_jalr),
                .jal_o(jal),
                .RegWrite_o(ID_ctrl[0]),
                .MemtoReg_o(ID_ctrl[1]),
                .MemRead_o (ID_ctrl[2]),
                .MemWrite_o(ID_ctrl[3]),
                .ALUOp_o (ID_ctrl[5: 4]),
                .ALUSrc_o (ID_ctrl[6]),
                .branch_o (Branch)
            );

    // Adder Add_imm_addr (
    //           .data1_in(ID_imm_ext),
    //           .data2_in(ID_pc),
    //           .data_o (ID_imm_addr)
    //       );

    Hazard_Detection Hazard_Detection (
            .ID_RS1_i(ID_instr[19: 15]),
            .ID_RS2_i(ID_instr[24: 20]),
            .EX_RDaddr_i(EX_RDaddr),
            .EX_MEMRead_i(EX_ctrl[2]),

            .NoOP_o(NoOP),
            .PCWrite_o(PCWrite),
            .Stall_o(Stall)
        );

    ID_EX ID_EX(
              .clk(clk),
              .rst_n(rst_n),
              .ctrl_i(ID_ctrl),
              .ctrl_o(EX_ctrl),
              .RS1data_i(ID_RS1data),
              .RS1data_o(EX_RS1data),
              .RS2data_i(ID_RS2data),
              .RS2data_o(EX_RS2data),
              .jump_i(ID_jalr|jal),
              .jump_o(EX_jump),
              .jalr_i(ID_jalr),
              .jalr_o(EX_jalr),
              .branch_i(Branch),
              .branch_o(EX_Branch),
              .func3_0_i(ID_instr[12]),
              .func3_0_o(EX_func3_0),
              .pc_imm_i(ID_pc_imm),
              .pc_imm_o(EX_pc_imm),
              .pc_plus_i(ID_pc_plus),
              .pc_plus_o(EX_pc_plus),
              .BP_hit_i(ID_BPHit),
              .BP_hit_o(EX_BPHit),
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
              .Stall_i(MEM_Stall),
              .flush_i(EX_miss),
              .Op_i(ID_instr[4:3]),
              .Op_o(EX_Op)
          );

    // EX stage
    assign EX_imm_addr = Branch_taken ? EX_pc_imm : EX_pc_plus;
    
    Forwarding_Unit Forwarding_Unit_EX (
        .RS1_i(EX_RS1addr),
        .RS2_i(EX_RS2addr),
        .MEM_RD_i(MEM_RDaddr),
        .WB_RD_i(WB_RDaddr),
        .MEM_RegWrite_i(MEM_ctrl[0]),
        .WB_RegWrite_i(WB_ctrl[0]),
        .FowardA_o(EX_FowardA),
        .FowardB_o(EX_FowardB)
        );
        
    // assign EX_ALUdata1 = EX_RS1data;
    // assign EX_ALURS2 = EX_RS2data;
    assign EX_ALU_data2 = EX_ctrl[6] ? EX_imm_ext : EX_ALURS2;

    MUX4 MUXA (
             .data00_i(EX_RS1data),
             .data01_i(WB_RDdata),
             .data10_i(MEM_ALUResult),
             .data11_i(32'b0),
             .select_i(EX_FowardA),
             .data_o(EX_ALUdata1)
         );

    MUX4 MUXB (
             .data00_i(EX_RS2data),
             .data01_i(WB_RDdata),
             .data10_i(MEM_ALUResult),
             .data11_i(32'b0),
             .select_i(EX_FowardB),
             .data_o(EX_ALURS2)
         );

    Adder Add_jalr_addr (
        .data1_in(EX_imm_ext),
        .data2_in(EX_ALUdata1),
        .data_o (EX_jalr_addr)
    );

    Compare Compare (
            .equal_i(EX_ALUdata1 == EX_ALU_data2),
            .func3_0_i(EX_func3_0),
            .branch_i(EX_Branch),
            .branch_taken_o(Branch_taken)
        );
    assign EX_miss = EX_BPHit ^ Branch_taken;

    // MUX32 MUX_ALUSrc (
    //           .data1_i (EX_ALURS2),
    //           .data2_i (EX_imm_ext ),
    //           .select_i(EX_ctrl[6]),
    //           .data_o (EX_ALU_data2 )
    //       );

    ALU ALU (
            .data1_i (EX_ALUdata1 ),
            .data2_i (EX_ALU_data2 ),
            .ALUCtrl_i(EX_ALUCtrl ),
            .data_o (EX_ALUResult),
            .Zero_o (EX_zero )
        );

    ALU_Control ALU_Control (
        .funct3_i (EX_funct[2:0]),
        .funct7_i(EX_funct[8]),
        .ALUOp_i (EX_Op),
        .ALUCtrl_o(EX_ALUCtrl)
    );

    assign EX_ALUResult_final = EX_jump ? EX_pc_plus : EX_ALUResult;
    EX_MEM EX_MEM (
               .clk(clk),
               .rst_n(rst_n),
               .ctrl_i(EX_ctrl[3: 0]),
               .ctrl_o(MEM_ctrl),
               .ALUResult_i(EX_ALUResult_final),
               .ALUResult_o(MEM_ALUResult),
               .RS2data_i(EX_ALURS2),
               .RS2data_o(MEM_RS2data),
               .RDaddr_i(EX_RDaddr),
               .RDaddr_o(MEM_RDaddr),
               .Stall_i(MEM_Stall),
               .flush_i(EX_miss)
           );

    // Mem stage
    MEM_WB MEM_WB(
               .clk(clk),
               .rst_n(rst_n),
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
    assign WB_RDdata = WB_ctrl[1] ? WB_MemData : WB_ALUResult;
    // MUX32 MUX_RegSrc (
    //           .data1_i (WB_ALUResult),
    //           .data2_i (WB_MemData ),
    //           .select_i(WB_ctrl[1] ),
    //           .data_o (WB_RDdata )
    //       );

endmodule

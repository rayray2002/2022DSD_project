`include "RISCV_Pipeline.v"
`include "cache_sram_l1.v"
`include "I_cache_2way.v"
`include "D_cache_2way.v"
// `include "cache_D.v"
// `include "cache_I.v"
// `include "cache_2way.v"

// Top module of your design, you cannot modify this module!!
module CHIP (	clk,
              rst_n,
              //----------for slow_memD------------
              mem_read_D,
              mem_write_D,
              mem_addr_D,
              mem_wdata_D,
              mem_rdata_D,
              mem_ready_D,
              //----------for slow_memI------------
              mem_read_I,
              mem_write_I,
              mem_addr_I,
              mem_wdata_I,
              mem_rdata_I,
              mem_ready_I,
              //----------for TestBed--------------
              DCACHE_addr,
              DCACHE_wdata,
              DCACHE_wen,
              PC
            );
input			clk, rst_n;
//--------------------------

output			mem_read_D;
output			mem_write_D;
output	[31:4]	mem_addr_D;
output	[127:0]	mem_wdata_D;
input	[127:0]	mem_rdata_D;
input			mem_ready_D;
//--------------------------
output			mem_read_I;
output			mem_write_I;
output	[31:4]	mem_addr_I;
output	[127:0]	mem_wdata_I;
input	[127:0]	mem_rdata_I;
input			mem_ready_I;
//----------for TestBed--------------
output	[29:0]	DCACHE_addr;
output	[31:0]	DCACHE_wdata;
output			DCACHE_wen;
output	[31:0]	PC;
//--------------------------

// wire declaration
wire        ICACHE_ren;
wire        ICACHE_wen;
wire [30:0] ICACHE_addr;
wire [31:0] ICACHE_wdata;
wire        ICACHE_stall;
wire [31:0] ICACHE_rdata;

wire        DCACHE_ren;
wire        DCACHE_wen;
wire [29:0] DCACHE_addr;
wire [31:0] DCACHE_wdata;
wire        DCACHE_stall;
wire [31:0] DCACHE_rdata;
wire [31:0] PC;


//=========================================
// Note that the overall design of your RISCV includes:
// 1. pipelined RISCV processor
// 2. data cache
// 3. instruction cache


RISCV_Pipeline i_RISCV(
                   // control interface
                   .clk            (clk)           ,
                   .rst_n          (rst_n)         ,
                   //----------I cache interface-------
                   .ICACHE_ren     (ICACHE_ren)    ,
                   .ICACHE_wen     (ICACHE_wen)    ,
                   .ICACHE_addr    (ICACHE_addr)   ,
                   .ICACHE_wdata   (ICACHE_wdata)  ,
                   .ICACHE_stall   (ICACHE_stall)  ,
                   .ICACHE_rdata   (ICACHE_rdata)  ,
                   //----------D cache interface-------
                   .DCACHE_ren     (DCACHE_ren)    ,
                   .DCACHE_wen     (DCACHE_wen)    ,
                   .DCACHE_addr    (DCACHE_addr)   ,
                   .DCACHE_wdata   (DCACHE_wdata)  ,
                   .DCACHE_stall   (DCACHE_stall)  ,
                   .DCACHE_rdata   (DCACHE_rdata)	,
                   //--------------PC-----------------
                   .PC(PC)
               );


D_cache D_cache(
            .clk          (clk)         ,
            .proc_reset_i (~rst_n)      ,
            .proc_read_i  (DCACHE_ren)  ,
            .proc_write_i (DCACHE_wen)  ,
            .proc_addr_i  (DCACHE_addr) ,
            .proc_rdata_o (DCACHE_rdata),
            .proc_wdata_i (DCACHE_wdata),
            .proc_stall_o (DCACHE_stall),
            .mem_read_o   (mem_read_D)  ,
            .mem_write_o  (mem_write_D) ,
            .mem_addr_o   (mem_addr_D)  ,
            .mem_wdata_o  (mem_wdata_D) ,
            .mem_rdata_i  (mem_rdata_D) ,
            .mem_ready_i  (mem_ready_D)
        );

I_cache I_cache(
            .clk          (clk)         ,
            .proc_reset_i (~rst_n)      ,
            .proc_read_i  (ICACHE_ren)  ,
            .proc_write_i (ICACHE_wen)  ,
            .proc_addr_i  (ICACHE_addr) ,
            .proc_rdata_o (ICACHE_rdata),
            .proc_wdata_i (ICACHE_wdata),
            .proc_stall_o (ICACHE_stall),
            .mem_read_o   (mem_read_I)  ,
            .mem_write_o  (mem_write_I) ,
            .mem_addr_o   (mem_addr_I)  ,
            .mem_wdata_o  (mem_wdata_I) ,
            .mem_rdata_i  (mem_rdata_I) ,
            .mem_ready_i  (mem_ready_I)
        );

endmodule

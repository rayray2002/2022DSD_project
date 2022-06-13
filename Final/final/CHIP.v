`include "RISCV_Pipeline.v"
`include "cache_sram_l1.v"
`include "cache_sram_l2.v"
`include "I_cache_2way.v"
`include "D_cache_2way.v"
`include "L2cache.v"

// `define L2

// Top module of your design, you cannot modify this module!!
module CHIP ( clk,
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

wire           L1i_read ;
wire           L1i_write;
wire   [ 27:0] L1i_addr ;
wire   [127:0] L1i_wdata;
wire   [127:0] L1i_rdata;
wire           L1i_ready;

wire           L1d_read ;
wire           L1d_write;
wire   [ 27:0] L1d_addr ;
wire   [127:0] L1d_wdata;
wire   [127:0] L1d_rdata;
wire           L1d_ready;


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

`ifdef L2
D_cache D_cache(
            .clk          (clk)         ,
            .proc_reset_i (~rst_n)      ,
            .proc_read_i  (DCACHE_ren)  ,
            .proc_write_i (DCACHE_wen)  ,
            .proc_addr_i  (DCACHE_addr) ,
            .proc_rdata_o (DCACHE_rdata),
            .proc_wdata_i (DCACHE_wdata),
            .proc_stall_o (DCACHE_stall),
            .mem_read_o   (L1d_read)  ,
            .mem_write_o  (L1d_write) ,
            .mem_addr_o   (L1d_addr)  ,
            .mem_wdata_o  (L1d_wdata) ,
            .mem_rdata_i  (L1d_rdata) ,
            .mem_ready_i  (L1d_ready)
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
            .mem_read_o   (L1i_read)  ,
            .mem_write_o  (L1i_write) ,
            .mem_addr_o   (L1i_addr)  ,
            .mem_wdata_o  (L1i_wdata) ,
            .mem_rdata_i  (L1i_rdata) ,
            .mem_ready_i  (L1i_ready)
        );


L2cache L2cache (
            .clk         (clk)        ,
            .proc_reset  (~rst_n),
            .L1i_read_i  (L1i_read) ,
            .L1i_write_i (L1i_write),
            .L1i_addr_i  (L1i_addr) ,
            .L1i_wdata_i (L1i_wdata),
            .L1i_rdata_o (L1i_rdata),
            .L1i_ready   (L1i_ready) ,
            .memi_read   (mem_read_I)  ,
            .memi_write  (mem_write_I) ,
            .memi_addr   (mem_addr_I)  ,
            .memi_wdata  (mem_wdata_I) ,
            .memi_rdata  (mem_rdata_I) ,
            .memi_ready  (mem_ready_I),
            .L1d_read_i  (L1d_read) ,
            .L1d_write_i (L1d_write),
            .L1d_addr_i  (L1d_addr),
            .L1d_wdata_i (L1d_wdata),
            .L1d_rdata_o (L1d_rdata),
            .L1d_ready   (L1d_ready) ,
            .memd_read   (mem_read_D)  ,
            .memd_write  (mem_write_D) ,
            .memd_addr   (mem_addr_D)  ,
            .memd_wdata  (mem_wdata_D) ,
            .memd_rdata  (mem_rdata_D) ,
            .memd_ready  (mem_ready_D)
        );
`else
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
`endif

endmodule

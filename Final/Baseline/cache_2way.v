module cache(
           clk,
           proc_reset,
           proc_read,
           proc_write,
           proc_addr,
           proc_rdata,
           proc_wdata,
           proc_stall,
           mem_read,
           mem_write,
           mem_addr,
           mem_rdata,
           mem_wdata,
           mem_ready
       );

//==== input/output definition ============================
input          clk;
// processor interface
input          proc_reset;
input          proc_read, proc_write;
input   [29:0] proc_addr;
input   [31:0] proc_wdata;
output         proc_stall;
output  [31:0] proc_rdata;
// memory interface
input  [127:0] mem_rdata;
input          mem_ready;
output reg        mem_read, mem_write;
output reg [27:0] mem_addr;
output reg [127:0] mem_wdata;

//==== wire/reg definition ================================
parameter IDLE = 2'b00;
parameter MISS = 2'b01;
parameter WRITE_BACK = 2'b10;
parameter ALLOCATE = 2'b11;

reg      [27:0]    tag [0:3][0:1]; // 27: valid, 26: dirty
reg      [127:0]   data[0:3][0:1];
reg LRU[0:3];
reg [1:0] state;
reg wait_mem;

wire hit0, hit1, hit;
wire request;
wire [25:0] addr_tag;
wire [1:0] addr_index;
wire [1:0] addr_offset;
wire [6:0] bit_offset;
wire [27:0] mem_raddr;
wire [27:0] mem_waddr;

wire [25:0] hit_rtag;
wire [127:0] hit_rdata;
reg [127:0] hit_wdata;

integer i, j;
//==== combinational circuit ==============================
assign request = proc_write | proc_read;

assign addr_tag = proc_addr[29:4];
assign addr_index = proc_addr[3:2];
assign addr_offset = proc_addr[1:0];

assign hit0 = tag[addr_index][0][27] & (tag[addr_index][0][25:0] == addr_tag);
assign hit1 = tag[addr_index][1][27] & (tag[addr_index][1][25:0] == addr_tag);
assign hit = hit0 | hit1;

assign proc_stall = (~hit | wait_mem) & request;

assign hit_rtag = hit1 ? tag[addr_index][1] : (hit0 ? tag[addr_index][0] : tag[addr_index][LRU[addr_index]]);
assign hit_rdata = hit1 ? data[addr_index][1] : (hit0 ? data[addr_index][0] : data[addr_index][LRU[addr_index]]);
assign bit_offset = addr_offset << 5;
assign proc_rdata = hit_rdata[bit_offset +: 32];

assign mem_raddr = proc_addr >> 2;
assign mem_waddr = {hit_rtag, addr_index};

always@(*) begin
    hit_wdata = hit ? hit_rdata : mem_rdata;
    hit_wdata[bit_offset +: 32] = proc_wdata;
end

always@(*) begin
    mem_read = 0;
    mem_write = 0;
    mem_wdata = 0;
    mem_addr = 0;
    wait_mem = 0;
    case (state)
        IDLE: begin
            mem_read = 0;
            mem_write = 0;
            mem_wdata = 0;
            mem_addr = 0;
            wait_mem = 0;
        end
        MISS: begin
            mem_read = 0;
            mem_write = 0;
            mem_wdata = 0;
            mem_addr = 0;
            wait_mem = 1;
        end
        WRITE_BACK: begin
            mem_read = 0;
            mem_write = 1;
            mem_wdata = data[addr_index][LRU[addr_index]];
            mem_addr = mem_waddr;
            wait_mem = 1;
        end
        ALLOCATE: begin
            mem_read = 1;
            mem_write = 0;
            mem_wdata = 0;
            mem_addr = mem_raddr;
            wait_mem = 1;
        end
    endcase
end

//==== sequential circuit =================================
always@(posedge clk) begin
    if (proc_reset) begin
        state <= IDLE;
        for (i=0;i<4;i=i+1) begin
            LRU[i] <= 0;
            for (j=0;j<2;j=j+1) begin
                tag[i][j] <= 0;
                data[i][j] <= 0;
            end
        end
    end
    else begin
        case (state)
            IDLE: begin
                if (request & ~hit) begin
                    state <= MISS;
                end else begin
                    state <= IDLE;
                    if (proc_write) begin
                        tag[addr_index][hit1][26] <= 1'b1;
                        data[addr_index][hit1] <= hit_wdata;

                    end
                    if (request)
                        LRU[addr_index] <= hit0;
                end
            end
            MISS: begin
                if (tag[addr_index][LRU[addr_index]][26]) begin
                    state <= WRITE_BACK;
                end else begin
                    state <= ALLOCATE;
                end
            end
            WRITE_BACK: begin
                if (mem_ready) begin
                    state <= ALLOCATE;
                end else begin
                    state <= WRITE_BACK;
                end
            end
            ALLOCATE: begin
                if (mem_ready) begin
                    tag[addr_index][LRU[addr_index]] <= {1'b1, proc_write, addr_tag};
                    data[addr_index][LRU[addr_index]] <= proc_read ? mem_rdata : hit_wdata;
                    LRU[addr_index] <= ~LRU[addr_index];
                    state <= IDLE;
                end else begin
                    state <= ALLOCATE;
                end
            end
        endcase
    end
end

endmodule

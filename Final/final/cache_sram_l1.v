module cache_sram_2way (
    input          clk    ,
    input          rst    ,
    input  [ 29:0] addr_i ,
    input  [155:0] wdata_i,
    input          write_i,
    output [155:0] rdata_o,
    output         hit_o
);

    integer i, j;

//// Wire/Reg Declaration ////
// input address
    wire [25:0] tag_i;
    wire [ 1:0] index;

// valid(1), dirty(1), tag(26), word0(32), word1(32), word2(32), word3(32)
    reg [155:0] sram[0:3][0:1];

    reg  lru    [0:3]; // lru[index]: the next way to be write back
    wire way         ;
    wire lru_nxt     ;

    wire hit[0:1];

//// Combinational Logic ////
// word address: tag(26), index(2), offset(2)
    assign tag_i = addr_i[29:4];
    assign index = addr_i[3:2];

    assign rdata_o = sram[index][way];
    assign hit_o   = hit[0] || hit[1];

    assign lru_nxt = ~way;

    assign way = hit[0] ? 0 : (hit[1] ? 1 : lru[index]);

    assign hit[0] = sram[index][0][155]&(sram[index][0][153:128] == tag_i);
    assign hit[1] = sram[index][1][155]&(sram[index][1][153:128] == tag_i);

//// Sequential Logic ////
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1) begin
                for (j = 0; j < 2; j = j + 1) begin
                    sram[i][j] <= 0;
                end
                lru[i] <= 0;
            end
        end
        else if (write_i) begin
            sram[index][way] <= wdata_i;
            lru[index]       <= lru_nxt;
        end
    end

endmodule
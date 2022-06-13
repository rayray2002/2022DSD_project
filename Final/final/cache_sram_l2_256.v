module cache_sram_l2 (
    input          clk    ,
    input          rst    ,
    input  [ 27:0] addr_i ,
    input  [153:0] wdata_i,
    input          write_i,
    input          I_D    ,
    output [153:0] rdata_o,
    output         hit_o
);

    integer i, j;

//// Wire/Reg Declaration ////
// input address
    wire [22:0] tag_i;
    wire [ 4:0] index;

// I/D(1), valid(1), dirty(1), tag(23), data(32*4)
    reg [153:0] sram[0:31][0:1];

    reg  lru    [0:31]; // lru[index]: the next way to be write back
    wire lru_nxt      ;
    wire way          ;

    wire hit[0:1];

//// Combinational Logic ////
// word address: tag(26), index(2), offset(2)
    assign tag_i = addr_i[27:5];
    assign index = addr_i[4:0];

    assign rdata_o = sram[index][way];
    assign hit_o   = hit[0] || hit[1];

    assign lru_nxt = ~way;

    assign way = hit[0] ? 0 : (hit[1] ? 1 : lru[index]);

    assign hit[0] = sram[index][0][152] && (sram[index][0][150:128] == tag_i) && (I_D == sram[index][0][153]);
    assign hit[1] = sram[index][1][152] && (sram[index][1][150:128] == tag_i) && (I_D == sram[index][1][153]);

//// Sequential Logic ////
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1) begin
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
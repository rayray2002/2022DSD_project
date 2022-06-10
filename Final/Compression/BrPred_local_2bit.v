module BrPred_local_2bit(
    input                  clk,
    input                  rst_n,
    input branch,

    input                  BranchTaken_i,
    input                  miss,
    input         [31:0]   WriteAddr_i,

    input         [31:0]   ReadAddr_i,
    output                 Hit_o
);

parameter  NUM_INDEX_BIT   = 3;
localparam NUM_ENTRY       = 1 << NUM_INDEX_BIT;

localparam S_NONTAKEN      = 0;
localparam S_NEAR_NONTAKEN = 1;
localparam S_NEAR_TAKEN    = 2;
localparam S_TAKEN         = 3;


reg [1:0]  predict     [0:NUM_ENTRY-1];
reg [1:0]  predict_nxt [0:NUM_ENTRY-1];

wire [NUM_INDEX_BIT-1:0] read_index;
wire [NUM_INDEX_BIT-1:0] write_index;

integer i;


//// Combinational ////


assign Hit_o = branch &
    (predict[read_index] == S_TAKEN
    || predict[read_index] == S_NEAR_TAKEN);

assign read_index = ReadAddr_i[NUM_INDEX_BIT+1:2];
assign write_index = WriteAddr_i[NUM_INDEX_BIT+1:2];

always @* begin
    for (i = 0; i < NUM_ENTRY; i = i + 1) begin
        predict_nxt[i] = predict[i];
    end

    if (miss) begin
        if (BranchTaken_i) begin
            case (predict[write_index])
                S_NONTAKEN, S_NEAR_NONTAKEN: begin
                    predict_nxt[write_index] = S_NEAR_NONTAKEN;
                end
                S_NEAR_NONTAKEN: begin
                    predict_nxt[write_index] = S_NEAR_TAKEN;
                end
                default: begin
                    predict_nxt[write_index] = S_TAKEN;
                end
            endcase
        end
        else begin
            case (predict[write_index])
                default: begin
                    predict_nxt[write_index] = S_NONTAKEN;
                end
                S_NEAR_TAKEN: begin
                    predict_nxt[write_index] = S_NEAR_NONTAKEN;
                end
                S_TAKEN: begin
                    predict_nxt[write_index] = S_NEAR_TAKEN;
                end
            endcase
        end
    end
end

//// Sequntial ////

always @(posedge clk) begin
    for (i = 0; i < NUM_ENTRY; i = i + 1) begin
        if (~rst_n) begin
            predict[i] <= S_NEAR_TAKEN;
        end
        else begin
            if (miss) begin
                predict[i] <= predict_nxt[i];
            end
        end
    end
end

endmodule

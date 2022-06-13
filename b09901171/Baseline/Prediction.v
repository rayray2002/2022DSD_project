module Prediction (
    input         clk           ,
    input         rst_n         ,
    input         miss          ,
    input         BranchTaken_i ,
    input  [31:0] WriteAddr_i   ,
    input  [31:0] WriteTarget_i ,
    input  [31:0] ReadAddr_2_i  ,
    output [31:0] ReadTarget_2_o,
    input  [31:0] ReadAddr_4_i  ,
    output [31:0] ReadTarget_4_o,
    output        Hit_2_o       ,
    output        Hit_4_o
);

    parameter  NUM_INDEX_BIT = 2                 ;
    localparam NUM_ENTRY     = 1 << NUM_INDEX_BIT;

    localparam S_NONTAKEN      = 0;
    localparam S_NEAR_NONTAKEN = 1;
    localparam S_NEAR_TAKEN    = 2;
    localparam S_TAKEN         = 3;

    reg [31:0] target    [0:NUM_ENTRY-1];
    reg [31:0] target_nxt[0:NUM_ENTRY-1];

    reg [30-NUM_INDEX_BIT:0] tag [0:NUM_ENTRY-1];
    reg [30-NUM_INDEX_BIT:0] tag_nxt [0:NUM_ENTRY-1];

    reg [1:0] predict    [0:NUM_ENTRY-1];
    reg [1:0] predict_nxt[0:NUM_ENTRY-1];

    wire [NUM_INDEX_BIT-1:0] read_index_2;
    wire [NUM_INDEX_BIT-1:0] read_index_4;

    wire [30-NUM_INDEX_BIT:0] read_tag_2;
    wire [30-NUM_INDEX_BIT:0] read_tag_4;

    wire [NUM_INDEX_BIT-1:0] write_index ;

    integer i;


//// Combinational ////

    assign ReadTarget_2_o = target[read_index_2];
    assign ReadTarget_4_o = target[read_index_4];

    assign Hit_2_o = 
    (tag[read_index_2] == read_tag_2) &
        (predict[read_index_2] == S_TAKEN
            || predict[read_index_2] == S_NEAR_TAKEN);

    assign Hit_4_o = 
    (tag[read_index_4] == read_tag_4) &
        (predict[read_index_4] == S_TAKEN
            || predict[read_index_4] == S_NEAR_TAKEN);


    assign read_index_2 = ReadAddr_2_i[NUM_INDEX_BIT+1:1];
    assign read_index_4 = ReadAddr_4_i[NUM_INDEX_BIT+1:1];

    assign read_tag_2 = ReadAddr_2_i[30: NUM_INDEX_BIT];
    assign read_tag_4 = ReadAddr_4_i[30: NUM_INDEX_BIT];

    assign write_index  = WriteAddr_i[NUM_INDEX_BIT+1:1];

    always @* begin
        for (i = 0; i < NUM_ENTRY; i = i + 1) begin
            target_nxt[i] = target[i];
            tag_nxt[i]    = tag[i];
        end

        if (miss && BranchTaken_i) begin
            target_nxt[write_index] = { WriteTarget_i[31:1], 1'b0 };
            tag_nxt[write_index]    = WriteAddr_i[30:NUM_INDEX_BIT];
        end
    end

    always @* begin
        for (i = 0; i < NUM_ENTRY; i = i + 1) begin
            predict_nxt[i] = predict[i];
        end

        if (miss) begin
            if (BranchTaken_i) begin
                case (predict[write_index])
                    S_NONTAKEN : begin
                        predict_nxt[write_index] = S_NEAR_NONTAKEN;
                    end
                    S_NEAR_NONTAKEN : begin
                        predict_nxt[write_index] = S_NEAR_TAKEN;
                    end
                    S_NEAR_TAKEN : begin
                        predict_nxt[write_index] = S_TAKEN;
                    end
                    S_TAKEN : begin
                        predict_nxt[write_index] = S_TAKEN;
                    end
                endcase
            end
            else begin
                case (predict[write_index])
                    S_NONTAKEN : begin
                        predict_nxt[write_index] = S_NONTAKEN;
                    end
                    S_NEAR_NONTAKEN : begin
                        predict_nxt[write_index] = S_NONTAKEN;
                    end
                    S_NEAR_TAKEN : begin
                        predict_nxt[write_index] = S_NEAR_NONTAKEN;
                    end
                    S_TAKEN : begin
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
                predict[i] <= S_NEAR_NONTAKEN;
                target[i]  <= 0;
                tag[i]     <= 0;
            end
            else begin
                predict[i] <= predict_nxt[i];
                target[i]  <= target_nxt[i];
                tag[i]     <= tag_nxt[i];
            end
        end
    end

endmodule
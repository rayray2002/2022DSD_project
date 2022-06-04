module PredictionUnit
    (
        input      clk,     //clock
        input      rst_n,   //active-low reset
        input      stall,   //stall from cache or hazard
        input      PreWrong,//miss prediction from comparator, 1 = miss prediction, 0 = correct prediction
        input      B,       //branch signal, if high means instruction is beq or bne
        output reg BrPre    //1 = branch taken, 0 = branch not taken
    );
    //params
    parameter TAKEN_DEEP = 0, TAKEN = 1, NOT_TAKEN = 2, NOT_TAKEN_DEEP = 3;
    //regs===============================
    reg [1:0] Q_NOW, Q_NEXT;

    //combinational======================
    /*BrPre logic*/
    always@(*)
    begin
        case(Q_NOW)
            TAKEN_DEEP:
                BrPre = 1;
            TAKEN:
                BrPre = 1;
            NOT_TAKEN:
                BrPre = 0;
            NOT_TAKEN_DEEP:
                BrPre = 0;
        endcase
    end
    /*Q_NEXT logic*/
    always@(*)
    begin
        if(~rst_n)
            Q_NEXT = NOT_TAKEN_DEEP;
        else if(stall | ~B)
            Q_NEXT = Q_NOW;
        else
        begin
            case(Q_NOW)
                TAKEN_DEEP:
                    Q_NEXT = (PreWrong) ? TAKEN : TAKEN_DEEP;
                TAKEN:
                    Q_NEXT = (PreWrong) ? NOT_TAKEN : TAKEN_DEEP;
                NOT_TAKEN:
                    Q_NEXT = (PreWrong) ? TAKEN : NOT_TAKEN_DEEP;
                NOT_TAKEN_DEEP:
                    Q_NEXT = (PreWrong) ? NOT_TAKEN : NOT_TAKEN_DEEP;
            endcase
        end
    end

    //sequential=========================
    always@(posedge clk)
    begin
        Q_NOW <= Q_NEXT;
    end

endmodule

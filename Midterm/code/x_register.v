// `include "pipeline_reg.v"
`include "const.v"

module x_register (
           input clk,
           input rst,
           input [3:0] count,
           input out_valid,
           input signed [`REG_WIDTH:0] dataTarget_i,
        //    output reg signed [`REG_WIDTH:0] dataTarget_o,

           output signed [`REG_WIDTH:0] dataP1_o,
           output signed [`REG_WIDTH:0] dataM1_o,
           output signed [`REG_WIDTH:0] dataP2_o,
           output signed [`REG_WIDTH:0] dataM2_o,
           output signed [`REG_WIDTH:0] dataP3_o,
           output signed [`REG_WIDTH:0] dataM3_o,

           output signed [`REG_WIDTH:0] data_o
       );

parameter PREV = (`TARGET-`STEP>=0) ? `TARGET-`STEP : `TARGET-`STEP+16;

// wire & reg declarations
reg signed [`REG_WIDTH:0] registers [0:15];
wire count4;
integer i;
integer tmp;
// reg [3:0] PREV;

assign count4 = count[1] & count[0];

// combinational logic
// always @(*) begin
//     if (~count[3] & ~count[2] & ~(count[1] & count[0])) begin
//         dataTarget_o = registers[7];
//     end else if (count[1] & count[0]) begin
//         dataTarget_o = registers[4];
//     end else begin
//         dataTarget_o = registers[3];
//     end
//     // dataTarget_o = count4 ? registers[`TARGET-1] : registers[`TARGET];
// end

// sequential logic
always @(posedge clk) begin
    if (rst) begin
        // PREV <= 8;
        for (i = 0; i < 16; i = i + 1) begin
            registers[i] <= i+16;
            // registers[i] <= 0;
        end
    end else begin
        // rotate registers
        if ((count[3]&count[2]&count[1]&count[0]) | out_valid) begin
            for (i = 0; i < 16; i = i + 1) begin
                tmp = (i+1)%16;
                registers[i] <= registers[tmp];
            end
        end else if (count4) begin
            for (i = 0; i < 16; i = i + 1) begin
                tmp = (i+5)%16;
                registers[i] <= registers[tmp];
            end
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                tmp = (i+4)%16;
                registers[i] <= registers[tmp];
            end
        end

        if (~out_valid) begin
            if ((~count[3] & ~count[2] & ~(count[1] & count[0])) | (count[3] & count[2] & count[1] & count[0])) begin
                registers[3] <= dataTarget_i;
            // end else if (count[1] & ~count[0]) begin
                // registers[0] <= dataTarget_i;
            end else begin
                registers[15] <= dataTarget_i;
            end
        end

        // case ({count4, count[1], count[3]&count[2]&count[1]&count[0]})
        //     3'b110: begin
        //         registers[PREV-1] <= dataTarget_i;
        //         for (i = 0; i < 16; i = i + 1) begin
        //             if (i != PREV-1) begin
        //                 tmp = (i+`STEP+1)%16;
        //                 registers[i] <= registers[tmp];
        //             end
        //         end
        //     end
        //     3'b111: begin
        //         registers[`TARGET-1] <= dataTarget_i;
        //         for (i = 0; i < 16; i = i + 1) begin
        //             if (i != `TARGET-1) begin
        //                 tmp = (i+1)%16;
        //                 registers[i] <= registers[tmp];
        //             end
        //         end
        //     end
        //     3'b010: begin
        //         registers[PREV-1] <= dataTarget_i;
        //         for (i = 0; i < 16; i = i + 1) begin
        //             if (i != PREV-1) begin
        //                 tmp = (i+`STEP)%16;
        //                 registers[i] <= registers[tmp];
        //             end
        //         end
        //     end
        //     3'b000: begin
        //         registers[PREV] <= dataTarget_i;
        //         for (i = 0; i < 16; i = i + 1) begin
        //             if (i != PREV) begin
        //                 tmp = (i+`STEP)%16;
        //                 registers[i] <= registers[tmp];
        //             end
        //         end
        //     end
        // endcase
    end
end

// always @(*) begin
//     if (rst) begin
//         dataP1_o <= 0;
//         dataP2_o <= 0;
//         dataP3_o <= 0;
//         dataM1_o <= 0;
//         dataM2_o <= 0;
//         dataM3_o <= 0;
//     end
//     else begin
//         dataP1_o <= registers[1];
//         dataP2_o <= registers[2];
//         dataP3_o <= registers[3];
//         dataM1_o <= registers[15];
//         dataM2_o <= registers[14];
//         dataM3_o <= registers[13];
//     end
// end

// assign
assign data_o = registers[0][`REG_WIDTH:`REG_WIDTH-31];

assign dataP1_o = registers[1];
assign dataP2_o = registers[2];
assign dataP3_o = registers[3];
assign dataM1_o = registers[15];
assign dataM2_o = registers[14];
assign dataM3_o = registers[13];

endmodule

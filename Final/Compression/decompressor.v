module Decompressor (
    input   	      PC_2, // PC[1:0] != 11 => +2 / PC[2:0] != 111 => +4
    input  	   [31:0] inst_raw,
    output reg [31:0] inst,
    output reg		  compr
);
    reg [15:0] half_inst;

    always @ (*) begin
        // half_inst = ~PC_2 ? inst_raw[15:0] : inst_raw[31:16];
        half_inst = inst_raw[15:0];

        if (inst_raw[1:0] == 2'b11) begin //uncompressed
            compr = 0; //PC + 4
            inst = inst_raw;
        end else begin
            compr = 1; //PC + 2
            // half_inst = ~PC_2 ? inst_raw[15:0] : inst_raw[31:16];
            // half_inst = inst_raw[31:16];
      
            case ({half_inst[15:13], half_inst[1:0]})
                /* c.lw ---------------------------------------------------------------------------*/
                5'b01000: inst = {5'b00000, half_inst[5], half_inst[12:10], half_inst[6], 2'b00, 2'b01, half_inst[9:7], 3'b010, 2'b01, half_inst[4:2], 7'b0000011};
                /* c.sw ---------------------------------------------------------------------------*/
                5'b11000: inst = {5'b00000, half_inst[5], half_inst[12], 2'b01, half_inst[4:2], 2'b01, half_inst[9:7], 3'b010, half_inst[11:10], half_inst[6], 2'b00, 7'b0100011};
                5'b00001: begin
                    /* c.nop ----------------------------------------------------------------------*/
                    if (half_inst[12:2] == 11'b0)
                        inst = {25'b0, 7'b0010011};
                    /* c.addi --------------------------------------------------------------------*/
                    else inst = {{7{half_inst[12]}}, half_inst[6:2], half_inst[11:7], 3'b000, half_inst[11:7], 7'b0010011};
                end
                /* c.jal --------------------------------------------------------------------------*/
                5'b00101: inst = {half_inst[12], half_inst[8], half_inst[10:9], half_inst[6], half_inst[7], half_inst[2], half_inst[11], half_inst[5:3], half_inst[12], {8{half_inst[12]}}, 5'd1, 7'b1101111};
                5'b10001: begin
                    /* c.andi --------------------------------------------------------------------*/
                    if (half_inst[11:10] == 2'b10)
                        inst = {{7{half_inst[12]}}, half_inst[6:2], 2'b01, half_inst[9:7], 3'b111, 2'b01, half_inst[9:7], 7'b0010011};
                    /* Skip instruction ---------------------------------------------------------*/
                    else if (half_inst[12] == 1'b0 && half_inst[6:2] == 5'b0)
                        inst = 32'b0;
                    /* c.srli --------------------------------------------------------------------*/
                    else if (half_inst[11:10] == 2'b00)
                        inst = {7'b0000000, half_inst[6:2], 2'b01, half_inst[9:7], 3'b101, 2'b01, half_inst[9:7], 7'b0010011};
                    /* c.srai --------------------------------------------------------------------*/
                    else
                        inst = {7'b0100000, half_inst[6:2], 2'b01, half_inst[9:7], 3'b101, 2'b01, half_inst[9:7], 7'b0010011};
                end
                /* c.j -----------------------------------------------------------------------*/
                5'b10101: inst = {half_inst[12], half_inst[8], half_inst[10:9], half_inst[6], half_inst[7], half_inst[2], half_inst[11], half_inst[5:3], half_inst[12], {8{half_inst[12]}}, 5'd0, 7'b1101111};
                /* c.beqz --------------------------------------------------------------------*/
                5'b11001: inst = {{4{half_inst[12]}}, half_inst[6], half_inst[5], half_inst[2], 5'd0, 2'b01, half_inst[9:7], 3'b000, half_inst[11], half_inst[10], half_inst[4], half_inst[3], half_inst[12], 7'b1100011};
                /* c.bnez --------------------------------------------------------------------*/
                5'b11101: inst = {{4{half_inst[12]}}, half_inst[6], half_inst[5], half_inst[2], 5'd0, 2'b01, half_inst[9:7], 3'b001, half_inst[11], half_inst[10], half_inst[4], half_inst[3], half_inst[12], 7'b1100011};
                /* c.slli --------------------------------------------------------------------*/
                5'b00010: inst = {7'b0000000, half_inst[6:2], half_inst[11:7], 3'b001, half_inst[11:7], 7'b0010011};
                5'b10010: begin
                    if (half_inst[6:2] == 5'd0) begin
                        /* c.jalr --------------------------------------------------------------------*/
                        if (half_inst[12] && half_inst[11:7] != 5'b0)
                            inst = {12'b0, half_inst[11:7], 3'b000, 5'd1, 7'b1100111};
                        /* c.jr --------------------------------------------------------------------*/
                        else inst = {12'b0, half_inst[11:7], 3'b000, 5'd0, 7'b1100111};
                    end 
                    else if (half_inst[11:7] != 5'b0) begin
                        /* c.mv --------------------------------------------------------------------*/
                        if (half_inst[12] == 1'b0)
                            inst = {7'b0000000, half_inst[6:2], 5'd0, 3'b000, half_inst[11:7], 7'b0110011};
                        /* c.add --------------------------------------------------------------------*/
                        else inst = {7'b0000000, half_inst[6:2], half_inst[11:7], 3'b000, half_inst[11:7], 7'b0110011};
                    end
                end
                default : inst = 32'b0;
            endcase
        end
    end
endmodule

module Decompressor_ (
        input  	   [1:0]  PC, // PC[1:0] != 11 => +2 / PC[2:0] != 111 => +4
        input  	   [31:0] inst_raw,
        output reg [31:0] inst,
        output reg		  compr
    );

    reg [15:0] half_inst;

    always @(*)
    begin
        if (inst_raw[1:0] == 2'b11)
        begin //uncompressed
            compr = 1'b0; //PC + 4
            inst = inst_raw;
        end
        else
        begin
            compr = 1'b1; //PC + 2
            half_inst = (PC == 2'b00) ? inst_raw[15:0] : inst_raw[31:16];
            // half_inst = inst_raw[15:0];

            case (half_inst[1:0]) //op
                2'b00:
                begin
                    case (half_inst[15:13])
                        //c.lw
                        3'b010:
                            inst = {{5'b0, half_inst[5], half_inst[12:10], half_inst[6], 2'b00}, {2'b01, half_inst[9:7]}, 3'd2, {2'b01, half_inst[4:2]}, 7'b0000011}; //lw rd' , offset[6:2](rs1')
                        //c.sw
                        3'b110:
                            inst = {{5'b0, half_inst[5], half_inst[12]}, {2'b01, half_inst[4:2]}, {2'b01, half_inst[9:7]}, 3'd2, {half_inst[11:10], half_inst[6], 2'b00}, 7'b0100011}; //sw rs2' , offset[6:2](rs1')
                        default:
                            inst = 32'b0;
                    endcase
                end
                2'b01:
                begin
                    case (half_inst[15:13])
                        //c.jal
                        3'b001:
                            inst = {{1'b0, half_inst[8], half_inst[10:9], half_inst[6], half_inst[7], half_inst[2], half_inst[11], half_inst[5:3], half_inst[12], 8'b0}, 5'd1, 7'b1101111}; //jal x1, offset[11:1]
                        //c.beqz
                        3'b110:
                            inst = {{half_inst[12], {3{half_inst[12]}}, half_inst[6:5], half_inst[2]}, 5'b0, {2'b01, half_inst[9:7]}, 3'b0, {half_inst[11:10], half_inst[4:3], half_inst[12]}, 7'b1100011}; //beq rs1', x0, offset[8:1]
                        3'b100:
                        begin
                            case (half_inst[6:5])
                                //c.and
                                2'b11:
                                    inst = {7'h00, {2'b01, half_inst[4:2]}, {2'b01, half_inst[9:7]}, 3'd7, {2'b01, half_inst[9:7]}, 7'b0110011}; //and rd' , rd' , rs2'
                                //c.or
                                2'b10:
                                    inst = {7'h00, {2'b01, half_inst[4:2]}, {2'b01, half_inst[9:7]}, 3'd6, {2'b01, half_inst[9:7]}, 7'b0110011}; //sub rd' , rd' , rs2'
                                //c.sub
                                2'b00:
                                    inst = {7'h20, {2'b01, half_inst[4:2]}, {2'b01, half_inst[9:7]}, 3'b0, {2'b01, half_inst[9:7]}, 7'b0110011}; //or rd' , rd' , rs2'
                                default:
                                    inst = 32'b0;
                            endcase
                        end
                        default:
                            inst = 32'b0;
                    endcase
                end
                2'b10:
                begin
                    //half_inst[15:12] == 4'b1100011				//jalr x1, rs1, 0											//add rd, rd, rs2
                    inst = (half_inst[6:2] == 5'b0) ? {12'b0, half_inst[11:7], 3'b0, 5'd1, 7'b1100111} : {7'h00, half_inst[6:2], half_inst[11:7], 3'b0, half_inst[11:7], 7'b0110011};
                end
                default:
                    inst = 32'b0;
            endcase
        end
    end

endmodule

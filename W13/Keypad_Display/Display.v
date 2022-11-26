module Display(
    rst, clk, valid, Scan_data,
    seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,
    Out_en);
    input rst, clk;
    input valid;
    input [11:0] Scan_data;

    output [6:0] seg1, seg2, seg3, seg4;
    output [6:0] seg5, seg6, seg7, seg8;
    output Out_en;

    reg [6:0] seg_reg [7:0];
    reg [11:0] buffer;
    reg [2:0] addr;

    always@(posedge valid) begin
        buffer <= Scan_data;
        if(buffer[11]) addr <= addr + 1; // when press #
    end
    assign Out_en = buffer[10]; // when press *

    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            addr <= 3'b0;
            buffer <= 12'b0;
            seg_reg[0] <= 7'b0;
            seg_reg[1] <= 7'b0;
            seg_reg[2] <= 7'b0;
            seg_reg[3] <= 7'b0;
            seg_reg[4] <= 7'b0;
            seg_reg[5] <= 7'b0;
            seg_reg[6] <= 7'b0;
            seg_reg[7] <= 7'b0;
            seg_reg[8] <= 7'b0;
        end
        else if (buffer[0] || buffer[1] || buffer[2] || buffer[3] || buffer[4] || buffer[5] 
        || buffer[6] || buffer[7] || buffer[8] || buffer[9])begin
            seg_reg[addr][0] <= buffer[1] || buffer[2] || buffer[4] || buffer[5] || buffer[6] || buffer[7] || buffer[8] || buffer[9];
            seg_reg[addr][1] <= buffer[0] || buffer[1] || buffer[2] || buffer[3] || buffer[6] || buffer[7] || buffer[8] || buffer[9];
            seg_reg[addr][2] <= buffer[0] || buffer[2] || buffer[3] || buffer[4] || buffer[5] || buffer[6] || buffer[7] || buffer[8] || buffer[9];
            seg_reg[addr][3] <= buffer[1] || buffer[2] || buffer[4] || buffer[5] || buffer[7] || buffer[8] || buffer[9];
            seg_reg[addr][4] <= buffer[1] || buffer[5] || buffer[7] || buffer[9];
            seg_reg[addr][5] <= buffer[3] || buffer[4] || buffer[5] || buffer[6] || buffer[7] || buffer[8] || buffer[9];
            seg_reg[addr][6] <= buffer[1] || buffer[2] || buffer[3] || buffer[4] || buffer[5] || buffer[7] || buffer[8];
        end
    end

    assign seg1 = seg_reg[0];
    assign seg2 = seg_reg[1];
    assign seg3 = seg_reg[2];
    assign seg4 = seg_reg[3];
    assign seg5 = seg_reg[4];
    assign seg6 = seg_reg[5];
    assign seg7 = seg_reg[6];
    assign seg8 = seg_reg[7];
endmodule

module Reg(en, rst, clk, In, Out);
    input en, rst, clk;
    input [6:0] In;
    output [6:0] Out;

    reg [6:0] Out;
    always@(posedge clk or negedge rst) begin
        if(!rst) Out <= 7'b0;
        else if (en) begin
            Out <= In;
        end
    end
endmodule

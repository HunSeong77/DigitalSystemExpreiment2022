
module add3(I, O);
input [3:0] I;
output reg [3:0] O;

always@ (I) begin
	if(I <= 4'b0100) O <= I;
	else if (I < 4'b1010) O <= I + 4'b011;
	else O <= 4'bxxxx;
end
endmodule

module BinaryToBCD(In, tens, units);
input [3:0] In;
output [3:0] tens, units;

assign units[0] = In[0];
add3 C1({1'b0, In[3:1]}, {tens[0], units[3:1]});
assign tens[3:1] = 3'b0;

endmodule

module BCDto7seg(I_BCD, O_seg);
    input [3:0] I_BCD;
    output reg [7:0] O_seg;

    always @(*) begin
        case (I_BCD)
            4'b0000 : O_seg <= 8'b11111100;
            4'b0001 : O_seg <= 8'b01100000;
            4'b0010 : O_seg <= 8'b11011010;
            4'b0011 : O_seg <= 8'b11110010;
            4'b0100 : O_seg <= 8'b01100110;
            4'b0101 : O_seg <= 8'b10110110;
            4'b0110 : O_seg <= 8'b10111110;
            4'b0111 : O_seg <= 8'b11100100;
            4'b1000 : O_seg <= 8'b11111110;
            4'b1001 : O_seg <= 8'b11110110;
            default : O_seg <= 8'bxxxxxxxx;
        endcase
    end
endmodule

module binaryTo7Seg(I_bin, O_seg1, O_seg0);
    input[3:0] I_bin;
    output [7:0] O_seg1, O_seg0;

    wire [7:0] BCD1, BCD0;

    BinaryToBCD BCDconverter(I_bin, BCD1, BCD0);

    BCDto7seg seg1(BCD1, O_seg1);
    BCDto7seg seg0(BCD0, O_seg0);
endmodule

module add3(I, O);
input [3:0] I;
output reg [3:0] O;

always@ (I) begin
	if(I < 4'b0100) O <= I;
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


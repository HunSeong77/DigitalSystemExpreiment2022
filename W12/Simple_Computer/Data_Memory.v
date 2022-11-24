module Data_Memory(CLK,WR,A,D_IN,Q);
input CLK, WR;
input [3:0] A;
input [3:0] D_IN;
output [3:0] Q;

// write your code for reading/writing
reg [3:0] SRAM [15:0];

initial begin
   SRAM[0] = 4'b0010;
   SRAM[1] = 4'b0011;
   SRAM[2] = 4'b0000;
   SRAM[3] = 4'b0000;
end


always@(posedge CLK)
if(WR) SRAM[A]<=D_IN;

assign Q=SRAM[A];
	
endmodule 
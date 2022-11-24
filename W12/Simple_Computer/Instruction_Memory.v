module Instruction_Memory(CLK,WR,A,D_IN,Q);
input CLK, WR;
input [3:0] A; // address
input [12:0] D_IN; // input instruction
output [12:0] Q; // output instruction

reg [12:0] SRAM [15:0];

initial begin
SRAM[0]  = 13'b1100000_10_01_11;   //BRZ R1 1011 , if(R1==0) jump to 1011
SRAM[1]  = 13'b0000010_11_11_00;   //ADD R3 R3 R0 , R3<-R3+R0
SRAM[2]  = 13'b0000110_01_01_01;   //DECREMENT R1 R1 , R1<-R1-1
SRAM[3]  = 13'b1110000_00_10_00;   //JUMP R2 , jump to R2
SRAM[5]  = 13'b1000010_00_00_00;   //ADDI R0 R0 00 , R0<-R0+0
SRAM[6]  = 13'b1000010_01_01_01;   //ADDI R1 R1 01 , R1<-R1+1
SRAM[7]  = 13'b0010000_00_00_00;   //LOAD R0 R0 , R0<-M[R0]
SRAM[8]  = 13'b0010000_01_01_00;   //LOAD R1 R1 , R1<-M[R1]
SRAM[9]  = 13'b1000010_10_10_00;   //ADDI R2 R2 00 , R2<-R2+0
SRAM[10] = 13'b1110000_00_10_00;   //JUMP R2 , jump to R2
SRAM[11] = 13'b0100000_00_10_11;  //STORE R2 R3 , M[R2]<-R3
end

// write your code for reading/writing
always @(posedge CLK)begin
    if(WR) SRAM[A]<=D_IN; 
  end
   
	assign Q=SRAM[A];

endmodule

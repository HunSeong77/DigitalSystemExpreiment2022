module Instruction_Decoder(Instruction, DA, AA, BA, MB, FS, MD, RW, MW, PL, JB, BC);
input [12:0] Instruction;
output [1:0] DA, AA, BA;
output MB;
output [3:0] FS;
output MD, RW, MW, PL, JB, BC;
wire f1 = Instruction[12] & Instruction[11]; //enter in before PL with AND gate

assign DA = Instruction[5:4]; //DR 
assign AA = Instruction[3:2]; //SA
assign BA = Instruction[1:0]; //BA
assign MB = Instruction[12]; //Opcode 12
assign FS[3:1] = Instruction[9:7]; //Opcode 9,8,7
assign FS[0] = Instruction[6] & (~f1); //Opcode 6
assign MD = Instruction[10]; //Opcode 10
assign RW = ~Instruction[11]; //Opcode 11
assign MW = Instruction[11] & (~Instruction[12]);  //Opcode 11 & (~12)
assign PL = f1; 
assign JB = Instruction[10]; //Opcode 10
assign BC = Instruction[6]; //Opcode 6
  
endmodule  
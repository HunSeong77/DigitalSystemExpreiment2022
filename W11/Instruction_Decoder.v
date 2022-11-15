module Instruction_Decoder(Instruction, DA, AA, BA, MB, FS, MD, RW, MW, PL, JB, BC);
input [12:0] Instruction;
output[1:0] DA, AA, BA;
output MB;
output [3:0] FS;
output MD, RW, MW, PL, JB, BC;

assign DA = Instruction[5:4];
assign AA = Instruction[3:2];
assign BA = Instruction[1:0];
assign MB = Instruction[12]
assign FS[3:1] = Instruction[9:7];
assign FS[0] = Instruction[6] & (~PL);
assign MD = Instruction[10];
assign RW = ~Instruction[11];
assign MW = Instruction[11] & (~Instruction[12]);
assign PL = Instruction[11] & Instruction[12];
assign JB = Instruction[10];
assign BC = Instruction[6]
endmodule
module ControlUnit(CLK, AData, DA, AA, BA, MB, FS, MD, RW, MW,  Constant, PC);
input CLK;
input [3:0] AData;

output [3:0] Constant;
output [1:0] DA, AA, BA;
output MB, MD, RW, MW;
output [3:0] FS;
output [3:0] PC;

wire [12:0] Instruction;
wire[3:0] PC;
wire PL, JB, BC;

//reg [3:0] Constant;
supply0 gnd;
wire [1:0] LAddress, RAddress;
   
Program_Counter PC1(CLK, PL, JB, BC, DA, BA, AData, PC);
Instruction_Memory IM1(CLK, gnd, PC, gnd, Instruction);
Instruction_Decoder ID1(Instruction, DA, AA, BA, MB, FS, MD, RW, MW, PL, JB, BC);

assign Constant={1'b0, 1'b0, Instruction[1], Instruction[0]};

endmodule 

module DATAPATH(CLK, ControlWord, ConstantIn, DataIn, Reg0, Reg1, Reg2, Reg3, AddressOut, DataOut);
input [12:0] ControlWord;//DA,AA,BA,MB,FS,MD,RW (total 13bits)
input [3:0] ConstantIn;
input [3:0] DataIn;
input CLK;
output [3:0] Reg0, Reg1, Reg2, Reg3, AddressOut, DataOut;//in register file 

   wire [3:0] MuxB, MuxD, Adata, Bdata, Fout;

   assign MuxB = (ControlWord[6])? ConstantIn : Bdata; // MB select true? of false?
   assign MuxD = (ControlWord[1])? DataIn : Fout; // MD select true? or false?

   RegisterFile U1(CLK, MuxD, ControlWord[0], ControlWord[12:11], ControlWord[10:9], ControlWord[8:7], Adata, Bdata, Reg0, Reg1, Reg2, Reg3);
   FunctionUnit U2(Adata, MuxB, ControlWord[5:2], Fout);
	
	assign AddressOut = Adata;
	assign DataOut = MuxB;
	
endmodule


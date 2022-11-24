`timescale 10ns/1ps

module Simple_computer_TB;

reg CLK;
wire [3:0] OutData;
wire [3:0] Reg0, Reg1, Reg2, Reg3;

wire[12:0] ControlWord;
wire [3:0] Adata, Bdata, Constant, DataIn, PC;

Simple_computer SC1(CLK, OutData, Reg0, Reg1, Reg2, Reg3, ControlWord, Adata, Bdata, Constant, DataIn, PC);

initial begin
	CLK <= 0;
end

always # 10
CLK = ~CLK;
endmodule 
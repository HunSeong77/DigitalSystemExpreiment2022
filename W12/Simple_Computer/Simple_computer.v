module Simple_computer (CLK, OutData, Reg0, Reg1, Reg2, Reg3, ControlWord, Adata, Bdata, Constant, DataIn, PC);
input CLK;
output [3:0] OutData; 
output [3:0] Reg0, Reg1, Reg2, Reg3; 
output [12:0] ControlWord;
output [3:0] Adata, Bdata, Constant, DataIn, PC;

wire [3:0] FS;
wire [1:0] DA,AA,BA;
wire MB,MD,RW,PL,MW;

assign ControlWord[0] = RW;
assign ControlWord[1] = MD;
assign ControlWord[5:2] = FS;
assign ControlWord[6] = MB;
assign ControlWord[8:7] = BA;
assign ControlWord[10:9] = AA;
assign ControlWord[12:11] = DA;

ControlUnit CU1(CLK, Adata, DA, AA, BA, MB, FS, MD, RW, MW, Constant, PC);
DATAPATH DP1(CLK, ControlWord, Constant, DataIn, Reg0, Reg1, Reg2, Reg3, Adata, Bdata);
Data_Memory DM1(clk, MW, Adata, Bdata, DataIn);

assign OutData = DataIn;
//assign ControlWord = {DA,AA,BA,MB,FS,MD,RW};

endmodule 
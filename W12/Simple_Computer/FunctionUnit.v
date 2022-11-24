module FunctionUnit(Adata, Bdata, FS, Fout);
input [3:0] Adata, Bdata;
input [3:0] FS;    //[3:0]FS = {S, S1, S0, Cin}
output [3:0] Fout;

wire Cout;
wire [3:0] LCO1, ACO0; //logic circuit output, arithmetic circuit output
wire Cw;
   
LogicCircuit U1 (Adata, Bdata, FS[2], FS[1], LCO1); // implement your code here
ArithmeticCircuit U2 (Adata, Bdata, FS[2], FS[1], FS[0], ACO0, Cout); // implement your code here
MUX2to1 U3 (LCO1, ACO0, Fout, FS[3]);    // implement your code here

endmodule

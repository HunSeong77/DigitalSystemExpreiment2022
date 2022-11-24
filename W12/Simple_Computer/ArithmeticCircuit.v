module ArithmeticCircuit (Adata, Bdata, S1, S0, Cin, Gout, Cout);

input [3:0] Adata, Bdata;
input S1,S0,Cin;
output [3:0] Gout;
output Cout;

wire [3:0] Y;

InputLogic U1 (Bdata, S1, S0, Y);
adder_4bit  U2 (Cout, Gout, Adata, Y, Cin); //fbadd (Cout, S, A, B, Cin);

endmodule 
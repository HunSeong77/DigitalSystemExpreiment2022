module adder_4bit(Cout,Sum,A,B,Cin);

	output Cout;
	output [3:0] Sum;
	input [3:0] A, B;
	input Cin;

	wire [2:0] cw;

	full_adder f0 (cw[0], Sum[0], A[0], B[0], Cin);
	full_adder f1 (cw[1], Sum[1], A[1], B[1], cw[0]);
	full_adder f2 (cw[2], Sum[2], A[2], B[2], cw[1]);
	full_adder f3 (Cout, Sum[3], A[3], B[3], cw[2]);

endmodule

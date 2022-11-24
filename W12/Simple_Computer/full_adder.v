module full_adder(C,S,X,Y,Z);

	output C, S;
	input X, Y, Z;

	wire C0, C1;
	wire S0;

	// First half adder instance
	half_adder h0(C0, S0, X, Y);
	// Second half adder instance
	half_adder h1(C1, S, S0, Z);
	// Carry
	or o0(C, C1, C0);

endmodule

module FA(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
wire t1, t2, t3;

assign t1 = A ^ B;
assign t2 = t1 & Cin;
assign t3 = A & B;

assign S = t1 ^ Cin;
assign Cout = t2 | t3;

endmodule

module rippleCarryAdder(A, B, Cin, S, Cout);
input [3:0] A, B;
input Cin;

output [3:0] S;
output Cout;

wire [2:0] C;

FA FA1(A[0], B[0], Cin, S[0], C[0]);
FA FA2(A[1], B[1], C[0], S[1], C[1]);
FA FA3(A[2], B[2], C[1], S[2], C[2]);
FA FA4(A[3], B[3], C[2], S[3], Cout);
endmodule

module multiplier(A, B, C);
input [2:0] A;
input [3:0] B;
output [6:0] C;

wire [3:0] temp;

assign C[0] = A[0] & B[0];

rippleCarryAdder add1(B&{4{A[1]}}, {1'b0, B[3:1]&{3{A[0]}}}, 0, {temp[2:0], C[1]}, temp[3]);
rippleCarryAdder add2(B&{4{A[2]}}, temp[3:0], 0, C[5:2], C[6]);

endmodule
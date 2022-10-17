module fullAdder(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
wire t1, t2, t3;

assign t1 = A ^ B;
assign t2 = t1 & Cin;
assign t3 = A & B;

assign S = t1 ^ Cin;
assign Cout = t2 | t3;

endmodule

module addSub(A, B, M, S, C, V);
input [3:0] A, B;
input M;

output [3:0] S;
output C, V;

wire [3:0] _B;
wire [3:0] _C;

assign _B = B ^ {4{M}};

fullAdder FA1(A[0], _B[0], M, S[0], _C[0]);
fullAdder FA2(A[1], _B[1], _C[0], S[1], _C[1]);
fullAdder FA3(A[2], _B[2], _C[1], S[2], _C[2]);
fullAdder FA4(A[3], _B[3], _C[2], S[3], _C[3]);

assign C = _C[3];
assign V = _C[2] ^ _C[3];

endmodule
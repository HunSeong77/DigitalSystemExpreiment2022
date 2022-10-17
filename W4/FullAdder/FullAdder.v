module halfAdder(A, B, S, C);
input A, B;
output S, C;

assign S = A ^ B;
assign C = A & B;

endmodule

module fullAdder(A, B, cIn, sum, cOut);
input A, B, cIn;
output sum, cOut;

wire temp_sum, temp_c1, temp_c2;

halfAdder HA1(A, B, temp_sum, temp_c1);
halfAdder HA2(temp_sum, cIn, sum, temp_c2);

assign cOut = temp_c1 | temp_c2;

endmodule


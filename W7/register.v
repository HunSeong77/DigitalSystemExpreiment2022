module register(D, clk, Q);

input [3:0] D;
input clk;
output [3:0] Q;

D_FF D0(D[0], clk, Q[0],);
D_FF D1(D[1], clk, Q[1],);
D_FF D2(D[2], clk, Q[2],);
D_FF D3(D[3], clk, Q[3],);

endmodule
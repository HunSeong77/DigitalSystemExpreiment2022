module clock(CLK, Q);
input CLK;
output [3:0] Q;

updownCounter cnt(, 0, CLK, Q);
endmodule
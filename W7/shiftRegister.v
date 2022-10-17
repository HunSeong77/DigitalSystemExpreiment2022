module shiftRegister(I, clk, O);
input I, clk;
output O;

wire t3, t2, t1;

D_FF D3(I, clk, t3, );
D_FF D2(t3, clk, t2, );
D_FF D1(t2, clk, t1, );
D_FF D0(t1, clk, O, );

endmodule
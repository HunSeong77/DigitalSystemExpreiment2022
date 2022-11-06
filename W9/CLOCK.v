module clock(ResetN, CLK, Q);
  input CLK, ResetN;
  output [3:0] Q;
  
  updown_counter cnt(ResetN, 1'b0, CLK, Q);
endmodule

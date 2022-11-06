module JK_FF(ResetN, J, K, CLK, Q, Q_);
  input ResetN, J, K, CLK;
  output reg Q, Q_;
  
  always@(negedge ResetN or posedge CLK)
    if(ResetN == 0) begin
      Q = 1'b0;
      Q_ = 1'b1;
    end
  else begin
    if(J == 0) begin
      if(K == 1) begin
        Q = 1'b0;
        Q_ = 1'b1;
      end
    end
  else begin
    if(K == 0) begin
      Q = 1'b1;
      Q_ = 1'b0;
    end
  else begin
    Q = !Q;
    Q_ = !Q_;
  end
end
end
endmodule

module updown_counter(ResetN, DNUP, CLK, Q);
  input ResetN, DNUP, CLK;
  output [3:0] Q;
  
  JK_FF JK1(ResetN, 1, 1, CLK, Q[0],);
  JK_FF JK2(ResetN, (!Q[0] & DNUP) | (Q&(!DNUP)), (!Q[0] & DNUP) | (Q[0] & !DNUP), CLK, Q[1], );
  JK_FF JK3(ResetN, (!Q[0]&DNUP&!Q[1])|(Q[0]&!DNUP&Q[1]), (!Q[0]&DNUP&!Q[1])|(Q[0]&!DNUP&Q[1]), CLK, Q[2], );
  JK_FF JK4(ResetN, (!Q[2]&!Q[1]&!Q[0]&DNUP) | (Q[2]&Q[1]&Q[0]&!DNUP),(!Q[2]&!Q[1]&!Q[0]&DNUP) | (Q[2]&Q[1]&Q[0]&!DNUP), CLK, Q[3], );
endmodule
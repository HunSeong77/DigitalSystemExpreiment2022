module SR_Latch(S, R, Q, Q_);
input S, R;
output Q, Q_;

assign Q = ~(S & Q_);
assign Q_ = ~(R & Q);
endmodule

module D_FF(reset_n, D, clk, Q, Q_);
input reset_n, D, clk;
output Q, Q_;

wire temp1, temp2, temp3;

SR_Latch SR1(.S(temp3), .R(clk), .Q_(temp1));
SR_Latch SR2(.S(clk&temp1), .R(reset_n & D), .Q(temp2), .Q_(temp3));
SR_Latch SR3(.S(temp1), .R(temp2), .Q(Q), .Q_(Q_));

endmodule

module JK_FF(reset_n, J, K, clk, Q, Q_);
input reset_n, J, K, clk;
output Q, Q_;

wire D;

assign D = ((~K) & Q) | (J & Q_);

D_FF D1(.reset_n(reset_n), .D(D), .clk(~clk), .Q(Q), .Q_(Q_));

endmodule

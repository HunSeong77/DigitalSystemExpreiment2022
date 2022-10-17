module SR_Latch(S, R, Q, Q_);
input S, R;
output Q, Q_;

assign Q = ~(S & Q_);
assign Q_ = ~(R & Q);
endmodule

module D_FF(D, clk, Q, Q_);
input D, clk;
output Q, Q_;

wire temp1, temp2, temp3;

SR_Latch SR1(.S(temp3), .R(clk), .Q_(temp1));
SR_Latch SR2(.S(clk&temp1), .R(D), .Q(temp2), .Q_(temp3));
SR_Latch SR3(.S(temp1), .R(temp2), .Q(Q), .Q_(Q_));

endmodule

module JK_FF(J, K, clk, Q, Q_);
input J, K, clk;
output Q, Q_;

wire D;

assign D = ((~K) & Q) | (J & Q_);

D_FF D1(.D(D), .clk(clk), .Q(Q), .Q_(Q_));

endmodule
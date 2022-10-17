module BCD_Ripple_Counter(clk, Q);
input clk;
output [3:0] Q;

JK_FF   JK0(.J(1'b1), .K(1'b1), .clk(clk), .Q(Q[0])),
        JK1(.J(~Q[3]), .K(1'b1), .clk(Q[0]), .Q(Q[1])),
        JK2(.J(1'b1), .K(1'b1), .clk(Q[1]), .Q(Q[2])),
        JK3(.J(Q[1] & Q[2]), .K(1'b1), .clk(Q[0]), .Q(Q[3]));

endmodule

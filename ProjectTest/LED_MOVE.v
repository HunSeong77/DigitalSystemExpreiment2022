module SR_FF(CLK, S, R, Q, Q_);
	input CLK, S, R;
	output Q, Q_;
	
	wire t1, t2;
	
	assign t1 = CLK & S;
	assign t2 = CLK & R;
	
	nor(Q, t1, Q_);
	nor(Q_, t2, Q);
endmodule

module test(CLK, I, O);
	input CLK;
	input [1:0] I;
	output [7:0] O;
	
	wire sr;
	
	SR_FF SR1(CLK, I[0], I[1] , sr);
	LED led(CLK, sr, O);
endmodule

module counter(CLK, Q);
	input CLK;
	output [2:0] Q;
	reg [3:0] Q;
	
	initial Q <= 4'b0000;
	
	always@(posedge CLK) begin
		Q <= Q + 1;
		end
endmodule

module LED(CLK, en, O);
	input CLK, en;
	output [7:0] O;
	wire [3:0] cnt;
	counter c(CLK & en, cnt);
	
	assign O[0] = O[1] & !(!cnt[3] & cnt[2] & cnt[1] & !cnt[0]) & !(cnt[3] & !cnt[2] & !cnt[1] & cnt[0]); // 6, 9
	assign O[1] = O[2] & !(!cnt[3] & cnt[2] & !cnt[1] & cnt[0]) & !(cnt[3] & !cnt[2] & cnt[1] & !cnt[0]); // 5, 10
	assign O[2] = O[3] & !(!cnt[3] & cnt[2] & !cnt[1] & !cnt[0]) & !(cnt[3] & !cnt[2] & cnt[1] & cnt[0]); // 4, 11
	assign O[3] = O[4] & !(!cnt[3] & !cnt[2] & cnt[1] & cnt[0]) & !(cnt[3] & cnt[2] & !cnt[1] & !cnt[0]); // 3, 12
	assign O[4] = O[5] & !(!cnt[3] & !cnt[2] & cnt[1] & !cnt[0]) & !(cnt[3] & cnt[2] & !cnt[1] & cnt[0]); // 7, 8
	assign O[5] = O[6] & !(!cnt[3] & !cnt[2] & !cnt[1] & cnt[0]) & !(cnt[3] & cnt[2] & cnt[1] & !cnt[0]); // 7, 8
	assign O[6] = !((!cnt[3] & !cnt[2] & !cnt[1] & !cnt[0]) | (cnt[3] & cnt[2] & cnt[1] & cnt[0])); // 1 ~ 14 0001 , 1110
	assign O[7] = 1; // 0, 15 0000, 1111
endmodule
	

module clk_devider(clk, nrst, clk2, clk4, clk8, clk16, clk32, clk64);
	input clk, nrst;
	output clk2, clk4, clk8, clk16, clk32, clk64;
	reg [5:0] Q;

	initial begin
		Q <= 6'b0;
	end

	always @(posedge clk or negedge nrst) begin
		if(!nrst) begin
			Q <= 6'b0;
		end
		else begin
			Q <= Q + 1;
		end
	end

	assign clk2 = Q[0];
	assign clk4 = Q[1];
	assign clk8 = Q[2];
	assign clk16 = Q[3];
	assign clk32 = Q[4];
	assign clk64 = Q[5];
endmodule
module LED(clk, en, O);
	input clk, en;
	output [7:0] O;
	wire [3:0] cnt;
	counter c(clk & en, cnt);
	
	assign O[0] = O[1] & !(!cnt[3] & cnt[2] & cnt[1] & !cnt[0]) & !(cnt[3] & !cnt[2] & !cnt[1] & cnt[0]); // 6, 9
	assign O[1] = O[2] & !(!cnt[3] & cnt[2] & !cnt[1] & cnt[0]) & !(cnt[3] & !cnt[2] & cnt[1] & !cnt[0]); // 5, 10
	assign O[2] = O[3] & !(!cnt[3] & cnt[2] & !cnt[1] & !cnt[0]) & !(cnt[3] & !cnt[2] & cnt[1] & cnt[0]); // 4, 11
	assign O[3] = O[4] & !(!cnt[3] & !cnt[2] & cnt[1] & cnt[0]) & !(cnt[3] & cnt[2] & !cnt[1] & !cnt[0]); // 3, 12
	assign O[4] = O[5] & !(!cnt[3] & !cnt[2] & cnt[1] & !cnt[0]) & !(cnt[3] & cnt[2] & !cnt[1] & cnt[0]); // 7, 8
	assign O[5] = O[6] & !(!cnt[3] & !cnt[2] & !cnt[1] & cnt[0]) & !(cnt[3] & cnt[2] & cnt[1] & !cnt[0]); // 7, 8
	assign O[6] = !((!cnt[3] & !cnt[2] & !cnt[1] & !cnt[0]) | (cnt[3] & cnt[2] & cnt[1] & cnt[0])); // 1 ~ 14 0001 , 1110
	assign O[7] = 1; // 0, 15 0000, 1111

	// assign O[0] = O[1] & !(!cnt[3] & cnt[2] & cnt[1] & !cnt[0]) & !(cnt[3] & !cnt[2] & !cnt[1] & cnt[0]); // 6, 9
	// assign O[1] = O[2] & !(!cnt[3] & cnt[2] & !cnt[1] & cnt[0]) & !(cnt[3] & !cnt[2] & cnt[1] & !cnt[0]); // 5, 10
	// assign O[2] = O[3] & !(!cnt[3] & cnt[2] & !cnt[1] & !cnt[0]) & !(cnt[3] & !cnt[2] & cnt[1] & cnt[0]); // 4, 11
	// assign O[3] = O[4] & !(!cnt[3] & !cnt[2] & cnt[1] & cnt[0]) & !(cnt[3] & cnt[2] & !cnt[1] & !cnt[0]); // 3, 12
	// assign O[4] = O[5] & !(!cnt[3] & !cnt[2] & cnt[1] & !cnt[0]) & !(cnt[3] & cnt[2] & !cnt[1] & cnt[0]); // 7, 8
	// assign O[5] = O[6] & !(!cnt[3] & !cnt[2] & !cnt[1] & cnt[0]) & !(cnt[3] & cnt[2] & cnt[1] & !cnt[0]); // 7, 8
	// assign O[6] = !((!cnt[3] & !cnt[2] & !cnt[1] & !cnt[0]) | (cnt[3] & cnt[2] & cnt[1] & cnt[0])); // 1 ~ 14 0001 , 1110
	// assign O[7] = 1; // 0, 15 0000, 1111
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


module clk_devider(clk, nrst, clk2, clk4, clk8, clk16, clk32, clk64, clk128, clk256, clk512, clk1024);
	input clk, nrst;
	output clk2, clk4, clk8, clk16, clk32, clk64, clk128, clk256, clk512, clk1024;
	reg [9:0] Q;

	initial begin
		Q <= 10'b0;
	end

	always @(posedge clk or negedge nrst) begin
		if(!nrst) begin
			Q <= 10'b0;
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
	assign clk128 = Q[6];
	assign clk256 = Q[7];
	assign clk512 = Q[8];
	assign clk1024 = Q[9];
	
endmodule

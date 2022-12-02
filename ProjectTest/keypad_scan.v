module keypad_scan(
input rst, clk,
input [2:0] keypad_in,
output reg [2:0] scan_out = 0);

reg en;

always @(posedge clk or negedge rst) begin

if (~rst) begin		//active-low reset
	en <= 0;
	scan_out <= 0;
	valid <= 0;
end
else begin
	if (keypad_in && ~en) begin	//if keypad input occurred, generate output and valid signal
		scan_out <= keypad_in;
		en <= 1'b1;
	end
	else if (keypad_in && en) begin	//after 1 clock passed, make valid signel to 0
		scan_out <= 0;
	end
	else begin		//when keypad input disappear, return to initial condition
		en <= 0;
		valid <= 0;
		scan_out <= 0;
	end
end

end

endmodule
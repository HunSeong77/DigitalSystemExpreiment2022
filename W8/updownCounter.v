module updownCounter(ResetN, DNUP, CLK, Q);
input ResetN, DNUP, CLK;
output reg [3:0] Q;

always@(negedge ResetN or posedge CLK) begin
	if(ResetN == 0) begin
	Q <= 4'b0;
	end
	else begin
    if(DNUP == 0) begin
        Q <= Q + 1'b1;
    end
    else begin
        Q <= Q- 1'b1;
    end
	end
end

endmodule
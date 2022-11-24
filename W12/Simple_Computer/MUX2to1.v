module MUX2to1(D1,D0,OUT,S);
input [3:0] D1,D0;
input S;
output [3:0] OUT;
reg [3:0] OUT;

always @(D1 or D0 or S) begin
	if( S == 1'b0 )
		OUT = D0;
	else if( S == 1'b1 )
		OUT = D1;
end
endmodule

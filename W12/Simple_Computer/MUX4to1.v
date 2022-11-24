module MUX4to1(D3,D2,D1,D0,OUT, S1, S0);
input [3:0] D3, D2, D1, D0;
input S1, S0;
output [3:0] OUT;
reg [3:0] OUT;

always @(D3 or D2 or D1 or D0 or S1 or S0) begin
	if( {S1,S0} == 2'b00)
		OUT = D0;
	else if( {S1,S0} == 2'b01)
		OUT = D1;
	else if( {S1,S0} == 2'b10)
		OUT = D2;
	else if( {S1,S0} == 2'b11)
		OUT = D3;
end 
endmodule 
module InputLogic(Bdata, S1, S0, Bout);
input [3:0] Bdata;
input S1, S0;
output [3:0] Bout;

   reg [3:0] Bout;

	always@(*)
	begin

	if({S1, S0} == {2'b00})
		Bout <= {4'b0000};
		
	else if({S1, S0} == {2'b01})
		Bout <= (Bdata);
		
	else if({S1, S0} == {2'b10})
		Bout <= (~Bdata);

	else if({S1, S0} == {2'b11})
		Bout <= {4'b1111};

	end

endmodule

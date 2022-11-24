module Program_Counter(CLK, PL, JB, BC, LAddress, RAddress, AData, PC);
input CLK, PL, JB, BC;
input [1:0] LAddress, RAddress;
input [3:0] AData;
output [3:0] PC;
 
reg [3:0] PC;
   
initial begin
  PC <= 4'b0101;
end
	
always@(posedge CLK) begin
	if(~PL) 
		PC <= PC+4'b0001;
	else if(JB) //Jump and Branch
		PC <= AData;
   else if(BC) begin 
		if(AData < 4'b0000)
			PC<=PC+{LAddress[1:0],RAddress[1:0]};
		else
			PC<= PC+4'b0001;
	end
	else if(~BC) begin //branch on negative
		if(AData == 4'b0000)
			PC<=PC+{LAddress[1:0],RAddress[1:0]};
		else
		PC<= PC+4'b0001;
	end
end

endmodule

  
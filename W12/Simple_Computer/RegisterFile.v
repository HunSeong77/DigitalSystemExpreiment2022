module RegisterFile(CLK, Ddata, Write, Daddr, Aaddr, Baddr, Adata, Bdata, Reg0,Reg1,Reg2,Reg3);

input CLK;
input [3:0] Ddata;
input [1:0] Daddr, Aaddr, Baddr;
input Write;

output [3:0] Adata;
output [3:0] Bdata;
output [3:0] Reg0, Reg1, Reg2, Reg3;

	reg [3:0] Reg0, Reg1, Reg2, Reg3;
  	
	wire [3:0] deco;
	wire [3:0] adata, bdata;

	DECODER2to4 dec1(.A1(Daddr[1]),.A0(Daddr[0]),.D3(deco[3]),.D2(deco[2]),.D1(deco[1]),.D0(deco[0]));

	MUX4to1 MuxA(.D3(Reg3),.D2(Reg2),.D1(Reg1),.D0(Reg0),.OUT(Adata), .S1(Aaddr[1]), .S0(Aaddr[0]));

	MUX4to1 MuxB(.D3(Reg3),.D2(Reg2),.D1(Reg1),.D0(Reg0),.OUT(Bdata), .S1(Baddr[1]), .S0(Baddr[0]));
	
	initial begin
		Reg0 <= 4'b0000;
		Reg1 <= 4'b0000;
		Reg2 <= 4'b0000;
		Reg3 <= 4'b0000;
	end
	
	
	
	always @(posedge CLK)
	begin
		if(Write)
		begin
			case(deco)
				// implement your code here
				4'b0001 : Reg0 <= Ddata;
				4'b0010 : Reg1 <= Ddata;
				4'b0100 : Reg2 <= Ddata;
				4'b1000 : Reg3 <= Ddata;
			endcase
		end
	end

endmodule




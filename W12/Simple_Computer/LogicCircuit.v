module LogicCircuit(Adata, Bdata, S1, S0, Gout);
input [3:0] Adata, Bdata;
input S1, S0;

output [3:0] Gout;	
reg [3:0] Gout;

  always @(*) 
  begin 
    case ({S1, S0}) 
    // implement your code here (AND operation)
    2'b00 : Gout <= Adata & Bdata;
    // implement your code here (OR operation)
    2'b01 : Gout <= Adata | Bdata; 
    // implement your code here (XOR operation)
    2'b10 : Gout <= Adata ^ Bdata;
    // implement your code here (NOT operation)
    2'b11 : Gout <= !Adata;
  endcase
  end

endmodule

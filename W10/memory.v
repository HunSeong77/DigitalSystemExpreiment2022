module memory(CLK, WR, RD, A, D_IN, Q);
  input CLK, WR, RD;
  input[3:0] A, D_IN;
  output reg [3:0] Q;
  
  reg[3:0] SRAM[15:0];
  
  always@(posedge CLK) begin
    if(WR == 1 && RD == 0) begin
      SRAM[A] <= D_IN;
    end
    else if (WR == 0 && RD == 1) begin
      Q <= SRAM[A];
    end
    else Q <= 4'bxxxx;
  end
endmodule
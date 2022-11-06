`timescale 1ns/1ps

module tb_clock();
  reg CLK;
  reg ResetN;
  wire [3:0] Q;
  
  clock clk(ResetN, CLK, Q);
  
  always #5 CLK = !CLK;
  
  initial begin
    CLK = 0;
    ResetN = 1;
    #5
    ResetN = 0;
    #5
    ResetN = 1;
    #200
    $stop;
  end
endmodule

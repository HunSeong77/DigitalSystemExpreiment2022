`timescale 1ns/1ps

module tb_updownCounter();
  reg CLK;
  reg DNUP;
  reg ResetN;
  wire [3:0] Q;
  
  updown_counter cnt(ResetN, DNUP, CLK, Q);
  
  always #5 CLK = !CLK;
  
  initial begin
    CLK = 0;
    DNUP = 0;
    ResetN = 1;
    #5
    ResetN = 0;
    #5
    ResetN = 1;
    #200
    DNUP = 1;
    #200
    $stop;
  end
endmodule

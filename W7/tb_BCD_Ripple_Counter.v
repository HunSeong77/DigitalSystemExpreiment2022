`timescale 1ns/1ps

module tb_BCD_Ripple_Counter();

reg clk;
wire [3:0] Q;

initial begin
    clk <= 0;
    #100
    $stop;
end

always #5 clk <= ~clk;

BCD_Ripple_Counter count(clk, Q);
endmodule
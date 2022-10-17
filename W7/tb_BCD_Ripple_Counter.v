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

reg J, K;
wire Q1, Q1_;
JK_FF JK(J, K, clk, Q1, Q1_);

initial begin
    J <= 1;
    K <= 1;

    #20
    J <= 0;
    K <= 1;

    #20
    J <= 1;
    K <= 0;

    #20
    J <= 0;
    K <= 0;
end

BCD_Ripple_Counter count(clk, Q);
endmodule
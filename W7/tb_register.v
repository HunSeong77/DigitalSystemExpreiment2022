`timescale 1ns/1ps

module tb_register();

reg [3:0] D;
reg clk;
wire [3:0] Q;

register regis(D, clk, Q);

always #10 clk <= ~clk;

integer i;

initial begin
    clk <= 0;
    for(i = 0; i < 16; i = i + 1)begin
        D <= i; #20;
    end

    #10
    $stop;
end
endmodule

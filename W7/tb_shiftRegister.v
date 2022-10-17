`timescale 1ns/1ps

module tb_shiftRegister();

reg [5:0] I;
wire i;
wire O;
reg clk;

integer t;

shiftRegister sftReg(i, clk, O);
assign i = I[t];

always #5 clk <= ~clk;


initial begin
    clk <= 0;
    I <= 6'b101101;
    for(t = 0; t < 6; t = t + 1) begin
        #10;
    end
    #50
    $stop;
end
endmodule
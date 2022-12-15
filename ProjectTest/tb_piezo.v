`timescale 10ps/1ps

module tb_piezo();
    reg clk, nrst;
    reg key4, key5, key6;
    wire piezo;
    wire [7:0] LED, COM, ENS;

    FORTRESS fortress(clk, nrst, key4, key5, key6, piezo, LED, COM, ENS);

    always #1 clk <= !clk;

    initial begin

        clk <= 1'b0;
        nrst <= 1'b0;
        key4 <= 1'b0; key5 <= 1'b0; key6 <= 1'b0;

        #5 nrst <= 1'b1;
        #5 nrst <= 1'b0;

        #100000 key6 <= 1'b1;
        #100000 key6 <= 1'b0;

        #130000 key5 <= 1'b1;
        #100000 key5 <= 1'b0;

        
    end
endmodule
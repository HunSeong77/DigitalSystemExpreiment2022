`timescale 10ps/10ps

module tb();
    reg clk, nrst;
    reg key_4, key_5, key_6;
    wire [7:0] oS_COM, oS_ENS;
    wire [7:0] o_LED;
    wire hit;

    TOP top(clk ,nrst, key_4, key_5, key_6, oS_COM, oS_ENS, o_LED, hit);

    always #5 clk = ~clk;

    initial begin
        clk <= 1'b0;
        nrst <= 1'b0;
        key_4 <= 1'b0;
        key_5 <= 1'b0;
        key_6 <= 1'b0;

        #10
        nrst <= 1'b1;

        #10 nrst<= 1'b0;

        // #300 key_6 <= 1'b1;
        // #100 key_6 <= 1'b0;

        #2500

        #300 key_5 <= 1'b1;
        #100 key_5 <= 1'b0;

        // #300 key_5 <= 1'b1;
        // #100 key_5 <= 1'b0;
        
        // #300 key_5 <= 1'b1;
        // #100 key_5 <= 1'b0;

        // #300 key_5 <= 1'b1;
        // #100 key_5 <= 1'b0;

        #1000000
        $stop;
    end
endmodule

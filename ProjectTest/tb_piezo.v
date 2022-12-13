`timescale 10ps/1ps

module tb_piezo();
    reg clk, nrst;
    reg [1:0] tank1_life, tank2_life;
    wire piezo_out;

    // hit_feedback piz(clk, nrst, tank1_life, tank2_life, piezo_out);

    reg en;
    congratulation cng(clk, nrst, en, piezo_out);

    always #1 clk <= !clk;

    initial begin
        // clk <= 1'b0;
        // nrst <= 1'b1;
        // tank1_life <= 2'b11;
        // tank2_life <= 2'b11;
        // #5 nrst <= 1'b0;
        // #5 nrst <= 1'b1;
        // #10 tank1_life <= 2'b10;

        // #450000 $stop;

        clk <= 1'b0;
        nrst <= 1'b1;
        en <= 1'b0;
        #5 nrst <= 1'b0;
        #5 nrst <= 1'b1;

        #10 en <= 1'b1;

        #10000 en <= 1'b0;
        #1000 en <= 1'b1;
    end
endmodule
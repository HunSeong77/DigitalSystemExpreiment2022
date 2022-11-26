`timescale 10ps/1ps

module tb_Keypad_scan();
    reg clk, rst;
    reg [11:0] Keypad_in;

    wire [11:0] Scan_out;
    wire valid;

    Keypad_scan keypad(rst, clk, Keypad_in, valid, Scan_out);

    always #5 clk = ~clk;

    initial begin
        clk <= 0;
        rst <= 1;
        Keypad_in <= 0;

        #10 rst <= 0;

        #20 rst <= 1;

        #10 Keypad_in <= 12'b000000000001;
        #50 Keypad_in <= 12'b0;

        #10 Keypad_in <= 12'b000000100000;
        #50 Keypad_in <= 12'b0;

        #50 $stop;
    end
endmodule

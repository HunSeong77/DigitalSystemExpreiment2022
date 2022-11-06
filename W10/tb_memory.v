`timescale 100ps/1ps

module tb_memory();

    reg CLK;
    reg [3:0] A, D_IN;
    reg WR, RD;
    wire [3:0] Q;

    memory mem(CLK, WR, RD, A, D_IN, Q);

    always #5 CLK = ~CLK;

    initial begin
        CLK <= 0;

        WR <= 1;
        RD <= 0;

        A <= 4'b0011;
        D_IN <= 4'b1001;

        #10
        A <= 4'b1101;
        D_IN <= 4'b1010;

        #10

        WR <= 0;
        RD <= 1;
        A <= 4'b0011;

        #10
        A <= 4'b1101;

        #10;
    end

endmodule
`timescale 1ns/1ps

module tb_Multiplier();

reg  unsigned [2:0] A;
reg  unsigned [3:0] B;
wire unsigned [6:0] C;

multiplier myMult(A, B, C);

initial begin
    // 14 x 5
    A = 5; B = 14; #10

    // 8 x 3
    A = 3; B = 8; #10

    // 13 x 7
    A = 7; B = 13; #10

    // 10 x 2
    A = 2; B = 10; #10;
end
endmodule
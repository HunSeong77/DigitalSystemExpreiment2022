`timescale 10ns/1ps

module tb_AddSub();

reg [3:0] A, B;
reg  M;


wire [3:0] S;
wire C, V;

addSub myAdd(A, B, M, S, C, V);

initial begin
    // 4 + 7
    A = 4; B = 7; M = 0; #10

    // 13 + 12
    A = 13; B = 12; M = 0; #10

    // 13 - 5
    A = 13; B = 5; M = 1; #10

    // 5 - 2
    A = 5; B = 2; M = 1; #10;
end
endmodule
`timescale 10ns/1ps

module ALU_tb;

reg[2:0] Opcode;
reg [3:0] a, b;
wire [3:0] result;

initial begin
    Opcode <= 3'd0;
    a <= 3'd2;
    b <= 3'd3;
    #10;

    Opcode <= 3'd1;
    a <= 3'd7;
    b <= 3'd4;
    #10;

    Opcode <= 3'd2;
    a <= 3'd2;
    b <= 3'd3;
    #10;

    Opcode <= 3'd3;
    a <= 3'd1;
    b <= 3'd2;
    #10;

    Opcode <= 3'd4;
    a <= 3'd7;
    b <= 3'd7;
    #10;

    Opcode <= 3'd5;
    a <= 3'd5;
    b <= 3'd2;
    #10;

end
ALU U1(Opcode, a, b, result);
endmodule
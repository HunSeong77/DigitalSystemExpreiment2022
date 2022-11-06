module ALU(Opcode, A, B, C);

input unsigned[3:0] A, B;
input unsigned[2:0] Opcode;

output reg unsigned[3:0] C;

always @(*) begin
    case (Opcode)
        0 : C <= A + B;
        1 : C <= A - B;
        2 : C <= A * B;
        3 : C <= A | B;
        4 : C <= A & B;
        5 : C <= A ^ B;
        default : C <= 4'bxxxx;
    endcase
end

endmodule

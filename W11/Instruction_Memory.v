module Instruction_Memory(CLK, WR, A, D_IN, Q);
input CLK, WR;
input [3:0] A;
input [12:0] D_IN;
output [12:0] Q;

reg [12:0] SRAM [15:0]

initial begin
    SRAM [0] = 13'b1100000_10_01_11;    // BRZ R1 1011, if (R1 == 0) jump to 1011
    SRAM [1] = 13'b0000010_11_11_00;    // ADD R3 R3 R0
    SRAM [2] = 13'b0000110_01_01_01;    // DECREMENT R1 R1
    SRAM [3] = 13'b1110000_00_10_00;    // JUMP R2, jump to R2
    SRAM [5] = 13'b1000010_00_00_00;    // ADDI R0 R0 00
    SRAM [6] = 13'b1000010_01_01_01;    // ADDI R1 R1 01
    SRAM [7] = 13'b0010000_00_00_00;    // LOAD R0 R0
    SRAM [8] = 13'b0010000_01_01_00;    // LOAD R1 R1
    SRAM [9] = 13'b1000010_10_10_00;    // ADDI R2 R2 00
    SRAM [10] = 13'b1110000_00_10_00;   // Jump R2
    SRAM [11] = 13'b0100000_00_10_11;   // STORE R2 R3
end

always @(posedge CLK) begin
    // implement your code here
    if(WR == 1)
        SRAM[A] <= D_IN;
end

// implement your code here
assign Q = SRAM[A];

endmodule
module memory(CLK, WR, RD, A, D_IN, Q);
input CLK, WR, RD;
input [3:0] A;
input [3:0] D_IN;
output[3:0] Q;

reg [3:0] SRAM[15:0];

always @(posedge CLK) begin
    if(WR == 1 && RD == 0) begin // WRITE
        SRAM[A] <= D_IN;
    end
end

assign Q = SRAM[A];

endmodule
module mux4to1(
    out,
    inp,
    sel
);

input   [3:0]   inp;
input   [1:0]   sel;
output  reg     out;

always @(sel) begin
    case(sel)
        2'b00 : assign out = inp[0];
        2'b01 : assign out = inp[1];
        2'b10 : assign out = inp[2];
        2'b11 : assign out = inp[3];
        default : assign out = 0;
    endcase
end
endmodule

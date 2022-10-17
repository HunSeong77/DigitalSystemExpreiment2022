module tb_binaryTo7seg();

reg [3:0] bin;
wire [7:0] seg1, seg0;

binaryTo7Seg binto7segConverter(bin, seg1, seg0);

integer i;
initial begin
    for (i = 0; i < 16; i = i + 1) begin
        bin <= i;
        #10;
    end
end
endmodule
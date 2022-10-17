`timescale 10ns/1ps

module dec3to8_tb();

reg  [2:0]  _inp;
wire [7:0]  _out;

dec3to8 myDec(.inp(_inp), .out(_out));

integer i;

initial begin
  _inp <= 3'b0;
    for(i = 0; i < 8; i = i + 1) 
      #10 _inp <= _inp + 1 ;
    #10;
end

endmodule

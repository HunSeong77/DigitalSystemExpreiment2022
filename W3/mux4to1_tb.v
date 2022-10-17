`timescale 10ns/1ps

module mux4to1_tb();
reg [3:0]   _inp;
reg [1:0]   _sel;
wire        _out;
mux4to1 myMux(.inp(_inp), .sel(_sel), .out(_out));

integer i;
initial begin
    _inp <= 4'b1001;
    _sel <= 2'b00;
    for(i = 0; i < 8; i = i + 1) begin
      #10 _sel <= _sel + 1;
    end
end
endmodule

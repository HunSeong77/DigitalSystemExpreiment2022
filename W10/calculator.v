module calculator(CLK, A, D_IN, WR, RD, opcode, oS_COM, oS_ENS);
  input CLK;
  input[3:0] A, D_IN;
  input WR;
  input [1:0] RD; // RD[0] : D1, RD[1] : D2
  input [2:0] opcode;
  output [7:0] oS_COM, oS_ENS;
  
  
  wire [7:0] Q;
  wire temp;
  reg [3:0] D1, D2;
  memory mmr(CLK, WR, RD[0] | RD[1] , A1, D_IN, temp);
  
  ALU alu(opcode, D1, D2, Q);
  
  wire[3:0] hunds, tens,  units;
  BinaryToBCD btb(Q, hunds, tens, units);
  
  wire[7:0] O_seg2, O_seg1, O_seg0;
  BCDto7seg b2(hunds, O_seg2);
  BCDto7seg b1(tens,  O_seg1);
  BCDto7seg b0(units, O_seg0);
  
  SevenSeg_CTRL ssc(.iSEG2(O_seg2), .iSEG1(O_seg1), .iSEG0(O_seg0), .iCLK(CLK),
    .oS_COM(oS_COM), .oS_ENS(oS_ENS));
  
  
  always@(posedge CLK) begin
    if(RD[0] == 1) begin
      D1 <= temp;
    end
    if(RD[1] == 1) begin
      D2 <= temp;
    end
  end
endmodule


module ALU(Opcode, A, B, C);

input unsigned[3:0] A, B;
input unsigned[2:0] Opcode;

output reg unsigned[7:0] C;

always @(*) begin
    case (Opcode)
        3'b001 : C <= A + B;
        3'b010 : C <= A - B;
        3'b100 : C <= A * B;
        default : C <= 4'bxxxx;
    endcase
end
endmodule

module add3(I, O);
input [3:0] I;
output reg [3:0] O;

always@ (I) begin
	if(I <= 4'b0100) O <= I;
	else if (I < 4'b1010) O <= I + 4'b011;
	else O <= 4'bxxxx;
end
endmodule

module BinaryToBCD(In, hunds, tens, units);
input [7:0] In;
output [3:0] hunds, tens, units;

wire [11:0] t;

assign units[0] = In[0];
add3 C1(In[6:3], t[3:0]);
add3 C2({t[2:0], In[2]}, t[7:4]);
add3 C3({2'b0, In[7], t[3]}, {hunds[1], t[10:8]});
add3 C4({t[6:4], In[1]}, {tens[0], units[3:1]});
add3 C5(t[10:7], {hunds[0], tens[3:1]});
assign hunds[3:2] = 2'b00;
endmodule

module  SevenSeg_CTRL(
  iCLK,
  nRST,
  iSEG7,
  iSEG6,
  iSEG5,
  iSEG4,
  iSEG3,
  iSEG2,
  iSEG1,
  iSEG0,
  oS_COM,
  oS_ENS
  );
  input iCLK, nRST;
  input[7:0] iSEG7, iSEG6, iSEG5, iSEG4, iSEG3, iSEG2, iSEG1, iSEG0;
  output reg[7:0]  oS_COM;
  output reg[7:0] oS_ENS;
  integer CNT_SCAN;
  
  always@(posedge iCLK) begin
    if(nRST)
        begin
          oS_COM <= 8'b0;
          oS_ENS <= 0;
          CNT_SCAN <= 0;
        end
      else
        begin
          if(CNT_SCAN >= 7)
            CNT_SCAN = 0;
          else
            CNT_SCAN = CNT_SCAN + 1;
            
          case(CNT_SCAN)
            0 :
            begin
              oS_COM <= 8'b11111110;
              oS_ENS <= iSEG0;
            end
            1 :
            begin
              oS_COM <= 8'b11111101;
              oS_ENS <= iSEG1;
            end
            2 :
            begin
              oS_COM <= 8'b11111011;
              oS_ENS <= iSEG2;
            end
            3 :
            begin
              oS_COM <= 8'b11110111;
              oS_ENS <= iSEG3;
            end
            4 :
            begin
              oS_COM <= 8'b11101111;
              oS_ENS <= iSEG4;
            end
            5 :
            begin
              oS_COM <= 8'b11011111;
              oS_ENS <= iSEG5;
            end
            6 :
            begin
              oS_COM <= 8'b10111111;
              oS_ENS <= iSEG6;
            end
            7 :
            begin
              oS_COM <= 8'b01111111;
              oS_ENS <= iSEG7;
            end
            default:
            begin
              oS_COM <= 8'b11111111;
              oS_ENS <= iSEG7;
            end
          endcase
        end
      end
endmodule

module BCDto7seg(I_BCD, O_seg);
    input [3:0] I_BCD;
    output reg [7:0] O_seg;

    always @(*) begin
        case (I_BCD)
            4'b0000 : O_seg <= 8'b11111100;
            4'b0001 : O_seg <= 8'b01100000;
            4'b0010 : O_seg <= 8'b11011010;
            4'b0011 : O_seg <= 8'b11110010;
            4'b0100 : O_seg <= 8'b01100110;
            4'b0101 : O_seg <= 8'b10110110;
            4'b0110 : O_seg <= 8'b10111110;
            4'b0111 : O_seg <= 8'b11100100;
            4'b1000 : O_seg <= 8'b11111110;
            4'b1001 : O_seg <= 8'b11110110;
            default : O_seg <= 8'bxxxxxxxx;
        endcase
    end
endmodule
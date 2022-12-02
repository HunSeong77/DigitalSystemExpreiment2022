module SR_FF(CLK, S, R, Q, Q_);
	input CLK, S, R;
	output Q, Q_;
	
	wire t1, t2;
	
	assign t1 = CLK & S;
	assign t2 = CLK & R;
	
	nor(Q, t1, Q_);
	nor(Q_, t2, Q);
endmodule

module state_memory(clk, nrst, button, fire,
    tank1_location, tank2_location, tank1_life, tank2_life, turn);
  input clk, nrst;
  input [1:0] button;
  input fire;
  output reg [3:0] tank1_location, tank2_location;
  output reg [1:0] tank1_life, tank2_life;
  output reg turn;

  initial begin
    tank1_location <= 4'b0100;
    tank2_location <= 4'b0010;
    tank1_life <= 2'b11;
    tank2_life <= 2'b11;
    turn <= 1'b0;
  end

  always @(posedge clk or negedge nrst) begin
    if(!nrst) begin
        tank1_location <= 4'b0100;
        tank2_location <= 4'b0010;
        tank1_life <= 2'b11;
        tank2_life <= 2'b11;
        turn <= 1'b0;
    end
    else begin
        if(turn == 1'b0) begin
            if(button[1] && !tank1_location[3]) begin
                tank1_location <= tank1_location << 1;
            end
            else if (button[0] && !tank1_location[1]) begin
                tank1_location <= tank1_location >> 1;
            end
        end
        else begin
            if(button[1] && !tank2_location[2]) begin
                tank2_location <= tank2_location << 1;
            end
            else if (button[0] && !tank2_location[0]) begin
                tank2_location <= tank2_location >> 1;
            end
        end
    end
  end

  always@(negedge fire) begin
    turn <= ~turn;
  end
endmodule


module tank_controller(
    tank1_location, tank2_location,
    tank1_life, tank2_life,
    SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7);
    input[3:0] tank1_location, tank2_location;
    input [1:0] tank1_life, tank2_life;
    output [7:0] SEG0, SEG1,SEG2,SEG3,SEG4,SEG5,SEG6,SEG7;
  
    assign SEG7 = {tank1_location[3] | tank1_location[2] ,tank1_life[0] | tank1_life[1], 1'b0, tank1_location[3], tank1_location[3], tank1_location[3], 1'b0, tank1_location[3]};
    assign SEG6 = {tank1_location[2] | tank1_location[1] , tank1_life[1], 1'b0, tank1_location[2], tank1_location[2], tank1_location[2], 1'b0, tank1_location[2]};
    assign SEG5 = {tank1_location[1] ,tank1_life[0] & tank1_life[1], 1'b0, tank1_location[1], tank1_location[1], tank1_location[1], 1'b0, tank1_location[1]};
    assign SEG4 = 8'b00000000;
    assign SEG3 = {tank2_location[2] ,7'b0000000};
    assign SEG2 = {tank2_location[2] | tank2_location[1] ,tank2_life[0] & tank2_life[1], 1'b0, tank2_location[2], tank2_location[2], tank2_location[2], 1'b0, tank2_location[2]};
    assign SEG1 = {tank2_location[1] | tank2_location[0] , tank2_life[1], 1'b0, tank2_location[1], tank2_location[1], tank2_location[1], 1'b0, tank2_location[1]};
    assign SEG0 = {tank2_location[0] , tank2_life[0] | tank2_life[1], 1'b0, tank2_location[0], tank2_location[0], tank2_location[0], 1'b0, tank2_location[0]};
endmodule

module SevenSeg_CTRL(
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
    output [7:0] oS_COM, oS_ENS;
    reg[7:0] oS_COM, oS_ENS;

    integer CNT_SCAN;

    always@(posedge iCLK or negedge nRST)
    begin
        if(!nRST)
        begin
            oS_COM <= 8'b00000000;
            oS_ENS <= 0;
            CNT_SCAN = 0;
        end

        else
        begin
            if(CNT_SCAN >= 7)
                CNT_SCAN = 0;
            else
                CNT_SCAN = CNT_SCAN + 1;
            
            case (CNT_SCAN)
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

                default :
                begin
                    oS_COM <= 8'b11111111;
                    oS_ENS <= iSEG7;
                end
                
            endcase
        end
    end

endmodule

module TEST(clk, nrst, button, oS_COM, oS_OUT);
  input clk, nrst;
  input[1:0] button;
  output [7:0] oS_COM, oS_OUT;
  
  wire [7:0] tank_state;
  wire [7:0] SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7;
  state_memory smmr(clk, nrst, button, tank_state);
  tank_controller tctrl(tank_state, SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7);
  SevenSeg_CTRL ssc(clk, rst, SEG7, SEG6, SEG5, SEG4, SEG3, SEG2, SEG1, SEG0, oS_COM, oS_OUT);
endmodule
  
  
  
  
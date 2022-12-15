module step(
input RESETN, CLK, SENSE, 
input OPP, //입력하면 방향바뀜
output STEP_A, STEP_B,
output STEP_AN, STEP_BN
);

reg [3:0] BUFF;
integer CNT;
integer CNT_SENSE;
reg DIRECTION;
reg STATE; //스위치의 상태를 나타냄

always @(posedge SENSE or negedge RESETN) //magnetic pin지날때
begin
  if (~RESETN)
    begin
      CNT_SENSE = 0;
      DIRECTION = 1'b0;
    end
  else
    begin
       if (CNT_SENSE >= 5)
//5바퀴 지나면 방향 바꿈
         begin
           CNT_SENSE = 0;
          DIRECTION = ~DIRECTION;
         end
      else if(OPP==0 && STATE==1) 
//스위치를 올림에서 내렸을때
      begin
      CNT_SENSE = 0;
      DIRECTION = ~DIRECTION;
      STATE=0; //내림 상태를 나타냄
      end
      else if(OPP==1 && STATE==0) 
//스위치를 내림에서 올렸을때
      begin
      CNT_SENSE = 0;
      DIRECTION = ~DIRECTION;
      STATE=1; //올림 상태를 나타냄
      end
       else
         CNT_SENSE = CNT_SENSE + 1;
    end
end

always @(posedge CLK or negedge RESETN) 
//모터가 돌아가는 것을 구현함
begin
  if (~RESETN)
    begin
     BUFF = 4'b0000;
      CNT = 0;
    end
  else
    begin
       if (CNT >= 3)
         CNT = 0;
       else
         CNT = CNT + 1;
       
       if (DIRECTION)
         begin
            case (CNT)
             0 : BUFF = // implement your code here
             1 : BUFF = // implement your code here
             2 : BUFF = // implement your code here
             3 : BUFF = // implement your code here
             default : BUFF = 4'b0000;
           endcase
         end
       else
         begin
            case (CNT)
             0 : BUFF = // implement your code here  
             1 : BUFF = // implement your code here  
             2 : BUFF = // implement your code here  
             3 : BUFF = // implement your code here  
             default : BUFF = 4'b0000;
           endcase
        end
    end
end

assign STEP_A = BUFF[3];
assign STEP_B = BUFF[2];
assign STEP_AN = BUFF[1];
assign STEP_BN = BUFF[0];

endmodule 
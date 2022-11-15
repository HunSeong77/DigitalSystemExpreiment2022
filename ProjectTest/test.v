
module servo(CLK, ANG, Q);
// ANG을 DIP SWITCH 1, 2에 넣고
// SERVO MOTOR의 동작을 확인해보자
// CLK의 frequency가 충분히 커야함
    input CLK;
    input [1:0] ANG;
    output Q;

    integer cnt;
    integer pos;

    initial begin
        cnt = 0;
        pos = 6 * ANG[1] + 3 * ANG[0];
    end

    always@(posedge CLK) begin
        if (cnt < 10) cnt = cnt + 1;
        else cnt = 0;
    end

    assign Q = (cnt < pos);
endmodule

module movingLED(CLK, reset_n, button, LED);
// reset을 Keypad 0, button을 #에 넣고
// LED의 동작을 확인해 보자
    input CLK, reset;
    input button;
    output [7:0] LED;

    reg pushed;
    integer i;
    initial begin
        i = 0;
        pushed = 0;
    end

    always@(posedge CLK or negedge reset_n) begin
        if(reset_n == 0) begin
            i = 0;
            pushed = 0;
        end
        if(button == 1)
            pushed = 1;
        if(pushed == 0) begin
            if(i < 16) i = i + 1;
            else i = 0;
    end

    assign LED[0] = (i == 0 || i == 8);
    assign LED[1] = (i == 1 || i == 9);
    assign LED[2] = (i == 2 || i == 10);
    assign LED[3] = (i == 3 || i == 11);
    assign LED[4] = (i == 4 || i == 12);
    assign LED[5] = (i == 5 || i == 13);
    assign LED[6] = (i == 6 || i == 14);
    assign LED[7] = (i == 7 || i == 15);
endmodule

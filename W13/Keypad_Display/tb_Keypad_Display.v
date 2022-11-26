`timescale 10ps/1ps

module tb_Keypad_Display();
    reg nRST, iCLK;
    reg [11:0] iKeypad;

    wire[7:0] Data_out, Data_en;

    always #5 iCLK = ~iCLK;

    Keypad_Display keypad_display(
        .nRST(nRST),
        .iCLK(iCLK),
        .iKeypad(iKeypad),
        .oS_COM(Data_en),
        .oS_ENS(Data_out)
    );

    initial begin
        nRST <= 1;
        iCLK <= 0;
        iKeypad <= 12'b0;

        #10 nRST <= 0;
        #20 nRST <= 1;

        #17 iKeypad <= 12'b000000000001;
        #32 iKeypad <= 12'b0;

        #17 iKeypad <= 12'b000000000010;
        #32 iKeypad <= 12'b0;

        #17 iKeypad <= 12'b010000000000;
        #32 iKeypad <= 12'b0;

        #17 iKeypad <= 12'b100000000000;
        #32 iKeypad <= 12'b0;

        #17 iKeypad <= 12'b000001000000;
        #32 iKeypad <= 12'b0;

        #17 iKeypad <= 12'b100000000000;
        #32 iKeypad <= 12'b0;

        #17 iKeypad <= 12'b001000000000;
        #32 iKeypad <= 12'b0;

        #17 iKeypad <= 12'b010000000000;
        #32 iKeypad <= 12'b0;

        $stop;
    end
endmodule
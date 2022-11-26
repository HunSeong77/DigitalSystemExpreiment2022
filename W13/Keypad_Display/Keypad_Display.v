module Keypad_Display(iKeypad, nRST, iCLK, oS_COM, oS_ENS);
    input [11:0] iKeypad;
    input nRST, iCLK;
    output [7:0] oS_COM, oS_ENS;

    wire [11:0] Scan_out;
    wire valid;

    wire [6:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
    wire Out_en;
    
    wire [6:0] reg_seg1, reg_seg2, reg_seg3, reg_seg4, reg_seg5, reg_seg6, reg_seg7, reg_seg8;

    Keypad_scan keypad_scan(
        .Keypad_in(iKeypad),
        .rst(nRST),
        .clk(iCLK),
        .Scan_out(Scan_out),
        .valid(valid)
    );

    Display display(
        .Scan_data(Scan_out),
        .valid(valid),
        .rst(nRST),
        .clk(iCLK),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3),
        .seg4(seg4),
        .seg5(seg5),
        .seg6(seg6),
        .seg7(seg7),
        .seg8(seg8),
        .Out_en(Out_en)
    );

    Reg r1(.en(Out_en), .rst(nRST), .clk(iCLK), .In(seg1), .Out(reg_seg1));
    Reg r2(.en(Out_en), .rst(nRST), .clk(iCLK), .In(seg2), .Out(reg_seg2));
    Reg r3(.en(Out_en), .rst(nRST), .clk(iCLK), .In(seg3), .Out(reg_seg3));
    Reg r4(.en(Out_en), .rst(nRST), .clk(iCLK), .In(seg4), .Out(reg_seg4));
    Reg r5(.en(Out_en), .rst(nRST), .clk(iCLK), .In(seg5), .Out(reg_seg5));
    Reg r6(.en(Out_en), .rst(nRST), .clk(iCLK), .In(seg6), .Out(reg_seg6));
    Reg r7(.en(Out_en), .rst(nRST), .clk(iCLK), .In(seg7), .Out(reg_seg7));
    Reg r8(.en(Out_en), .rst(nRST), .clk(iCLK), .In(seg8), .Out(reg_seg8));

    SevenSeg_CTRL sevenseg_ctrl(
        .iCLK(iCLK),
        .nRST(nRST),
        .iSEG7({reg_seg8, 1'b0}),
        .iSEG6({reg_seg7, 1'b0}),
        .iSEG5({reg_seg6, 1'b0}),
        .iSEG4({reg_seg5, 1'b0}),
        .iSEG3({reg_seg4, 1'b0}),
        .iSEG2({reg_seg3, 1'b0}),
        .iSEG1({reg_seg2, 1'b0}),
        .iSEG0({reg_seg1, 1'b0}),
        .oS_COM(oS_COM),
        .oS_ENS(oS_ENS)
    );
    
endmodule
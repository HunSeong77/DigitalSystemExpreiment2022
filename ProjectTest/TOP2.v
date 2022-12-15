module TOP(clk, nrst, key_4, key_5, key_6,
        oS_COM, oS_ENS, o_LED, o_piezo);
    
    input clk, nrst;
    input key_4, key_5, key_6;

    output [7:0] oS_COM, oS_ENS;
    output [7:0] o_LED;
    output o_piezo;

    wire clk_khz;
    wire scan_key_4, scan_key_5, scan_key_6;
    wire fire, turn;
    wire [3:0] tank1_location, tank2_location;
    wire [1:0] tank1_life, tank2_life;
    wire [1:0] dist;

    wire[7:0] SHELL;
    wire [7:0] TANK [7:0];

    wire [7:0] SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7;

    wire clk32;

    assign SEG0 = { TANK[0][7:2], TANK[0][1] ^ SHELL[0], TANK[0][0] };
    assign SEG1 = { TANK[1][7:2], TANK[1][1] ^ SHELL[1], TANK[1][0] };
    assign SEG2 = { TANK[2][7:2], TANK[2][1] ^ SHELL[2], TANK[2][0] };
    assign SEG3 = { TANK[3][7:2], TANK[3][1] ^ SHELL[3], TANK[3][0] };
    assign SEG4 = { TANK[4][7:2], TANK[4][1] ^ SHELL[4], TANK[4][0] };
    assign SEG5 = { TANK[5][7:2], TANK[5][1] ^ SHELL[5], TANK[5][0] };
    assign SEG6 = { TANK[6][7:2], TANK[6][1] ^ SHELL[6], TANK[6][0] };
    assign SEG7 = { TANK[7][7:2], TANK[7][1] ^ SHELL[7], TANK[7][0] };


    Piezo piezo(clk, !nrst, tank1_life, tank2_life, o_piezo);

    Keypad_Scan keypadScan(.clk(clk_khz), .rst(!nrst), 
        .keypad_in({key_4, key_5, key_6}),
        .scan_out({scan_key_4, scan_key_5, scan_key_6}));

    Tank_State_Memory tankStateMemory(.clk(clk_khz), .nrst(!nrst), 
        .button({scan_key_4, scan_key_6}), .fire(fire), .hit(hit),
        .tank1_location(tank1_location), .tank2_location(tank2_location),
        .tank1_life(tank1_life), .tank2_life(tank2_life), .turn(turn));


    Shell_State_Memory shellStateMemory(.clk(clk_khz), .nrst(!nrst), .button(scan_key_5), .power(o_LED),
            .tank1_location(tank1_location), .tank2_location(tank2_location),
            .turn(turn), .Q(dist), .fire(fire), .hit(hit));

    Shell_Controller shellController(.clk(clk_khz), .nrst(!nrst),
        .tank1_location(tank1_location), .tank2_location(tank2_location),
        .turn(turn), .power(dist), .fire(fire),
        .SEG0(SHELL[0]), .SEG1(SHELL[1]), .SEG2(SHELL[2]),
        .SEG3(SHELL[3]), .SEG4(SHELL[4]), .SEG5(SHELL[5]),
        .SEG6(SHELL[6]), .SEG7(SHELL[7]));

    Tank_Controller tankController(.tank1_location(tank1_location),
    .tank2_location(tank2_location),
    .tank1_life(tank1_life), .tank2_life(tank2_life), 
    .SEG0(TANK[0]), .SEG1(TANK[1]), .SEG2(TANK[2]),
    .SEG3(TANK[3]), .SEG4(TANK[4]), .SEG5(TANK[5]),
    .SEG6(TANK[6]), .SEG7(TANK[7]));

    SevenSeg_CTRL sevenSegController(
        .iCLK(clk_khz), .nRST(!nrst),
        .iSEG0(SEG0), .iSEG1(SEG1), .iSEG2(SEG2),
        .iSEG3(SEG3), .iSEG4(SEG4), .iSEG5(SEG5),
        .iSEG6(SEG6), .iSEG7(SEG7),
        .oS_COM(oS_COM), .oS_ENS(oS_ENS));

    clk_devider CLKDEV(.clk(clk_khz), .nrst(!nrst), .clk32(clk32));
	clk_devider CLKDEV2(.clk(clk), .nrst(!nrst), .clk1024(clk_khz));
    LED led(.CLK(clk32), .en(!fire), .O(o_LED));
endmodule
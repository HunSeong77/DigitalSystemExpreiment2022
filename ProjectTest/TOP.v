module TOP(clk, nrst, key_4, key_5, key_6,
        oS_COM, oS_ENS, o_LED);
    
    input clk, nrst;
    input key_4, key_5, key_6;

    output [7:0] oS_COM, oS_ENS;
    output [7:0] o_LED;

    wire scan_key_4, scan_key_5, scan_key_6;
    wire fire, turn;
    wire [3:0] tank1_location, tank2_location;
    wire [1:0] tank1_life, tank2_life;
    wire [1:0] dist;

    wire[7:0] SHELL;
    wire [7:0] TANK [7:0];

    wire [7:0] SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7;

    wire clk32;

    assign SEG0 = { TANK[0][7] ^ SHELL[0], TANK[0][6:0] };
    assign SEG1 = { TANK[1][7] ^ SHELL[1], TANK[1][6:0] };
    assign SEG2 = { TANK[2][7] ^ SHELL[2], TANK[2][6:0] };
    assign SEG3 = { TANK[3][7] ^ SHELL[3], TANK[3][6:0] };
    assign SEG4 = { TANK[4][7] ^ SHELL[4], TANK[4][6:0] };
    assign SEG5 = { TANK[5][7] ^ SHELL[5], TANK[5][6:0] };
    assign SEG6 = { TANK[6][7] ^ SHELL[6], TANK[6][6:0] };
    assign SEG7 = { TANK[7][7] ^ SHELL[7], TANK[7][6:0] };

    keypad_scan keypadScan(.clk(clk), .rst(!nrst), 
        .keypad_in({key_4, key_5, key_6}),
        .scan_out({scan_key_4, scan_key_5, scan_key_6}));

    state_memory stateMemory(.clk(clk), .nrst(!nrst), 
        .button({scan_key_4, scan_key_6}), .fire(fire),
        .tank1_location(tank1_location), .tank2_location(tank2_location),
        .tank1_life(tank1_life), .tank2_life(tank2_life), .turn(turn));

    cannon Cannon(.clk(clk), .nrst(!nrst), .button(scan_key_5), .power(o_LED),
            .Q(dist), .fire(fire));

    ShellCTRL shellController(.clk(clk), .nrst(!nrst),
        .tank1_location(tank1_location), .tank2_location(tank2_location),
        .turn(turn), .power(dist), .fire(fire),
        .SEG0(SHELL[0]), .SEG1(SHELL[1]), .SEG2(SHELL[2]),
        .SEG3(SHELL[3]), .SEG4(SHELL[4]), .SEG5(SHELL[5]),
        .SEG6(SHELL[6]), .SEG7(SHELL[7]));

    tank_controller tankController(.tank1_location(tank1_location),
    .tank2_location(tank2_location),
    .tank1_life(tank1_life), .tank2_life(tank2_life), 
    .SEG0(TANK[0]), .SEG1(TANK[1]), .SEG2(TANK[2]),
    .SEG3(TANK[3]), .SEG4(TANK[4]), .SEG5(TANK[5]),
    .SEG6(TANK[6]), .SEG7(TANK[7]));

    SevenSeg_CTRL sevenSegController(
        .iCLK(clk), .nRST(!nrst),
        .iSEG0(SEG0), .iSEG1(SEG1), .iSEG2(SEG2),
        .iSEG3(SEG3), .iSEG4(SEG4), .iSEG5(SEG5),
        .iSEG6(SEG6), .iSEG7(SEG7),
        .oS_COM(oS_COM), .oS_ENS(oS_ENS));

    clk_devider CLKDEV(.clk(clk), .nrst(!nrst), .clk32(clk32));

    LED led(.CLK(clk32), .en(!fire), .O(o_LED));
endmodule
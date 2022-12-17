module FORTRESS(i_clk, i_nrst, i_key_4, i_key_5, i_key_6,
    o_piezo, o_LED, o_COM, o_ENS);
input i_clk, i_nrst, i_key_4, i_key_5, i_key_6;
output o_piezo;
output [7:0] o_LED, o_COM, o_ENS;

wire nrst;
wire clk_khz, clk_32hz;
wire scan_key_4, scan_key_5, scan_key_6;
wire fire;
wire[1:0] tank1_life, tank2_life;
wire [7:0] SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7;
wire [7:0] shell_location;

assign nrst = !i_nrst;

clk_devider clkdev1(.clk(i_clk), .nrst(nrst), .clk1024(clk_khz));
clk_devider clkdev2(.clk(clk_khz), .nrst(nrst), .clk32(clk_32hz));

Keypad_Scan keypadScan(.clk(clk_khz), .nrst(nrst), .keypad_in({i_key_4, i_key_5, i_key_6}),
    .scan_out({scan_key_4, scan_key_5, scan_key_6}));

TANK tank(.clk(clk_khz), .nrst(nrst), .key_4(scan_key_4), .key_5(scan_key_5), .key_6(scan_key_6),
    .power(o_LED), .fire(fire), .tank1_life(tank1_life), .tank2_life(tank2_life), .SHELL(shell_location),
    .SEG0(SEG0), .SEG1(SEG1), .SEG2(SEG2), .SEG3(SEG3), .SEG4(SEG4),
    .SEG5(SEG5), .SEG6(SEG6), .SEG7(SEG7));

SevenSeg_CTRL sevenSegCtrl(.iCLK(clk_khz), .nRST(nrst), 
    .iSEG0(SEG0), .iSEG1(SEG1), .iSEG2(SEG2), .iSEG3(SEG3), .iSEG4(SEG4), 
    .iSEG5(SEG5), .iSEG6(SEG6), .iSEG7(SEG7), .oS_COM(o_COM), .oS_ENS(o_ENS));

Piezo piezo(.clk(i_clk), .nrst(nrst), .tank1_life(tank1_life), .tank2_life(tank2_life), .shell_location(shell_location),
		.fire(fire), .piezo_out(o_piezo));

LED led(.clk(clk_32hz), .en(!fire), .O(o_LED));

endmodule

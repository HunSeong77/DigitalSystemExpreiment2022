module tb_Display();
    reg rst, clk, valid;
    reg [11:0] Scan_data;

    wire [6:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
    wire Out_en;

    Display display(rst, clk, valid, Scan_data, seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8, Out_en);

    always #5 clk = ~clk;

    initial begin
        clk <= 0;
        rst <= 1;
        valid <= 0;
        Scan_data <= 12'b0;

        #10 rst <= 0;
        #20 rst <= 1;

        #10 Scan_data <= 12'b000000000001; valid <= 1;
        #5 Scan_data <= 12'b0; valid <= 0;

        #35 Scan_data <= 12'b100000000000; valid <= 1;
        #5 Scan_data <= 12'b0; valid <= 0;

        #35 Scan_data <= 12'b000000000010; valid <= 1;
        #5 Scan_data <= 12'b0; valid <= 0;

        #35 Scan_data <= 12'b010000000000; valid <= 1;
        #5 Scan_data <= 12'b0; valid <= 0;

        #35 Scan_data <= 12'b100000000000; valid <= 1;
        #5 Scan_data <= 12'b0; valid <= 0;

        #35 Scan_data <= 12'b001000000000; valid <= 1;
        #5 Scan_data <= 12'b0; valid <= 0;

        #100 $stop;
    end
endmodule




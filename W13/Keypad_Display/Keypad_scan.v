module Keypad_scan(rst, clk, Keypad_in, valid, Scan_out);
    input [11:0] Keypad_in;
    input rst, clk;

    output [11:0] Scan_out;
    output valid;

    reg [11:0] Scan_out;


    assign valid = Scan_out || 0; // if 

    always@(Keypad_in) begin
        Scan_out <= Keypad_in;
    end

    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            Scan_out <= 12'b0;
        end
        else begin
            if (Scan_out != 12'b0) begin
                Scan_out <= 12'b0;
            end
        end
    end

endmodule
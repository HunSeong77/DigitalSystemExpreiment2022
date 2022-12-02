module ShellCTRL(
    clk, nrst,
    tank1_location, tank2_location, turn, power, fire,
    SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7);
    input clk, nrst;
    input [3:0] tank1_location, tank2_location;
    input turn, fire;
    input [1:0] power;
    output SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7;

    reg [7:0] shell;

    assign SEG0 = shell[0];
    assign SEG1 = shell[1];
    assign SEG2 = shell[2];
    assign SEG3 = shell[3];
    assign SEG4 = shell[4];
    assign SEG5 = shell[5];
    assign SEG6 = shell[6];
    assign SEG7 = shell[7];

    always@(posedge clk or negedge nrst) begin
        if(!nrst) begin
            shell <= 8'b00100000;
        end
        else begin
            if(!fire) begin
                if(!turn) begin
                    shell <= {tank1_location, 4'b0000} >> 1;
                end
                else begin
                    shell <= {4'b0000, tank2_location} << 1;
                end
            end
            else begin
                if(!turn) begin
                    shell <= {tank1_location, 4'b0000} >> power+2;
                end
                if(turn) begin
                    shell <= {4'b0000, tank2_location} << power+2;
                end
            end
        end
    end
endmodule
    

module cannon(
    clk, nrst, button, power,
    Q, fire
);
    input clk, nrst, button;
    input [7:0] power;

    output [1:0] Q;
    output fire;

    wire [1:0] power_2bit;

    reg [5:0] cnt;
    reg fire;

    assign power_2bit[1] = power[3];
    assign power_2bit[0] = (!power[3] & power[5]) | power[1];

    assign Q = cnt[5:4];

    initial begin
        fire <= 1'b0;
        cnt <= 7'b0;
    end

    always@(posedge clk or negedge nrst) begin
        if(!nrst) begin
            fire <= 1'b0;
            cnt <= 6'b0;
        end
        else begin
            if(button) begin
                fire <= 1'b1;
            end
            if(fire) begin
                if(cnt < {power_2bit, 4'b1111}) begin
                    cnt <= cnt + 1;
                end
                else begin
                    fire <= 1'b0;
                    cnt <= 6'b0;
                end
            end
        end
    end
endmodule


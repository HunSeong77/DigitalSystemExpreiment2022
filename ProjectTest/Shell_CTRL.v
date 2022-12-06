module Shell_Controller(
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
    

module Shell_State_Memory(
    clk, nrst, button, power, tank1_location, tank2_location, turn,
    Q, fire, hit
);
    input clk, nrst, button;
    input [7:0] power;
    input [3:0] tank1_location, tank2_location;
    input turn;

    output [1:0] Q;
    output fire;
    output hit;

    wire [1:0] power_2bit;

    reg [10:0] cnt;
    reg fire;
    reg hit;
    reg en_hit;

    assign power_2bit[1] = power[3];
    assign power_2bit[0] = (!power[3] & power[5]) | power[1];

    assign Q = cnt[10:9];

    initial begin
        fire <= 1'b0;
        cnt <= 11'b0;
        hit <= 1'b0;
        en_hit <= 1'b0;
    end

    always@(posedge clk or negedge nrst) begin
        if(!nrst) begin
            fire <= 1'b0;
            cnt <= 11'b0;
            hit <= 1'b0;
            en_hit <= 1'b0;
        end
        else begin
            if(button) begin
                fire <= 1'b1;
            end
            if(fire) begin
                if(~hit && ~en_hit) begin
                    en_hit <= 1'b1;
                    if(turn) begin
                        if({tank1_location, 4'b0000} >> power_2bit + 2 == {4'b0000, tank2_location})
                        hit <= 1'b1;
                    end
                    else begin
                        if({4'b0000, tank2_location} << power_2bit + 2 == {tank1_location, 4'b0000})
                        hit <= 1'b1;
                    end
                end
                if(cnt < {power_2bit, 9'b111111111}) begin
                    cnt <= cnt + 1;
                end
                else begin
                    fire <= 1'b0;
                    cnt <= 11'b0;
                    en_hit <= 1'b0;
                end
            end
            if(hit && ~en_hit) hit <= 1'b0;
        end
    end
endmodule

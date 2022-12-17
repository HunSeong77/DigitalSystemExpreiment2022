module TANK(clk, nrst, key_4, key_5, key_6, power,
        fire, tank1_life, tank2_life, SHELL, SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7);
    input clk, nrst, key_4, key_5, key_6;
    input [7:0] power;
    output fire;
    output [1:0] tank1_life, tank2_life;
    output [7:0] SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7;
    output [7:0] SHELL;

    wire hit, turn;
    wire [3:0] tank1_location, tank2_location;
    wire [1:0] dist;

    wire [7:0] TANK [7:0];

    assign SEG0 = { TANK[0][7:2], TANK[0][1] ^ SHELL[0], TANK[0][0] };
    assign SEG1 = { TANK[1][7:2], TANK[1][1] ^ SHELL[1], TANK[1][0] };
    assign SEG2 = { TANK[2][7:2], TANK[2][1] ^ SHELL[2], TANK[2][0] };
    assign SEG3 = { TANK[3][7:2], TANK[3][1] ^ SHELL[3], TANK[3][0] };
    assign SEG4 = { TANK[4][7:2], TANK[4][1] ^ SHELL[4], TANK[4][0] };
    assign SEG5 = { TANK[5][7:2], TANK[5][1] ^ SHELL[5], TANK[5][0] };
    assign SEG6 = { TANK[6][7:2], TANK[6][1] ^ SHELL[6], TANK[6][0] };
    assign SEG7 = { TANK[7][7:2], TANK[7][1] ^ SHELL[7], TANK[7][0] };

    Tank_State_Memory tankStateMemory(.clk(clk), .nrst(nrst), 
        .button({key_4, key_6}), .fire(fire), .hit(hit),
        .tank1_location(tank1_location), .tank2_location(tank2_location),
        .tank1_life(tank1_life), .tank2_life(tank2_life), .turn(turn));

    Tank_Controller tankController(.tank1_location(tank1_location),
    .tank2_location(tank2_location),
    .tank1_life(tank1_life), .tank2_life(tank2_life), 
    .SEG0(TANK[0]), .SEG1(TANK[1]), .SEG2(TANK[2]),
    .SEG3(TANK[3]), .SEG4(TANK[4]), .SEG5(TANK[5]),
    .SEG6(TANK[6]), .SEG7(TANK[7]));

    Shell_State_Memory shellStateMemory(.clk(clk), .nrst(nrst), .button(key_5), .power(power),
        .tank1_location(tank1_location), .tank2_location(tank2_location),
        .turn(turn), .Q(dist), .fire(fire), .hit(hit));

    Shell_Controller shellController(.clk(clk), .nrst(nrst),
        .tank1_location(tank1_location), .tank2_location(tank2_location),
        .turn(turn), .power(dist), .fire(fire),
        .SEG0(SHELL[0]), .SEG1(SHELL[1]), .SEG2(SHELL[2]),
        .SEG3(SHELL[3]), .SEG4(SHELL[4]), .SEG5(SHELL[5]),
        .SEG6(SHELL[6]), .SEG7(SHELL[7]));
endmodule

module Tank_State_Memory(clk, nrst, button, fire, hit,
    tank1_location, tank2_location, tank1_life, tank2_life, turn);
  input clk, nrst;
  input [1:0] button;
  input fire;
  input hit;
  output reg [3:0] tank1_location, tank2_location;
  output reg [1:0] tank1_life, tank2_life;
  output reg turn;
  reg en_fire;

  initial begin
    tank1_location <= 4'b0100;
    tank2_location <= 4'b0010;
    tank1_life <= 2'b11;
    tank2_life <= 2'b11;
    turn <= 1'b1;
    en_fire <= 1'b0;
  end

  always @(posedge clk or negedge nrst) begin
    if(!nrst) begin
        tank1_location <= 4'b0100;
        tank2_location <= 4'b0010;
        tank1_life <= 2'b11;
        tank2_life <= 2'b11;
        turn <= 1'b1;
        en_fire <= 1'b0;
    end
    else if(!fire) begin
			
        if(!en_fire) begin
				if(tank1_life != 2'b00 && tank2_life != 2'b00) begin
					if(hit && turn) tank1_life = tank1_life - 1;
					else if (hit && !turn) tank2_life = tank2_life - 1;
				
					if(tank1_life == 2'b00) tank1_location <= 4'b0000;
					else if (tank2_life == 2'b00) tank2_location <= 4'b0000;
					else turn <= !turn;
				end
            en_fire <= 1'b1;
        end

        if(turn == 1'b0) begin
            if(button[1] && !tank1_location[3]) begin
                tank1_location <= tank1_location << 1;
            end
            else if (button[0] && !tank1_location[1]) begin
                tank1_location <= tank1_location >> 1;
            end
        end
        else begin
            if(button[1] && !tank2_location[2]) begin
                tank2_location <= tank2_location << 1;
            end
            else if (button[0] && !tank2_location[0]) begin
                tank2_location <= tank2_location >> 1;
            end
        end
    end
    else begin
        en_fire <= 1'b0;
    end
  end
endmodule

module Tank_Controller(
    tank1_location, tank2_location,
    tank1_life, tank2_life,
    SEG0, SEG1, SEG2, SEG3, SEG4, SEG5, SEG6, SEG7);
    input[3:0] tank1_location, tank2_location;
    input [1:0] tank1_life, tank2_life;
    output [7:0] SEG0, SEG1,SEG2,SEG3,SEG4,SEG5,SEG6,SEG7;
  
    assign SEG7 = {tank1_life[0] | tank1_life[1], 1'b0, tank1_location[3], tank1_location[3], tank1_location[3], 1'b0, tank1_location[3], tank1_location[3] | tank1_location[2] };
    assign SEG6 = {tank1_life[1], 1'b0, tank1_location[2], tank1_location[2], tank1_location[2], 1'b0, tank1_location[2], tank1_location[2] | tank1_location[1] };
    assign SEG5 = {tank1_life[0] & tank1_life[1], 1'b0, tank1_location[1], tank1_location[1], tank1_location[1], 1'b0, tank1_location[1], tank1_location[1] };
    assign SEG4 = 8'b00000000;
    assign SEG3 = {7'b0000000, tank2_location[2] };
    assign SEG2 = {tank2_life[0] & tank2_life[1], 1'b0, tank2_location[2], tank2_location[2], tank2_location[2], 1'b0, tank2_location[2], tank2_location[2] | tank2_location[1]};
    assign SEG1 = {tank2_life[1], 1'b0, tank2_location[1], tank2_location[1], tank2_location[1], 1'b0, tank2_location[1], tank2_location[1] | tank2_location[0] };
    assign SEG0 = {tank2_life[0] | tank2_life[1], 1'b0, tank2_location[0], tank2_location[0], tank2_location[0], 1'b0, tank2_location[0], tank2_location[0]};
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
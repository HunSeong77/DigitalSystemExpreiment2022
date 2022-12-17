module Piezo(clk, nrst, tank1_life, tank2_life, shell_location, fire, piezo_out);
    input clk, nrst;
    input [1:0] tank1_life, tank2_life;
	 input [7:0] shell_location;
	 input fire;
    output piezo_out;

    wire piezo1, piezo2, piezo3;
    wire cong_en;

    assign cong_en = (!tank1_life[1] & !tank1_life[0]) | (!tank2_life[0] & !tank2_life[1]);
    assign piezo_out = piezo1 | piezo2 | piezo3;

    hit_feedback hitFeedback(clk, nrst, tank1_life, tank2_life, piezo1);
    congratulation cong(clk, nrst, cong_en, piezo2);
	 fire_feedback fireFeedback(clk, nrst, shell_location, fire, piezo3);
endmodule

module fire_feedback(clk, nrst, shell_location, fire, piezo_out);
	input clk, nrst, fire;
	input [7:0] shell_location;
	output piezo_out;
	
	integer timePass, cnt, limit;
	reg buff, en;
	reg [7:0] reg_shell_loc;

	assign piezo_out = buff;
	
	initial begin
			timePass = 0;
			cnt = 0;
			limit = 1000;
			reg_shell_loc = 8'b00100000;
			buff = 1'b0;
			en = 1'b0;
		end
   
	always@(posedge clk or negedge nrst) begin
		if(!nrst) begin
			timePass = 0;
			cnt = 0;
			limit = 1000;
			reg_shell_loc = 8'b00100000;
			buff = 1'b0;
			en = 1'b0;
			end
		else begin
			if(fire) begin
				if(shell_location != reg_shell_loc) begin
				reg_shell_loc = shell_location;
				en = 1'b1;
				end
			end
			if(en) begin
				timePass = timePass + 1;
				cnt = cnt + 1;
				if(cnt > limit) begin
					cnt = 0;
					buff = !buff;
				end
				if(timePass > 100000) begin
					cnt = 0;
					timePass = 0;
					en = 1'b0;
					buff = 1'b0;
				end
			end
			else begin
				cnt = 0;
				timePass = 0;
				en = 1'b0;
				buff = 1'b0;
			end
		end
	end
endmodule		

module hit_feedback(clk, nrst, tank1_life, tank2_life, piezo_out);
    input clk, nrst;
    input [1:0] tank1_life, tank2_life;
    output piezo_out;

    reg [1:0] reg_tank1_life, reg_tank2_life;
    reg buff, en;

    assign piezo_out = buff;

    integer timePass, cnt, limit;

    initial begin
        reg_tank1_life = 2'b11;
        reg_tank2_life = 2'b11;
        en = 1'b0;
        buff = 1'b0;
        timePass = 0;
        cnt = 0;
        limit = 500;
    end

    always@(posedge clk or negedge nrst) begin
        if(!nrst) begin
            reg_tank1_life = 2'b11;
            reg_tank2_life = 2'b11;
            en = 1'b0;
            buff = 1'b0;
            timePass = 0;
            cnt = 0;
            limit = 500;
        end
        else if(tank1_life != 2'b00 && tank2_life != 2'b00)
            begin
            if(reg_tank1_life != tank1_life || reg_tank2_life != tank2_life) begin
                reg_tank1_life = tank1_life;
                reg_tank2_life = tank2_life;
                en = 1'b1;
            end
            if(en) begin
                if(cnt >= limit) begin
                    cnt = 0;
                    buff = !buff;
                    timePass = timePass + 1;
                end
                else begin
                    cnt = cnt + 1;
                    timePass = timePass + 1;
                end
                if(timePass >= 200000) begin
                    cnt = 0;
                    timePass = 0;
                    buff = 1'b0;
                    en = 1'b0;
                end
            end
        end
    end
endmodule

module congratulation(clk, nrst, en, piezo_out);
    input clk, nrst, en;
    output piezo_out;

    reg buff;
    assign piezo_out = buff;

    integer cnt, beat, i;
    integer cn_sound, limit;

    integer LB, D, DS, E, G, A, B;

    initial begin
        buff <= 1'b0;
        cnt <= 0;
        beat <= 65535; // 1/8 second, 1/16 beat
        i <= 129;
        cn_sound = 0;
        limit = 65535;
            LB <= 4246;
				D <= 3570;
				DS <= 3370;
				E <= 3182;
				G <= 2676;
				A <= 2384;
				B <= 2124;

    end

    always@(posedge clk or negedge nrst) begin
        if(!nrst) begin
            buff = 1'b0;
            cnt = 0;
            beat = 65535; // 1/16 beat, 3 beat / sec
            i = 129;
            cn_sound = 0;
            LB <= 4246;
				D <= 3570;
				DS <= 3370;
				E <= 3182;
				G <= 2676;
				A <= 2384;
				B <= 2124;

        end
        else if (en) begin
            if(cnt >= beat) begin
                cnt = 0;
                cn_sound = 0;
                i = i + 1;
            end
            if(i >= 577) begin
                i = 129; // infinite loop
            end
            if(cn_sound >= limit) begin
                cn_sound = 0;
                buff = !buff;
                cnt = cnt + 1;
            end
            else begin
                cn_sound = cn_sound + 1;
                cnt = cnt + 1;
            end
        end
        else begin
            buff = 1'b0;
            cnt = 0;
            beat = 65535; // 1/16 beat
            i = 129;
            cn_sound = 0;
            LB <= 4246;
				D <= 3570;
				DS <= 3370;
				E <= 3182;
				G <= 2676;
				A <= 2384;
				B <= 2124;

        end
    end

    always@(i) begin
        case(i)
        0   : limit = beat; // break

        1   : limit = E;
        2   : limit = E;
        3   : limit = E; 
        4   : limit = beat;

        5   : limit = E;
        6   : limit = E;
        7   : limit = E;
        8   : limit = beat;

        9   : limit = E;
        10  : limit = E;
        11  : limit = G;
        12  : limit = G;

        13  : limit = G;
        14  : limit = G;
        15  : limit = A;
        16  : limit = A;

        17   : limit = A;
        18   : limit = A;
        19   : limit = A; 
        20   : limit = A;

        21   : limit = A;
        22   : limit = A;
        23   : limit = A;
        24   : limit = A;

        25  : limit = A;
        26  : limit = A;
        27  : limit = A;
        28  : limit = A;

        29  : limit = beat;
        30  : limit = beat;
        31  : limit = beat;
        32  : limit = beat;

        33  : limit = E;
        34  : limit = E;
        35  : limit = E;
        36  : limit = beat;

        37  : limit = E;
        38  : limit = E;
        39  : limit = E;
        40  : limit = beat;

        41  : limit = E;
        42  : limit = E;
        43  : limit = G;
        44  : limit = G;

        45  : limit = G;
        46  : limit = G;
        47  : limit = G;
        48  : limit = G;

        49  : limit = A;
        50  : limit = A;
        51  : limit = A;
        52  : limit = A;

        53  : limit = A;
        54  : limit = A;
        55  : limit = A;
        56  : limit = A;

        57  : limit = A;
        58  : limit = A;
        59  : limit = A;
        60  : limit = A;

        61  : limit = beat;
        62  : limit = beat;
        63  : limit = beat;
        64  : limit = beat;

        65  : limit = E;
        66  : limit = E;
        67  : limit = E;
        68  : limit = beat;

        69  : limit = E;
        70  : limit = E;
        71  : limit = E;
        72  : limit = beat;

        73  : limit = E;
        74  : limit = E;
        75  : limit = G;
        76  : limit = G;

        77  : limit = G;
        78  : limit = G;
        79  : limit = A;
        80  : limit = A;

        81  : limit = A;
        82  : limit = A;
        83  : limit = A;
        84  : limit = A;

        85  : limit = B;
        86  : limit = B;
        87  : limit = B;
        88  : limit = B;

        89  : limit = A;
        90  : limit = A;
        91  : limit = G;
        92  : limit = G;

        93  : limit = beat;
        94  : limit = beat;
        95  : limit = beat;
        96  : limit = beat;

        97  : limit = E;
        98  : limit = E;
        99  : limit = E;
        100 : limit = beat;

        101 : limit = E;
        102 : limit = E;
        103 : limit = E;
        104 : limit = E;

        105 : limit = D;
        106 : limit = D;
        107 : limit = DS;
        108 : limit = DS;

        109 : limit = DS;
        110 : limit = DS;
        111 : limit = E;
        112 : limit = E;
         
        113 : limit = E;
        114 : limit = E;
        115 : limit = E;
        116 : limit = E;
         
        117 : limit = E;
        118 : limit = E;
        119 : limit = E;
        120 : limit = E;
         
        121 : limit = E;
        122 : limit = E;
        123 : limit = E;
        124 : limit = E;
         
        125 : limit = beat;
        126 : limit = beat;
        127 : limit = beat;
        128 : limit = beat;
         
        129 : limit = B;
        130 : limit = beat;
        131 : limit = B;
        132 : limit = B;
         
        133 : limit = beat;
        134 : limit = beat;
        135 : limit = A;
        136 : limit = A;
         
        137 : limit = B;
        138 : limit = B;
        139 : limit = B;
        140 : limit = B;
         
        141 : limit = beat;
        142 : limit = beat;
        143 : limit = beat;
        144 : limit = beat;
         
        145 : limit = A;
        146 : limit = beat;
        147 : limit = A;
        148 : limit = A;
         
        149 : limit = beat;
        150 : limit = beat;
        151 : limit = G;
        152 : limit = G;
         
        153 : limit = B;
        154 : limit = beat;
        155 : limit = B;
        156 : limit = B;
         
        157 : limit = beat;
        158 : limit = beat;
        159 : limit = beat;
        160 : limit = beat;
         
        161 : limit = E;
        162 : limit = beat;
        163 : limit = E;
        164 : limit = E;
         
        165 : limit = beat;
        166 : limit = beat;
        167 : limit = D;
        168 : limit = D;
         
        169 : limit = LB;
        170 : limit = beat;
        171 : limit = LB;
        172 : limit = LB;
         
        173 : limit = G;
        174 : limit = G;
        175 : limit = G;
        176 : limit = G;
         
        177 : limit = E;
        178 : limit = E;
        179 : limit = E;
        180 : limit = E;
         
        181 : limit = E;
        182 : limit = E;
        183 : limit = E;
        184 : limit = E;
         
        185 : limit = E;
        186 : limit = E;
        187 : limit = E;
        188 : limit = E;
         
        189 : limit = beat;
        190 : limit = beat;
        191 : limit = beat;
        192 : limit = beat;
         
        193 : limit = E;
        194 : limit = beat;
        195 : limit = E;
        196 : limit = E;
         
        197 : limit = beat;
        198 : limit = beat;
        199 : limit = E;
        200 : limit = E;
         
        201 : limit = G;
        202 : limit = G;
        203 : limit = E;
        204 : limit = E;
         
        205 : limit = beat;
        206 : limit = beat;
        207 : limit = G;
        208 : limit = G;
         
        209 : limit = A;
        210 : limit = beat;
        211 : limit = A;
        212 : limit = A;
         
        213 : limit = beat;
        214 : limit = beat;
        215 : limit = G;
        216 : limit = G;
         
        217 : limit = B;
        218 : limit = beat;
        219 : limit = B;
        220 : limit = B;
         
        221 : limit = beat;
        222 : limit = beat;
        223 : limit = beat;
        224 : limit = beat;
         
        225 : limit = E;
        226 : limit = beat;
        227 : limit = E;
        228 : limit = E;
         
        229 : limit = beat;
        230 : limit = beat;
        231 : limit = D;
        232 : limit = D;
         
        233 : limit = LB;
        234 : limit = LB;
        235 : limit = LB;
        236 : limit = LB;
         
        237 : limit = G;
        238 : limit = G;
        239 : limit = G;
        240 : limit = G;
         
        241 : limit = E;
        242 : limit = E;
        243 : limit = E;
        244 : limit = E;
         
        245 : limit = E;
        246 : limit = E;
        247 : limit = E;
        248 : limit = E;
         
        249 : limit = E;
        250 : limit = E;
        251 : limit = E;
        252 : limit = E;
         
        253 : limit = beat;
        254 : limit = beat;
        255 : limit = beat;
        256 : limit = beat;
         
        257 : limit = E;
        258 : limit = beat;
        259 : limit = E;
        260 : limit = E;
         
        261 : limit = beat;
        262 : limit = beat;
        263 : limit = E;
        264 : limit = E;
         
        265 : limit = G;
        266 : limit = G;
        267 : limit = E;
        268 : limit = E;
         
        269 : limit = beat;
        270 : limit = beat;
        271 : limit = D;
        272 : limit = D;
         
        273 : limit = LB;
        274 : limit = LB;
        275 : limit = LB;
        276 : limit = LB;
         
        277 : limit = LB;
        278 : limit = LB;
        279 : limit = LB;
        280 : limit = LB;
         
        281 : limit = LB;
        282 : limit = LB;
        283 : limit = LB;
        284 : limit = LB;
         
        285 : limit = LB;
        286 : limit = LB;
        287 : limit = LB;
        288 : limit = LB;
         
        289 : limit = E;
        290 : limit = beat;
        291 : limit = E;
        292 : limit = E;
         
        293 : limit = beat;
        294 : limit = beat;
        295 : limit = E;
        296 : limit = E;
         
        297 : limit = G;
        298 : limit = G;
        299 : limit = E;
        300 : limit = E;
         
        301 : limit = beat;
        302 : limit = beat;
        303 : limit = G;
        304 : limit = G;
                       
        305 : limit = A;
        306 : limit = beat;
        307 : limit = A;
        308 : limit = A;
                       
        309 : limit = beat;
        310 : limit = beat;
        311 : limit = G;
        312 : limit = G;
                       
        313 : limit = B;
        314 : limit = beat;
        315 : limit = B;
        316 : limit = B;
                       
        317 : limit = B;
        318 : limit = B;
        319 : limit = beat;
        320 : limit = beat;

        321 : limit = E;
        322 : limit = beat;
        323 : limit = E;
        324 : limit = E;
        
        325 : limit = beat;
        326 : limit = beat;
        327 : limit = D;
        328 : limit = D;
        
        329 : limit = LB;
        330 : limit = LB;
        331 : limit = LB;
        332 : limit = LB;
        
        333 : limit = G;
        334 : limit = G;
        335 : limit = G;
        336 : limit = G;
        
        337 : limit = E;
        338 : limit = E;
        339 : limit = E;
        340 : limit = E;
        
        341 : limit = E;
        342 : limit = E;
        343 : limit = E;
        344 : limit = E;
        
        345 : limit = E;
        346 : limit = E;
        347 : limit = E;
        348 : limit = E;
        
        349 : limit = beat;
        350 : limit = beat;
        351 : limit = beat;
        352 : limit = beat;
        
        353 : limit = B;
        354 : limit = beat;
        355 : limit = B;
        356 : limit = B;
        
        357 : limit = beat;
        358 : limit = beat;
        359 : limit = A;
        360 : limit = A;
        
        361 : limit = B;
        362 : limit = B;
        363 : limit = B;
        364 : limit = B;
        
        365 : limit = beat;
        366 : limit = beat;
        367 : limit = beat;
        368 : limit = beat;
        
        369 : limit = A;
        370 : limit = beat;
        371 : limit = A;
        372 : limit = A;
        
        373 : limit = beat;
        374 : limit = beat;
        375 : limit = G;
        376 : limit = G;
        
        377 : limit = B;
        378 : limit = beat;
        379 : limit = B;
        380 : limit = B;
        
        381 : limit = beat;
        382 : limit = beat;
        383 : limit = beat;
        384 : limit = beat;
        
        385 : limit = E;
        386 : limit = beat;
        387 : limit = E;
        388 : limit = E;
        
        389 : limit = beat;
        390 : limit = beat;
        391 : limit = D;
        392 : limit = D;
        
        393 : limit = LB;
        394 : limit = beat;
        395 : limit = LB;
        396 : limit = LB;
        
        397 : limit = G;
        398 : limit = G;
        399 : limit = G;
        400 : limit = G;
        
        401 : limit = E;
        402 : limit = E;
        403 : limit = E;
        404 : limit = E;
        
        405 : limit = E;
        406 : limit = E;
        407 : limit = E;
        408 : limit = E;
        
        409 : limit = E;
        410 : limit = E;
        411 : limit = E;
        412 : limit = E;
        
        413 : limit = beat;
        414 : limit = beat;
        415 : limit = beat;
        416 : limit = beat;
        
        417 : limit = E;
        418 : limit = beat;
        419 : limit = E;
        420 : limit = E;
        
        421 : limit = beat;
        422 : limit = beat;
        423 : limit = E;
        424 : limit = E;
        
        425 : limit = G;
        426 : limit = G;
        427 : limit = E;
        428 : limit = E;
        
        429 : limit = beat;
        430 : limit = beat;
        431 : limit = G;
        432 : limit = G;
        
        433 : limit = A;
        434 : limit = beat;
        435 : limit = A;
        436 : limit = A;
        
        437 : limit = beat;
        438 : limit = beat;
        439 : limit = G;
        440 : limit = G;
        
        441 : limit = B;
        442 : limit = beat;
        443 : limit = B;
        444 : limit = B;
        
        445 : limit = beat;
        446 : limit = beat;
        447 : limit = beat;
        448 : limit = beat;
        
        449 : limit = E;
        450 : limit = beat;
        451 : limit = E;
        452 : limit = E;
        
        453 : limit = beat;
        454 : limit = beat;
        455 : limit = D;
        456 : limit = D;
        
        457 : limit = LB;
        458 : limit = LB;
        459 : limit = LB;
        460 : limit = LB;
        
        461 : limit = G;
        462 : limit = G;
        463 : limit = G;
        464 : limit = G;
        
        465 : limit = E;
        466 : limit = E;
        467 : limit = E;
        468 : limit = E;
        
        469 : limit = E;
        470 : limit = E;
        471 : limit = E;
        472 : limit = E;
        
        473 : limit = E;
        474 : limit = E;
        475 : limit = E;
        476 : limit = E;
        
        477 : limit = beat;
        478 : limit = beat;
        479 : limit = beat;
        480 : limit = beat;
        
        481 : limit = E;
        482 : limit = beat;
        483 : limit = E;
        484 : limit = E;
        
        485 : limit = beat;
        486 : limit = beat;
        487 : limit = E;
        488 : limit = E;
        
        489 : limit = G;
        490 : limit = G;
        491 : limit = E;
        492 : limit = E;
        
        493 : limit = beat;
        494 : limit = beat;
        495 : limit = D;
        496 : limit = D;
        
        497 : limit = LB;
        498 : limit = LB;
        499 : limit = LB;
        500 : limit = LB;
        
        501 : limit = LB;
        502 : limit = LB;
        503 : limit = LB;
        504 : limit = LB;
        
        505 : limit = LB;
        506 : limit = LB;
        507 : limit = LB;
        508 : limit = LB;
        
        509 : limit = LB;
        510 : limit = LB;
        511 : limit = LB;
        512 : limit = LB;
        
        513 : limit = E;
        514 : limit = beat;
        515 : limit = E;
        516 : limit = E;
        
        517 : limit = beat;
        518 : limit = beat;
        519 : limit = E;
        520 : limit = E;
        
        521 : limit = G;
        522 : limit = G;
        523 : limit = E;
        524 : limit = E;
        
        525 : limit = beat;
        526 : limit = beat;
        527 : limit = G;
        528 : limit = G;
        
        529 : limit = A;
        530 : limit = beat;
        531 : limit = A;
        532 : limit = A;
        
        533 : limit = beat;
        534 : limit = beat;
        535 : limit = G;
        536 : limit = G;
        
        537 : limit = B;
        538 : limit = beat;
        539 : limit = B;
        540 : limit = B;
        
        541 : limit = B;
        542 : limit = B;
        543 : limit = beat;
        544 : limit = beat;
        
        545 : limit = E;
        546 : limit = beat;
        547 : limit = E;
        548 : limit = E;
        
        549 : limit = beat;
        550 : limit = beat;
        551 : limit = D;
        552 : limit = D;
        
        553 : limit = LB;
        554 : limit = LB;
        555 : limit = LB;
        556 : limit = LB;
        
        557 : limit = G;
        558 : limit = G;
        559 : limit = G;
        560 : limit = G;
        
        561 : limit = E;
        562 : limit = E;
        563 : limit = E;
        564 : limit = E;
        
        565 : limit = E;
        566 : limit = E;
        567 : limit = E;
        568 : limit = E;
        
        569 : limit = E;
        570 : limit = E;
        571 : limit = E;
        572 : limit = E;
        
        573 : limit = beat;
        574 : limit = beat;
        575 : limit = beat;
        576 : limit = beat;

        default : limit = beat;
        endcase
    end
endmodule


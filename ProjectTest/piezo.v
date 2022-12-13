module Piezo(clk, nrst, tank1_life, tank2_life, piezo_out);
    input clk, nrst;
    input [1:0] tank1_life, tank2_life;
    output piezo_out;

    wire piezo1, piezo2;
    wire cong_en;

    assign cong_en = (!tank1_life[1] & !tank1_life[0]) | (!tank2_life[0] & !tank2_life[1]);
    assign peizo_out = piezo1 | piezo2;

    hit_feedback hitFeedback(clk, nrst, tank1_life, tank2_life, piezo1);
    congratulation cong(clk, nrst, cong_en, peizo2);
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
        reg_tank1_life <= 2'b11;
        reg_tank2_life <= 2'b11;
        en <= 1'b0;
        buff <= 1'b0;
        timePass <= 0;
        cnt <= 0;
        limit <= 500;
    end

    always@(posedge clk or negedge nrst) begin
        if(!nrst) begin
            reg_tank1_life <= 2'b11;
            reg_tank2_life <= 2'b11;
            en <= 1'b0;
            buff <= 1'b0;
            timePass <= 0;
            cnt <= 0;
            limit <= 500;
        end
        else begin
            if(reg_tank1_life != tank1_life || reg_tank2_life != tank2_life) begin
                reg_tank1_life <= tank1_life;
                reg_tank2_life <= tank2_life;
                en <= 1'b1;
            end
            if(en) begin
                if(cnt >= limit) begin
                    cnt <= 0;
                    buff <= !buff;
                    timePass <= timePass + 1;
                end
                else begin
                    cnt <= cnt + 1;
                    timePass <= timePass + 1;
                end
                if(timePass >= 200000) begin
                    cnt <= 0;
                    timePass <= 0;
                    buff <= 1'b0;
                    en <= 1'b0;
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

    integer E, F, G, A, B, C, D, E_h;

    initial begin
        buff <= 1'b0;
        cnt <= 0;
        beat <= 131072; // 1/8 second, 1/16 beat
        i <= 0;
        cn_sound = 0;
        limit = 131072;
        E  <=1591;
        F  <=1417;
        G  <=1262;
        A  <=1192;
        B  <=1062;
        C  <=946 ;
        D  <=893 ;
        E_h<=795 ;
    end

    always@(posedge clk or negedge nrst) begin
        if(!nrst) begin
            buff <= 1'b0;
            cnt <= 0;
            beat <= 131072; // 1/8 second, 1/16 beat
            i <= 0;
            cn_sound = 0;
            F  <=1417;
            G  <=1262;
            A  <=1192;
            B  <=1062;
            C  <=946 ;
            D  <=893 ;
            E_h<=795 ;
        end
        else if (en) begin
            if(cnt >= beat) begin
                cnt <= 0;
                cn_sound <= 0;
                i <= i + 1;
            end
            if(i >= 304) begin
                i <= 112; // infinite loop
            end
            if(cn_sound >= limit) begin
                cn_sound <= 0;
                buff <= !buff;
                cnt <= cnt + 1;
            end
            else begin
                cn_sound <= cn_sound + 1;
                cnt <= cnt + 1;
            end
        end
        else begin
            buff <= 1'b0;
            cnt <= 0;
            beat <= 131072; // 1/8 second, 1/16 beat
            i <= 0;
            cn_sound = 0;
        end
    end

    always@(i) begin
        case(i)
        0   : limit = beat; // break

        1   : limit = E_h;
        2   : limit = E_h;
        3   : limit = E_h; 
        4   : limit = beat;

        5   : limit = E_h;
        6   : limit = beat;
        7   : limit = E_h;
        8   : limit = E_h;

        9   : limit = E_h;
        10  : limit = beat;
        11  : limit = E_h;
        12  : limit = beat;

        13  : limit = E_h;
        14  : limit = E_h;
        15  : limit = E_h;
        16  : limit = beat;

        17   : limit = E_h;
        18   : limit = E_h;
        19   : limit = E_h; 
        20   : limit = beat;

        21   : limit = E_h;
        22   : limit = beat;
        23   : limit = E_h;
        24   : limit = beat;

        25   : limit = E_h;
        26  : limit = beat;
        27  : limit = E_h;
        28  : limit = beat;

        29  : limit = E_h;
        30  : limit = E_h;
        31  : limit = E_h;
        32  : limit = beat;

        33  : limit = E_h;
        34  : limit = E_h;
        35  : limit = E_h;
        36  : limit = beat;

        37  : limit = 4008;
        38  : limit = 4008;
        39  : limit = 4008;
        40  : limit = beat;

        41  : limit = 4008;
        42  : limit = 4008;
        43  : limit = 4008;
        44  : limit = beat;

        45  : limit = 4008;
        46  : limit = 4008;
        47  : limit = 4008;
        48  : limit = 4008;

        49  : limit = beat;
        50  : limit = beat;
        51  : limit = beat;
        52  : limit = beat;

        53  : limit = E;
        54  : limit = E;
        55  : limit = E;
        56  : limit = E;

        57  : limit = F;
        58  : limit = F;
        59  : limit = F;
        60  : limit = F;

        61  : limit = G;
        62  : limit = G;
        63  : limit = G;
        64  : limit = G;

        65  : limit = A;
        66  : limit = A;
        67  : limit = A;
        68  : limit = A;

        69  : limit = A;
        70  : limit = A;
        71  : limit = A;
        72  : limit = A;

        73  : limit = E;
        74  : limit = E;
        75  : limit = E;
        76  : limit = E;

        77  : limit = E;
        78  : limit = E;
        79  : limit = E;
        80  : limit = E;

        81  : limit = beat;
        82  : limit = beat;
        83  : limit = beat;
        84  : limit = beat;

        85  : limit = A;
        86  : limit = A;
        87  : limit = A;
        88  : limit = A;

        89  : limit = G;
        90  : limit = G;
        91  : limit = G;
        92  : limit = G;

        93  : limit = A;
        94  : limit = A;
        95  : limit = A;
        96  : limit = A;

        97  : limit = B;
        98  : limit = B;
        99  : limit = B;
        100 : limit = B;

        101 : limit = B;
        102 : limit = B;
        103 : limit = B;
        104 : limit = B;

        105 : limit = F;
        106 : limit = F;
        107 : limit = F;
        108 : limit = F;

        109 : limit = F;
        110 : limit = F;
        111 : limit = F;
        112 : limit = F;
         
        113 : limit = beat;
        114 : limit = beat;
        115 : limit = beat;
        116 : limit = beat;
         
        117 : limit = F;
        118 : limit = F;
        119 : limit = F;
        120 : limit = F;
         
        121 : limit = G;
        122 : limit = G;
        123 : limit = G;
        124 : limit = G;
         
        125 : limit = A;
        126 : limit = A;
        127 : limit = A;
        128 : limit = A;
         
        129 : limit = C;
        130 : limit = C;
        131 : limit = C;
        132 : limit = C;
         
        133 : limit = B;
        134 : limit = B;
        135 : limit = B;
        136 : limit = beat;
         
        137 : limit = B;
        138 : limit = B;
        139 : limit = B;
        140 : limit = B;
         
        141 : limit = A;
        142 : limit = A;
        143 : limit = A;
        144 : limit = beat;
         
        145 : limit = A;
        146 : limit = A;
        147 : limit = A;
        148 : limit = A;
         
        149 : limit = G;
        150 : limit = G;
        151 : limit = G;
        152 : limit = G;
         
        153 : limit = F;
        154 : limit = F;
        155 : limit = F;
        156 : limit = F;
         
        157 : limit = G;
        158 : limit = G;
        159 : limit = G;
        160 : limit = G;
         
        161 : limit = E;
        162 : limit = E;
        163 : limit = E;
        164 : limit = E;
         
        165 : limit = E;
        166 : limit = E;
        167 : limit = E;
        168 : limit = E;
         
        169 : limit = E;
        170 : limit = E;
        171 : limit = E;
        172 : limit = E;
         
        173 : limit = E;
        174 : limit = E;
        175 : limit = E;
        176 : limit = E;
         
        177 : limit = beat;
        178 : limit = beat;
        179 : limit = beat;
        180 : limit = beat;
         
        181 : limit = E;
        182 : limit = E;
        183 : limit = E;
        184 : limit = E;
         
        185 : limit = F;
        186 : limit = F;
        187 : limit = F;
        188 : limit = F;
         
        189 : limit = G;
        190 : limit = G;
        191 : limit = G;
        192 : limit = G;
         
        193 : limit = A;
        194 : limit = A;
        195 : limit = A;
        196 : limit = A;
         
        197 : limit = A;
        198 : limit = A;
        199 : limit = A;
        200 : limit = A;
         
        201 : limit = E;
        202 : limit = E;
        203 : limit = E;
        204 : limit = E;
         
        205 : limit = E;
        206 : limit = E;
        207 : limit = E;
        208 : limit = E;
         
        209 : limit = beat;
        210 : limit = beat;
        211 : limit = beat;
        212 : limit = beat;
         
        213 : limit = C;
        214 : limit = C;
        215 : limit = C;
        216 : limit = C;
         
        217 : limit = B;
        218 : limit = B;
        219 : limit = B;
        220 : limit = B;
         
        221 : limit = A;
        222 : limit = A;
        223 : limit = A;
        224 : limit = A;
         
        225 : limit = B;
        226 : limit = B;
        227 : limit = B;
        228 : limit = B;
         
        229 : limit = B;
        230 : limit = B;
        231 : limit = B;
        232 : limit = B;
         
        233 : limit = F;
        234 : limit = F;
        235 : limit = F;
        236 : limit = F;
         
        237 : limit = F;
        238 : limit = F;
        239 : limit = F;
        240 : limit = F;
         
        241 : limit = beat;
        242 : limit = beat;
        243 : limit = beat;
        244 : limit = beat;
         
        245 : limit = F;
        246 : limit = F;
        247 : limit = F;
        248 : limit = F;
         
        249 : limit = G;
        250 : limit = G;
        251 : limit = G;
        252 : limit = G;
         
        253 : limit = A;
        254 : limit = A;
        255 : limit = A;
        256 : limit = A;
         
        257 : limit = C;
        258 : limit = C;
        259 : limit = C;
        260 : limit = C;
         
        261 : limit = B;
        262 : limit = B;
        263 : limit = B;
        264 : limit = beat;
         
        265 : limit = B;
        266 : limit = B;
        267 : limit = B;
        268 : limit = B;
         
        269 : limit = A;
        270 : limit = A;
        271 : limit = A;
        272 : limit = beat;
         
        273 : limit = A;
        274 : limit = A;
        275 : limit = A;
        276 : limit = A;
         
        277 : limit = G;
        278 : limit = G;
        279 : limit = G;
        280 : limit = beat;
         
        281 : limit = F;
        282 : limit = F;
        283 : limit = F;
        284 : limit = F;
         
        285 : limit = G;
        286 : limit = G;
        287 : limit = G;
        288 : limit = beat;
         
        289 : limit = A;
        290 : limit = A;
        291 : limit = A;
        292 : limit = A;
         
        293 : limit = A;
        294 : limit = A;
        295 : limit = A;
        296 : limit = A;
         
        297 : limit = A;
        298 : limit = A;
        299 : limit = A;
        300 : limit = A;
         
        301 : limit = A;
        302 : limit = A;
        303 : limit = A;
        304 : limit = A;

        default : limit = beat;
        endcase
    end
endmodule

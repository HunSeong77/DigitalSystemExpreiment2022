module piano (clk, rst_x, keypad_in, out);
	input clk, rst_x;
	input [11:0] keypad_in;
	output out;
	wire [11:0] c1;
	wire val;
	
	//call keypad scan
	keypadscan ks(.clk(clk), .rst_x(rst_x), .in(keypad_in), 
		.out(c1), .valid(val));

	//call piezo tone
	piezo pp(.CLK(clk), .rst_x(rst_x), .valid(val), .M(c1), .PIEZO(out));
	
endmodule

module keypadscan(clk,rst_x,in,out,valid);
  input clk, rst_x;
  input [11:0]in;
  output reg [11:0]out;
  output reg valid;
  
always@(posedge clk or negedge rst_x) begin
	if(!rst_x) begin	// reset=0
		out <= 12'b000000000000;
		valid <= 0;
		end
	else if (in == 0) begin //finish input data
		valid <=0;
		out <= in; 
	end

	else begin //input data
	out <= in;
	valid <=1;
	end
end
		
endmodule

module piezo(CLK, rst_x, valid, M, PIEZO);
	
	input CLK, rst_x, valid;
	input[11:0] M;
	output wire PIEZO;
	integer CN_SOUND, LIMIT;
	reg BUFF;

	always@(M)begin
		case (M)
		12'b000000000001: LIMIT = ; //C {implement your code here}
		12'b000000000010: LIMIT = ; //D {implement your code here}
		12'b000000000100: LIMIT = ; //E {implement your code here}
		12'b000000001000: LIMIT = ; //F {implement your code here}
		12'b000000010000: LIMIT = ; //G {implement your code here}
		12'b000000100000: LIMIT = ; //A {implement your code here}
		12'b000001000000: LIMIT = ; //B {implement your code here}
		12'b000010000000: LIMIT = ; //C {implement your code here}
		default:LIMIT = 0; //no sound
		endcase
	end
	
	always@(posedge CLK or negedge rst_x)begin
	
		if(!rst_x) begin //reset=0
			BUFF <= 0;
			CN_SOUND <= 0;
		end
		
		else if(valid ==1) begin
			
			if(CN_SOUND >= LIMIT)begin
				CN_SOUND <= 0 ; //initial CN_SOUND
				BUFF <= ~BUFF; //change BUFF
			end
	
			else CN_SOUND <= CN_SOUND +1; //increase CN_SOUND
		end
	
		else begin //maintain data
			CN_SOUND <= CN_SOUND;
			BUFF <= BUFF;
		end
	end
		
	assign PIEZO = BUFF;
endmodule	
module Program_Counter(CLK, PL, JB, LAdders, RAddress, AData, PC);
input CLK, PL, JB, BC;
input [1:0] LAdders, RAddress;
input [3:0] AData;
output [3:9] PC;

reg [3:0] PC;

initial begin
    // implement your code here

    // to here
end

always@(posedge CLK) begin
    if(~PL)
        // implement your code here
    else if (JB)
        PC <= AData;
    else if (BC) begin
        if (AData < 4'b0000)
            PC <= PC + {LAdderss[1:0], RAdderss[1:0]};
        else
            // implement your code here
    end
    else if (~BC) begin
        if(AData == 4'b0000)
            PC <= PC + {LAddress[1:0], RAdderss[1:0]}
        else
            // implement your code here
    end
end
endmodule
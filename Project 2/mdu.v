`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:40:54 12/03/2017 
// Design Name: 
// Module Name:    mdu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mdu(
    input  [31:0] D1,
    input  [31:0] D2,
    input  HiLo,
    input  [1:0] Op,
    input  Start,
    input  WriteEnabled,	 
    output Busy,
	 input  madd,
    output   [31:0] HI,
    output   [31:0] LO,
    input clk,
    input rst,
	 input INT_REQ,
	 input [31:0] HI_M, LO_M
    );
	 
	 reg [63:0] temp1,temp2;
	 reg [63:0] temp;
	 
	 integer delay = 0;
	 
	 reg [31:0] MDu[1:0];
	 
	 initial begin 
		MDu[0]=0; 
		MDu[1]=0;
	 end
	 
	 assign Busy = (delay != 0 || Start);
	 always @(posedge clk) begin
		if(rst) begin
			MDu[0]=0; MDu[1]=0;
			delay=0;
			end
		else begin 
			if(INT_REQ) begin
				MDu[0] = HI_M;
				MDu[1] = LO_M;
				delay = 0;
			end
			else if(WriteEnabled) begin
				case(HiLo)
					1'b0 : MDu[0] = D1;
					1'b1 : MDu[1] = D1;
				endcase
				delay=1;
			end
			else if(Start)
				case (Op)
					2'b00 : 
					begin 
						{ MDu[0], MDu[1]} = D1*D2; delay=5; 
					end    //delay=5 
					2'b01 : 
					begin 
						{ MDu[0], MDu[1]} = $signed(D1)*$signed(D2);  
						delay=5; 
					end
					2'b10 : 
					begin  
						if(D2==0) begin
							
						end
						else begin
							MDu[0] = D1%D2;  
							MDu[1]= D1/D2; 
							delay=10;  
						end
					end //delay=10 
					2'b11 : 
					begin  
					if(D2==0) begin
							
					end
					else begin
						MDu[0] = $signed(D1)%$signed(D2); 
						MDu[1] = $signed(D1)/$signed(D2); 
						delay=10; 
					end
					end
				endcase   
				if(madd) begin 
					temp1= $signed(D1)*$signed(D2);
					temp2={MDu[0], MDu[1]};
					temp=temp1+temp2;
					MDu[0] =temp[63:32];
					MDu[1] =temp[31:0];
											
								/* {MDu[0],Mdu[1]}=$signed(D1)*$signed(D2)+{MDu[0], MDu[1]} */
											
					delay=5;
					end
				if(delay>0)
					delay = delay-1;						
				end
	 end
	 
	 assign HI=MDu[0];
	 assign LO=MDu[1];

endmodule

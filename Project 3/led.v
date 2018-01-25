`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:18 01/11/2018 
// Design Name: 
// Module Name:    led 
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
module led(
    input clk,
    input reset,
    input addr,
    output [15:0] digit0,
    output [15:0] digit1,
    output [3:0] digit2,
    input we,
	 input  [31:0] in,
    output [31:0] out
    );
	
	reg [31:0] Reg[1:0];
	
	assign out = (addr == 1'b0) ? Reg[0] :
											Reg[1] ;
	
	assign digit0 = Reg[0][15:0];
	
	assign digit1 = Reg[0][31:16];
	
	assign digit2 = Reg[1][3:0];
	
	always @(posedge clk) begin
		if(reset) begin
			Reg[0] <= 0;
			Reg[1] <= 0; 
		end
		else begin
			if(we) begin
				if(addr) begin
					Reg[1] <= in;
				end
				else begin
					Reg[0] <= in;
				end
			end
		end
	end
endmodule

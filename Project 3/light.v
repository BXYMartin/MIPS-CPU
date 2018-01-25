`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:01:15 01/15/2018 
// Design Name: 
// Module Name:    light 
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
module light(
    input clk,
    input reset,
	 input we,
	 input [31:0] in,
	 output [31:0] out,
    output [31:0] led_light
    );

	reg [31:0] ctrl;
	
	assign led_light = ctrl;
	
	assign out = ctrl;
	
	always @(posedge clk) begin
		if(reset)
			ctrl <= 0;
		else begin
			if(we)
				ctrl <= in;
		end
	end

endmodule

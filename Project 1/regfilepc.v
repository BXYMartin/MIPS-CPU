`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:18:48 12/05/2017 
// Design Name: 
// Module Name:    regfilepc 
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
module regfilepc #(parameter WIDTH = 8)(
	input clk,
	input reset,
	input stall,
	input [WIDTH-1:0] Data_In,
	output reg [WIDTH-1:0] Data_Out
    );
	
	initial begin
		Data_Out <=  32'h0000_3000;
	end
	
	always @ (posedge clk)
		if(reset) 
			Data_Out <=  32'h0000_3000;
		else if(stall==0) 
			Data_Out <=  Data_In;
endmodule

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
	output reg [WIDTH-1:0] Data_Out,
	output PC_EXP,
	input  INT_REQ
    );
	
	assign PC_EXP = ((Data_Out >= 32'h0000_3000) && (Data_Out <= 32'h0000_4fff) && Data_Out[1:0] == 2'b0) ? 1'b0 :
																																			  1'b1 ;
	/*
	initial begin
		Data_Out <=  32'h0000_3000;
	end
	*/
	always @(posedge clk) begin
		if(reset) begin
			Data_Out <=  32'h0000_3000;
		end	
		else if(stall == 0 || INT_REQ) begin
			Data_Out <=  Data_In;
		end
	end
endmodule

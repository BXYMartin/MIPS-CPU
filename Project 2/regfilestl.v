`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:15 12/05/2017 
// Design Name: 
// Module Name:    regfile 
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
module regfilestl #(parameter WIDTH = 8)(
	input clk,
	input reset,
	input stall,
	input clr,
	input [WIDTH-1:0] Data_In,
	output reg [WIDTH-1:0] Data_Out
    );
	 
	initial begin
		Data_Out <=  0;
	end

	always @ (posedge clk)
		if(reset)
			Data_Out <=  0;
		else if(clr)
			Data_Out <=  0;
		else if(stall==0) 
			Data_Out <=  Data_In;


endmodule

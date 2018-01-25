`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:21 12/03/2017 
// Design Name: 
// Module Name:    dm 
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
module dm(
	 input  [31:0] PC,
    input  [31:0] Addr,
	 input  [3:0]  Bit_Type,
    input  [31:0] WriteData,
	 output [31:0] ReadData,
    input  WriteEnabled,
    input  clk, reset
    );
	 
	integer i;
	wire [11:0] A;
   reg [31:0] DM[2047:0];
	assign A = Addr[12:2];
	wire [31:0] Write_Data;
	/*
	initial begin 
		for(i = 0 ; i < 4096 ; i = i + 1)
				DM[i] <= 0;
	end
	*/
	assign ReadData = DM[A];
	assign Write_Data = (Bit_Type == 4'b1111) ? WriteData :
							  (Bit_Type == 4'b0011) ? {DM[A][31:16], WriteData[15:0]} :
							  (Bit_Type == 4'b1100) ? {WriteData[15:0], DM[A][15:0]} :
							  (Bit_Type == 4'b0001) ? {DM[A][31:8], WriteData[7:0]} :
							  (Bit_Type == 4'b0010) ? {DM[A][31:16], WriteData[7:0], DM[A][7:0]} :
							  (Bit_Type == 4'b0100) ? {DM[A][31:24], WriteData[7:0], DM[A][15:0]} :
							  (Bit_Type == 4'b1000) ? {WriteData[7:0], DM[A][23:0]} :
															  32'b0							;
															  
	always @(posedge clk) begin
		if(reset)
			for(i = 0 ; i < 2048 ; i = i + 1)
				DM[i] <= 0;
	   else if(WriteEnabled) begin
				DM[A][31:0]  <= Write_Data;
				//$display("%d@%h: *%h <= %h", $time, PC, {18'b0, A, 2'b0}, WriteData);
		end
	end
	
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:44 12/03/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
	input			[31:0] A,
	input 		[31:0] B,
	input 		[3:0]  Op,
	output      [31:0] C,
	output   			 Overflow
    );
	
	
	wire [32:0] Temp1, Temp2;
	
	assign Temp1 = {A[31],A}+{B[31],B};
	assign Temp2 = {A[31],A}-{B[31],B};
	
	assign Overflow = (Op == 4'b1001) ? (Temp1[32] != Temp1[31]) :
							(Op == 4'b0100) ? (Temp2[32] != Temp2[31]) :
													1'b0;
	assign C = (Op == 4'b1001 || Op == 4'b0000) ? Temp1[31:0] :
				  (Op == 4'b1000 || Op == 4'b0100) ? Temp2[31:0] :
				  (Op == 4'b0101) ? (A | B) :
				  (Op == 4'b0110) ? {B[15:0], 16'b0} :
				  (Op == 4'b0011) ? (B << A[4:0]) :
				  (Op == 4'b0111) ? (B >> A[4:0]) :
				  (Op == 4'b1111) ? ($signed($signed(B)>>>A[4:0])) :
				  (Op == 4'b1101) ? (B << A[4:0]) :
				  (Op == 4'b1010) ? (B << A[4:0]) :
				  (Op == 4'b0001) ? (A & B) :
				  (Op == 4'b0010) ? (A ^ B) :
				  (Op == 4'b1110) ? (~( A | B )) :
										  32'b0			;


endmodule

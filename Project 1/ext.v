`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:25:59 12/03/2017 
// Design Name: 
// Module Name:    ext 
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
module ext(
	 input  EXT_Op,
    input  [15:0] a,
    output [31:0] b
    );
	 
	assign b = (EXT_Op == 0) ? {16'b0, a} 		 :	// Zero Extend
				  (EXT_Op == 1) ? {{16{a[15]}}, a}:	// Sign Extend
										32'bx				 ;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:09 12/06/2017 
// Design Name: 
// Module Name:    w 
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
`include "head.v"
module w(
	input  [31:0] PCadd4W,
	input  [31:0] ALU_OUT_W,
	input  [31:0] MEM_OUT_W,
	input  [1:0] MEM_TO_REG_W,
	output [31:0] RESULT_W
    );
	wire [31:0] PCadd8W;
	adder PCadd4_W (
    .PC(PCadd4W), 
    .Imm(32'b100), 
    .Result(PCadd8W)
    );
	 
	 // Writeback Data MUX
	 assign RESULT_W	=	(MEM_TO_REG_W == `ALU_OUT_W)	?	ALU_OUT_W	:
								(MEM_TO_REG_W == `MEM_OUT_W)	?	MEM_OUT_W	:
								(MEM_TO_REG_W == `PC_8_W)		?	PCadd8W		:
																			32'b0			;

endmodule

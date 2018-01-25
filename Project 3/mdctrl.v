`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:11 12/03/2017 
// Design Name: 
// Module Name:    mdctrl 
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
`define Op Op == 0
`define div Func == 6'b011010
`define divu Func == 6'b011011
`define mult Func == 6'b011000
`define multu Func == 6'b011001
`define mfhi Func == 6'b010000
`define mflo Func == 6'b010010
`define mthi Func == 6'b010001
`define mtlo Func == 6'b010011
module mdctrl(
    input   [31:0] Instr,
    output  Start,
    output  HiLo,
    output  WriteEnabled,
    output  [1:0] MDU_Op,
	 output  Add
    );
	 
	wire [31:0] Op;
	assign Op	= Instr[31:26];
	wire [5:0] Func;
	assign Func	= Instr[5:0];
	 
	wire [5:0] ctrl;
	assign {Start, HiLo, WriteEnabled, MDU_Op, Add}= ctrl;
	
	assign ctrl = (`Op && `div)  ? 6'b1_0_0_11_0 : 
					  (`Op && `divu) ? 6'b1_0_0_10_0 : 
					  (`Op && `mult) ? 6'b1_0_0_01_0 : 
					  (`Op && `multu)? 6'b1_0_0_00_0 : 
					  (`Op && `mfhi) ? 6'b0_0_0_00_0 : 
					  (`Op && `mflo) ? 6'b0_1_0_00_0 : 
					  (`Op && `mthi) ? 6'b0_0_1_00_0 : 
					  (`Op && `mtlo) ? 6'b0_1_1_00_0 : 
											 6'b0				;				  

endmodule

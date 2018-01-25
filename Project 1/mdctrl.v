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
	 
	reg [5:0] ctrl;
	assign {Start, HiLo, WriteEnabled, MDU_Op, Add}= ctrl;
	
	always @(*) begin
		if(Op == 0) 
			case (Func)
				6'b011010 : ctrl <= 6'b1_0_0_11_0;	// div
				6'b011011 : ctrl <= 6'b1_0_0_10_0;	// divu
				6'b011000 : ctrl <= 6'b1_0_0_01_0;	// mult
				6'b011001 : ctrl <= 6'b1_0_0_00_0;	// multu
				6'b010000 : ctrl <= 6'b0_0_0_00_0;	// mfhi
				6'b010010 : ctrl <= 6'b0_1_0_00_0;	// mflo
				6'b010001 : ctrl <= 6'b0_0_1_00_0;	// mthi
				6'b010011 : ctrl <= 6'b0_1_1_00_0;	// mtlo
				default: ctrl <= 6'bx;
			endcase
		else if(Op == 6'b011100 & Func == 000000)
			ctrl <= 6'b0_0_0_00_1;	// madd
	   else
			ctrl <= 6'bx;
	end
endmodule

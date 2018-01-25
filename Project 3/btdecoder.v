`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:01 12/03/2017 
// Design Name: 
// Module Name:    btdecoder 
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
`define sh Op == 6'b101001
`define sb Op == 6'b101000
`define sw Op == 6'b101011
`define ads (`W_MEM || (`sw && (`W_TIMER || `W_UART || `W_SWITCH || `W_LED || `W_DIG || `W_BUTTON)))
`define cos ((!`OP_HWORD && `sh) || (`sw && !`OP_WORD) || (Write_Enabled && !`ads))
module btdecoder(
    input [31:0] ALU_Out_M,
    input [31:0] Instr_M,
	 input Write_Enabled,
    output [3:0] Bit_Type,
	 output DM_EXP
    );
	 
	 wire [31:0] Op, Addr;
	 
	 assign Addr = ALU_Out_M;
	 
	 assign Op  = Instr_M[31:26];
	 
	 assign DM_EXP = (`cos) ? 1'b1 :
									 1'b0 ;
	 
	 assign Bit_Type = (`cos) 									? 4'b0000 :
							 (`sh && ALU_Out_M[1])				? 4'b1100 :
							 (`sh && !ALU_Out_M[1])				? 4'b0011 :
							 (`sb && ALU_Out_M[1:0] == 2'b00)? 4'b0001 :
							 (`sb && ALU_Out_M[1:0] == 2'b01)? 4'b0010 :
							 (`sb && ALU_Out_M[1:0] == 2'b10)? 4'b0100 :
							 (`sb && ALU_Out_M[1:0] == 2'b11)? 4'b1000 :
							 (`sw)									? 4'b1111 :
																		  4'b0000 ;
							 
endmodule

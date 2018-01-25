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
`define sh Op == 6'b101001
`define sb Op == 6'b101000
`define sw Op == 6'b101011
`define ad ((ALU_Out_M > 32'h0000_2fff && ALU_Out_M <32'h0000_7f00) || (ALU_Out_M > 32'h0000_7f07 && ALU_Out_M <32'h0000_7f10) || ALU_Out_M > 32'h0000_7f17 || (Op != 6'b101011 && ((ALU_Out_M <= 32'h0000_7f07 && ALU_Out_M >= 32'h0000_7f00) || (ALU_Out_M <= 32'h0000_7f17 && ALU_Out_M >= 32'h0000_7f10))) || ALU_Out_M < 32'h0)
`define co ((ALU_Out_M[0] && `sh) || (`sw && ALU_Out_M[1:0] != 2'b0))
module btdecoder(
    input [31:0] ALU_Out_M,
    input [31:0] Instr_M,
	 input Write_Enabled,
    output [3:0] Bit_Type,
	 output DM_EXP
    );
	 
	 wire [31:0] Op, Func;
	 
	 assign Op  = Instr_M[31:26];
	 
	 assign DM_EXP = (Write_Enabled && (`ad || `co)) ? 1'b1 :
																		1'b0 ;
	 
	 assign Bit_Type = (Write_Enabled && (`ad || `co)) ? 4'bx	 :
							 (`sh && ALU_Out_M[1])				? 4'b1100 :
							 (`sh && !ALU_Out_M[1])				? 4'b0011 :
							 (`sb && ALU_Out_M[1:0] == 2'b00)? 4'b0001 :
							 (`sb && ALU_Out_M[1:0] == 2'b01)? 4'b0010 :
							 (`sb && ALU_Out_M[1:0] == 2'b10)? 4'b0100 :
							 (`sb && ALU_Out_M[1:0] == 2'b11)? 4'b1000 :
							 (`sw)									? 4'b1111 :
																		  4'bx    ;
							 
endmodule

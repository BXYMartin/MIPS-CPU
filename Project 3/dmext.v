`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:20:52 12/03/2017 
// Design Name: 
// Module Name:    dmext 
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
`define lb (Op == 6'b100000 || Op == 6'b100100)
`define lh (Op == 6'b100001 || Op == 6'b100101)
`define lw (Op == 6'b100011)
`define un Op[28]
`define load (`lw || `lh || `lb)
`define ad (`R_MEM || (`lw && (`R_TIMER || `R_UART || `R_SWITCH || `R_LED || `R_DIG || `R_BUTTON)))
`define co (`lh && !`OP_HWORD) || (`lw && !`OP_WORD) || (`load && !`ad)
module dmext(
    input [31:0] DM_Out,
    input [31:26] Op,
    input [31:0] ALU_Out_M,
    output [31:0] DM_Out_M,
	 output LW_EXP
    );
	 
	 wire [31:0] Addr;
	 
	 assign Addr = ALU_Out_M;
	 
	 assign LW_EXP = (`co)	? 1'b1 :
									  1'b0 ;
	 
	 assign DM_Out_M = (`lb && `un && ALU_Out_M[1:0] == 2'b00)  ? {{24'b0},DM_Out[7:0]} :
							 (`lb && `un && ALU_Out_M[1:0] == 2'b01)  ? {{24'b0},DM_Out[15:8]}:
							 (`lb && `un && ALU_Out_M[1:0] == 2'b10)  ? {{24'b0},DM_Out[23:16]} :
							 (`lb && `un && ALU_Out_M[1:0] == 2'b11)  ? {{24'b0},DM_Out[31:24]} :
							 (`lb && !`un && ALU_Out_M[1:0] == 2'b00) ? {{24{DM_Out[7]}} ,DM_Out[7:0]} :
							 (`lb && !`un && ALU_Out_M[1:0] == 2'b01) ? {{24{DM_Out[15]}},DM_Out[15:8]} :
							 (`lb && !`un && ALU_Out_M[1:0] == 2'b10) ? {{24{DM_Out[23]}},DM_Out[23:16]} :
							 (`lb && !`un && ALU_Out_M[1:0] == 2'b11) ? {{24{DM_Out[31]}},DM_Out[31:24]} :
							 (`lh && `un && !ALU_Out_M[1]) 				? {16'b0,DM_Out[15:0]} :
							 (`lh && `un && ALU_Out_M[1]) 				? {16'b0,DM_Out[31:16]} :
							 (`lh && !`un && !ALU_Out_M[1]) 				? {{16{DM_Out[15]}},DM_Out[15:0]} :
							 (`lh && !`un && ALU_Out_M[1]) 				? {{16{DM_Out[31]}},DM_Out[31:16]} :
							 (`lw) 												? DM_Out :
																					  DM_Out ;
endmodule

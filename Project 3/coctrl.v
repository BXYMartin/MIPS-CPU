`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:49 12/26/2017 
// Design Name: 
// Module Name:    coctrl 
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
module coctrl(
    input  [31:0] Instr,
    input  [4:0] Exception,
	 input  [1:0] WT_PR,
	 input  [2:0] PC_SRC_M,
    output [6:2] Exception_Code,
    output Clear_Exception_Level,
    output CP0_Write_Enabled,
	 output Branch_Delay
    );
	 
	wire [5:0] Op, Func;
	wire [4:0] Mt;
	
	
	assign Branch_Delay = (PC_SRC_M == 3'b001 | PC_SRC_M == 3'b011 | PC_SRC_M == 3'b010 | PC_SRC_M == 3'b101) ? 1'b1 :
																																					1'b0 ;
	
	assign CP0_Write_Enabled = (Exception == 0 & WT_PR == 2'b01) ? 1'b1 :
																					   1'b0 ;
	assign Clear_Exception_Level = (WT_PR == 2'b11) ? 1'b1 :
																	  1'b0 ;
																	  
	assign Exception_Code = (Exception[0] == 1'b1) ? 5'd4  :
									(Exception[1] == 1'b1) ? 5'd10 :
									(Exception[2] == 1'b1) ? 5'd12 :
									(Exception[3] == 1'b1) ? 5'd5  :
									(Exception[4] == 1'b1) ? 5'd4  :
																	 5'd0  ;
endmodule

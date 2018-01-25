`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:53 12/06/2017 
// Design Name: 
// Module Name:    f_d 
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
module f_d(
	input  clk,
	input  reset,
	input  STALL_D,
	input  [31:0] PCadd4F,
	input  [31:0] INSTR_F,
	input  [31:0] PC,
	output [31:0] PCadd4D,
	output [31:0] INSTR_D,
	output [31:0] PC_D
    );

regfilestl #(32) R_FD_1 (.clk(clk), .reset(reset), .stall(STALL_D), .Data_In(PCadd4F), .Data_Out(PCadd4D));
regfilestl #(32) R_FD_2 (.clk(clk), .reset(reset), .stall(STALL_D), .Data_In(INSTR_F), .Data_Out(INSTR_D));
regfilestl #(32) R_FD_3 (.clk(clk), .reset(reset), .stall(STALL_D), .Data_In(PC), .Data_Out(PC_D));
endmodule

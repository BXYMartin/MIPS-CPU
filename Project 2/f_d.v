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
	input  clr,
	input  [4:0]  EXP_F,
	input  [31:0] PCadd4F,
	input  [31:0] INSTR_F,
	input  [31:0] PC,
	output [31:0] PCadd4D,
	output [31:0] INSTR_D,
	output [31:0] PC_D,
	output [4:0]  EXP_D
    );

regfilestl #(32) R_FD_1 (.clk(clk), .reset(reset), .clr(1'b0), .stall(STALL_D), .Data_In(PCadd4F), .Data_Out(PCadd4D));
regfilestl #(32) R_FD_2 (.clk(clk), .reset(reset), .clr(clr), .stall(STALL_D), .Data_In(INSTR_F), .Data_Out(INSTR_D));
regfilestl #(32) R_FD_3 (.clk(clk), .reset(reset), .clr(1'b0), .stall(STALL_D), .Data_In(PC), .Data_Out(PC_D));
regfilestl #(5)  R_FD_4 (.clk(clk), .reset(reset), .clr(clr), .stall(STALL_D), .Data_In(EXP_F), .Data_Out(EXP_D));
endmodule

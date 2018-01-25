`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:52:05 12/06/2017 
// Design Name: 
// Module Name:    e_m 
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
module e_m(
	input  clk,
	input  reset,
	input  clr,
	input  [4:0] EXP_E,
	input  [4:0] WRITE_ADDR_E,
	output [4:0] WRITE_ADDR_M,
	input  [31:0] INSTR_E,
	output [31:0] INSTR_M,
	input  [31:0] Real_ALU_OUT_E,
	output [31:0] ALU_OUT_M,
	input  [31:0] PCadd4E,
	output [31:0] PCadd4M,
	input  [31:0] FRead_Data_2_E,
	output [31:0] FRead_Data_2_M,
	input  [31:0] PC_E,
	input  [1:0]  RES_E,
	output [31:0] PC_M,
	input  MEM_WRITE_ENABLED_E,
	input  [1:0] MEM_TO_REG_E, 
	input  REG_WRITE_ENABLED_E,
	output MEM_WRITE_ENABLED_M,
	output [1:0] MEM_TO_REG_M, 
	output REG_WRITE_ENABLED_M,
	output [1:0] RES_M,
	output [4:0] EXP_M,
	input  [1:0] WT_PR_E,
	output [1:0] WT_PR_M,
	output [2:0] PC_SRC_M,
	input  [2:0] PC_SRC_E,
	input  [31:0] HI_E, LO_E,
	output [31:0] HI_M, LO_M
    );
regfile #(2)  R_EM_8 (.clk(clk), .reset(reset), .clr(clr), .Data_In(RES_E), .Data_Out(RES_M));
regfile #(5)  R_EM_1 (.clk(clk), .reset(reset), .clr(clr), .Data_In(WRITE_ADDR_E), .Data_Out(WRITE_ADDR_M));
regfile #(32) R_EM_2 (.clk(clk), .reset(reset), .clr(clr), .Data_In(INSTR_E), .Data_Out(INSTR_M));
regfile #(32) R_EM_3 (.clk(clk), .reset(reset), .clr(clr), .Data_In(Real_ALU_OUT_E), .Data_Out(ALU_OUT_M));
regfile #(32) R_EM_4 (.clk(clk), .reset(reset), .clr(1'b0), .Data_In(PCadd4E), .Data_Out(PCadd4M));
regfile #(32) R_EM_5 (.clk(clk), .reset(reset), .clr(clr), .Data_In(FRead_Data_2_E), .Data_Out(FRead_Data_2_M));
regfile #(4)  R_EM_6 (.clk(clk), .reset(reset), .clr(clr), .Data_In({MEM_WRITE_ENABLED_E, MEM_TO_REG_E, REG_WRITE_ENABLED_E}), .Data_Out({MEM_WRITE_ENABLED_M, MEM_TO_REG_M, REG_WRITE_ENABLED_M}));
regfile #(32) R_EM_7 (.clk(clk), .reset(reset), .clr(1'b0), .Data_In(PC_E), .Data_Out(PC_M));
regfile #(5)  R_EM_9 (.clk(clk), .reset(reset), .clr(clr), .Data_In(EXP_E), .Data_Out(EXP_M));
regfile #(2)  R_EM_10 (.clk(clk), .reset(reset), .clr(clr), .Data_In(WT_PR_E), .Data_Out(WT_PR_M));
regfile #(3)  R_EM_11 (.clk(clk), .reset(reset), .clr(clr), .Data_In(PC_SRC_E), .Data_Out(PC_SRC_M));
regfile #(32) R_EM_12 (.clk(clk), .reset(reset), .clr(clr), .Data_In(HI_E), .Data_Out(HI_M));
regfile #(32) R_EM_13 (.clk(clk), .reset(reset), .clr(clr), .Data_In(LO_E), .Data_Out(LO_M));
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:08 12/06/2017 
// Design Name: 
// Module Name:    m_w 
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
module m_w(
	input  clk,
	input  reset,
	input  [31:0] Real_MEM_OUT_M,
	output [31:0] MEM_OUT_W,
	input  [31:0] ALU_OUT_M,
	output [31:0] ALU_OUT_W,
	input  [31:0] PCadd4M,
	output [31:0] PCadd4W,
	input  [31:0] PC_M,
	output [31:0] PC_W,
	input  [1:0] RES_M,
	output [1:0] RES_W,
	input  [4:0] WRITE_ADDR_M,
	output [4:0] WRITE_ADDR_W,
	input  [1:0] MEM_TO_REG_M, 
	input  REG_WRITE_ENABLED_M,
	output [1:0] MEM_TO_REG_W, 
	output REG_WRITE_ENABLED_W,
	input  clr,
	input  [4:0] EXP_M,
	output [4:0] EXP_W,
	input  [31:0] INSTR_M,
	output [31:0] INSTR_W,
	input  [1:0] WT_PR_M,
	output [1:0] WT_PR_W,
	output [2:0] PC_SRC_W,
	input  [2:0] PC_SRC_M,
	input  CEL_M,
	output CEL_W
    );
regfile #(2)  R_MW_7 (.clk(clk), .reset(reset), .clr(clr), .Data_In(RES_M), .Data_Out(RES_W));
regfile #(5)  R_MW_1 (.clk(clk), .reset(reset), .clr(clr), .Data_In(WRITE_ADDR_M), .Data_Out(WRITE_ADDR_W));
regfile #(32) R_MW_2 (.clk(clk), .reset(reset), .clr(clr), .Data_In(Real_MEM_OUT_M), .Data_Out(MEM_OUT_W));
regfile #(32) R_MW_3 (.clk(clk), .reset(reset), .clr(clr), .Data_In(ALU_OUT_M), .Data_Out(ALU_OUT_W));
regfile #(32) R_MW_4 (.clk(clk), .reset(reset), .clr(1'b0), .Data_In(PCadd4M), .Data_Out(PCadd4W));
regfile #(3)  R_MW_5 (.clk(clk), .reset(reset), .clr(clr), .Data_In({MEM_TO_REG_M, REG_WRITE_ENABLED_M}), .Data_Out({MEM_TO_REG_W, REG_WRITE_ENABLED_W}));
regfile #(32) R_MW_6 (.clk(clk), .reset(reset), .clr(1'b0), .Data_In(PC_M), .Data_Out(PC_W));
regfile #(5)  R_MW_8 (.clk(clk), .reset(reset), .clr(clr), .Data_In(EXP_M), .Data_Out(EXP_W));
regfile #(32) R_MW_9 (.clk(clk), .reset(reset), .clr(clr), .Data_In(INSTR_M), .Data_Out(INSTR_W));
regfile #(2)  R_MW_10 (.clk(clk), .reset(reset), .clr(clr), .Data_In(WT_PR_M), .Data_Out(WT_PR_W));
regfile #(3)  R_MW_11 (.clk(clk), .reset(reset), .clr(clr), .Data_In(PC_SRC_M), .Data_Out(PC_SRC_W));
regfile #(1)  R_MW_12 (.clk(clk), .reset(reset), .clr(clr), .Data_In(CEL_M), .Data_Out(CEL_W));
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:18:25 12/06/2017 
// Design Name: 
// Module Name:    d_e 
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
module d_e(
	input  clk,
	input  clr,
	input  reset,
	input  FLUSH_E,
	input  [4:0]  WRITE_ADDR_D,
	input  [31:0] INSTR_D,
	input  [31:0] SHIFT_AMT_D,
	input  [31:0] IMM_EXT_D,
	input  [31:0] PCadd4D,
	input  [31:0] FRead_Data_1_D,
	input  [31:0] FRead_Data_2_D,
	input  [31:0] PC_D,
	input  SHIFT_SEL_D, 
	input  ALU_IMM_D, 
	input  [3:0]  ALU_OP_D, 
	input  MEM_WRITE_ENABLED_D, 
	input  [1:0]  MEM_TO_REG_D, 
	input  REG_WRITE_ENABLED_D,
	input  [4:0]  EXP_D,
	output [1:0]  RES_D,
	output [4:0]  WRITE_ADDR_E,
	output [31:0] INSTR_E,
	output [31:0] SHIFT_AMT_E,
	output [31:0] IMM_EXT_E,
	output [31:0] PCadd4E,
	output [31:0] Read_Data_1_E,
	output [31:0] Read_Data_2_E,
	output [31:0] PC_E,
	output  SHIFT_SEL_E, 
	output  ALU_IMM_E, 
	output  [3:0]  ALU_OP_E, 
	output  MEM_WRITE_ENABLED_E, 
	output  [1:0]  MEM_TO_REG_E, 
	output  REG_WRITE_ENABLED_E,
	output  [1:0]  RES_E,
	output  [4:0]  EXP_E,
	input   [1:0]  WT_PR,
	output  [1:0]  WT_PR_E,
	output [2:0] PC_SRC_E,
	input  [2:0] PC_SRC_D
    );

regfileclr #(5)  R_DE_1 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(WRITE_ADDR_D), .Data_Out(WRITE_ADDR_E));
regfileclr #(32) R_DE_2 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(INSTR_D), .Data_Out(INSTR_E));
regfileclr #(32) R_DE_3 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(SHIFT_AMT_D), .Data_Out(SHIFT_AMT_E));
regfileclr #(32) R_DE_4 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(IMM_EXT_D), .Data_Out(IMM_EXT_E));
regfileclr #(32) R_DE_5 (.clk(clk), .reset(reset), .clear(1'b0), .Data_In(PCadd4D), .Data_Out(PCadd4E));
regfileclr #(32) R_DE_6 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(FRead_Data_1_D), .Data_Out(Read_Data_1_E));
regfileclr #(32) R_DE_7 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(FRead_Data_2_D), .Data_Out(Read_Data_2_E));
regfileclr #(10) R_DE_8 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In({SHIFT_SEL_D, ALU_IMM_D, ALU_OP_D, MEM_WRITE_ENABLED_D, MEM_TO_REG_D, REG_WRITE_ENABLED_D}), .Data_Out({SHIFT_SEL_E, ALU_IMM_E, ALU_OP_E, MEM_WRITE_ENABLED_E, MEM_TO_REG_E, REG_WRITE_ENABLED_E}));
regfileclr #(32) R_DE_9 (.clk(clk), .reset(reset), .clear(1'b0), .Data_In(PC_D), .Data_Out(PC_E)); // Special
regfileclr #(2) R_DE_10 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(RES_D), .Data_Out(RES_E));
regfileclr #(5) R_DE_11 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(EXP_D), .Data_Out(EXP_E));
regfileclr #(2) R_DE_12 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(WT_PR), .Data_Out(WT_PR_E));
regfileclr #(3) R_DE_13 (.clk(clk), .reset(reset), .clear(FLUSH_E | clr), .Data_In(PC_SRC_D), .Data_Out(PC_SRC_E));
endmodule

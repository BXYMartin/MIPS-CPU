`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:30 12/06/2017 
// Design Name: 
// Module Name:    control 
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
module control(
	 input [31:0] INSTR_D,
	 input [31:0] INSTR_E,
	 input  [1:0] RES_W,
	 input  [1:0] RES_M,
	 input  [1:0] RES_E,
	 output [1:0] RES_D,
    output MEM_WRITE_ENABLED_D,
    output REG_WRITE_ENABLED_D,
    output [3:0] ALU_OP_D,
    output SHIFT_SEL_D,
	 output EXT_OP_D,
    output ALU_IMM_D,
    output [2:0] PC_SRC_D,
    output [1:0] MEM_TO_REG_D,
    output [1:0] REG_DST_D,
	 output [2:0] CMP_OP,
	 input [31:0] INSTR_M,
    input  Br,
	 input [4:0] WRITE_ADDR_E, WRITE_ADDR_M, WRITE_ADDR_W,
	 input REG_WRITE_ENABLED_E, REG_WRITE_ENABLED_M, REG_WRITE_ENABLED_W,
	 input [1:0] MEM_TO_REG_E, MEM_TO_REG_M,
	 output STALL_PC, STALL_D, FLUSH_E,
	 output [1:0] FORWRITE_ADDR_RD_1_D, FORWRITE_ADDR_RD_2_D,
	 output [1:0] FORWRITE_ADDR_RD_1_E, FORWRITE_ADDR_RD_2_E,
	 output FORWRITE_DATA_WD_M,
	 output OP_EXP,
	 input  INT_REQ,
	 output [1:0] WT_PR,
	 input  [1:0] WT_PR_E, WT_PR_M, WT_PR_W
    );
	 
	 
	 	// D_Controller
	ctrl CTRL_D (
    .Instr(INSTR_D), 
    .Branch(Br), 
    .Mem_Write(MEM_WRITE_ENABLED_D), 
    .Reg_Write(REG_WRITE_ENABLED_D), 
    .ALU_Op(ALU_OP_D), 
    .Shift(SHIFT_SEL_D), 
    .EXT_Op(EXT_OP_D), 
    .ALU_B_Sel(ALU_IMM_D), 
    .PC_Src(PC_SRC_D), 
    .Data_To_Reg(MEM_TO_REG_D), 
    .Reg_Dst(REG_DST_D),
	 .OP_EXP(OP_EXP),
	 .INT_REQ(INT_REQ),
	 .WT_PR(WT_PR)
    );
	 
	 // Branch Compare
	cmpdecoder CMP_CTRL (
    .Instr_D(INSTR_D), 
    .CMP_Op(CMP_OP)
    );
	 


	 // Hazard
	hazard HAZARD (
    .INSTR_D(INSTR_D), 
    .INSTR_E(INSTR_E), 
	 .INSTR_M(INSTR_M), 
    .WRITE_ADDR_E(WRITE_ADDR_E), 
    .WRITE_ADDR_M(WRITE_ADDR_M), 
    .WRITE_ADDR_W(WRITE_ADDR_W), 
    .REG_WRITE_ENABLED_E(REG_WRITE_ENABLED_E), 
    .REG_WRITE_ENABLED_M(REG_WRITE_ENABLED_M), 
    .REG_WRITE_ENABLED_W(REG_WRITE_ENABLED_W), 
    .MEM_TO_REG_E(MEM_TO_REG_E), 
    .MEM_TO_REG_M(MEM_TO_REG_M),  
    .STALL_PC(STALL_PC), 
    .STALL_D(STALL_D), 
    .FLUSH_E(FLUSH_E), 
	 .RES_W(RES_W),
	 .RES_E(RES_E),
	 .RES_M(RES_M),
	 .RES_D(RES_D),
    .FORWRITE_ADDR_RD_1_D(FORWRITE_ADDR_RD_1_D), 
    .FORWRITE_ADDR_RD_2_D(FORWRITE_ADDR_RD_2_D), 
    .FORWRITE_ADDR_RD_1_E(FORWRITE_ADDR_RD_1_E), 
    .FORWRITE_ADDR_RD_2_E(FORWRITE_ADDR_RD_2_E),
	 .FORWRITE_DATA_WD_M(FORWRITE_DATA_WD_M),
	 .WT_PR_E(WT_PR_E),
	 .WT_PR_M(WT_PR_M),
	 .WT_PR_W(WT_PR_W)
    );
	 
endmodule

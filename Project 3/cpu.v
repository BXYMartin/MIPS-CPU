`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:46:31 12/05/2017 
// Design Name: 
// Module Name:    mips 
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
module cpu(
	input clk,
	input reset,
	input  [31:0] DEVICE_OUT,
	output DEVICE_WE,
	output [31:0] DEVICE_ADDR, DEVICE_DATA,
	input  [5:0] HW_INT,
	input  clk_m
    );

	 wire MEM_WRITE_ENABLED_D;
    wire REG_WRITE_ENABLED_D;
    wire [3:0] ALU_OP_D;
    wire SHIFT_SEL_D;
	 wire EXT_OP_D;
    wire ALU_IMM_D;
    wire [2:0] PC_SRC_D;
    wire [1:0] MEM_TO_REG_D;
    wire [1:0] REG_DST_D;
	 wire [2:0] CMP_OP;
	 wire [31:0] INSTR_D;
	 wire [31:0] INSTR_E;
	 wire [31:0] INSTR_M;
    wire Br;
	 wire [4:0] WRITE_ADDR_E, WRITE_ADDR_M, WRITE_ADDR_W;
	 wire REG_WRITE_ENABLED_E, REG_WRITE_ENABLED_M, REG_WRITE_ENABLED_W;
	 wire [1:0] MEM_TO_REG_E, MEM_TO_REG_M;
	 wire STALL_PC, STALL_D, FLUSH_E;
	 wire [1:0] FORWRITE_ADDR_RD_1_D, FORWRITE_ADDR_RD_2_D;
	 wire [1:0] FORWRITE_ADDR_RD_1_E, FORWRITE_ADDR_RD_2_E;
	 wire [1:0] RES_D, RES_E, RES_M, RES_W;
	 wire FORWRITE_DATA_WD_M;
	 wire OP_EXP, INT_REQ;
	 wire [1:0] WT_PR, WT_PR_E, WT_PR_M, WT_PR_W;
	 
// Instantiate the module 
control CONTROLLER (
    .INSTR_D(INSTR_D), 
    .INSTR_E(INSTR_E), 
	 .INSTR_M(INSTR_M), 
    .Br(Br), 
    .MEM_WRITE_ENABLED_D(MEM_WRITE_ENABLED_D), 
    .REG_WRITE_ENABLED_D(REG_WRITE_ENABLED_D), 
    .ALU_OP_D(ALU_OP_D), 
    .SHIFT_SEL_D(SHIFT_SEL_D), 
    .EXT_OP_D(EXT_OP_D), 
    .ALU_IMM_D(ALU_IMM_D), 
    .PC_SRC_D(PC_SRC_D), 
    .MEM_TO_REG_D(MEM_TO_REG_D), 
    .REG_DST_D(REG_DST_D), 
    .CMP_OP(CMP_OP), 
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
	 .RES_D(RES_D),
	 .RES_W(RES_W),
	 .RES_E(RES_E),
	 .RES_M(RES_M),
    .FORWRITE_ADDR_RD_1_D(FORWRITE_ADDR_RD_1_D), 
    .FORWRITE_ADDR_RD_2_D(FORWRITE_ADDR_RD_2_D), 
    .FORWRITE_ADDR_RD_1_E(FORWRITE_ADDR_RD_1_E), 
    .FORWRITE_ADDR_RD_2_E(FORWRITE_ADDR_RD_2_E),
	 .FORWRITE_DATA_WD_M(FORWRITE_DATA_WD_M),
	 .OP_EXP(OP_EXP),
	 .INT_REQ(INT_REQ),
	 .WT_PR(WT_PR),
	 .WT_PR_E(WT_PR_E),
	 .WT_PR_M(WT_PR_M),
	 .WT_PR_W(WT_PR_W)
    );
		
// Instantiate the module
datapath DATAPATH (
    .clk(clk), 
	 .clk_m(clk_m),
    .reset(reset), 
    .MEM_WRITE_ENABLED_D(MEM_WRITE_ENABLED_D), 
    .REG_WRITE_ENABLED_D(REG_WRITE_ENABLED_D), 
    .ALU_OP_D(ALU_OP_D), 
    .SHIFT_SEL_D(SHIFT_SEL_D), 
    .EXT_OP_D(EXT_OP_D), 
    .ALU_IMM_D(ALU_IMM_D), 
    .PC_SRC_D(PC_SRC_D), 
    .MEM_TO_REG_D(MEM_TO_REG_D), 
    .REG_DST_D(REG_DST_D), 
    .CMP_OP(CMP_OP), 
    .INSTR_D(INSTR_D), 
    .INSTR_E(INSTR_E), 
	 .INSTR_M(INSTR_M), 
    .Br(Br), 
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
	 .OP_EXP(OP_EXP),
	 .INT_REQ(INT_REQ),
	 .WT_PR(WT_PR),
	 .WT_PR_E(WT_PR_E),
	 .WT_PR_M(WT_PR_M),
	 .WT_PR_W(WT_PR_W),
	 .HW_INT(HW_INT),
	 .DEVICE_OUT(DEVICE_OUT), 
	 .DEVICE_WE(DEVICE_WE),
	 .DEVICE_ADDR(DEVICE_ADDR), 
	 .DEVICE_DATA(DEVICE_DATA)
    );
//display				
	/*initial $monitor($time,," PC=%h NPC=%h INSTR_F=%h INSTR_D=%h INSTR_E=%h",
   	PC, NPC, INSTR_F, INSTR_D, INSTR_E);
	initial $monitor($time,," INSTR_E=%h REG_WRITE_ENABLED_E=%b ALU_IMM_D=%b ALU_IMM_E=%b 
	MEM_WRITE_ENABLED_E=%b IMM_EXT_E=%h ALU_A=%d ALU_B=%d",INSTR_E,REG_WRITE_ENABLED_E,ALU_IMM_D,ALU_IMM_E,MEM_WRITE_ENABLED_E,IMM_EXT_E,ALU_A,ALU_B);
	initial $monitor($time,,"INSTR_F=%h INSTR_D=%h INSTR_E=%h Read_Data_1_D=%d Read_Data_2_D=%d Read_Data_1_E=%d Read_Data_2_E=%d",
	INSTR_F,INSTR_D,INSTR_E, Read_Data_1_D, Read_Data_2_D, Read_Data_1_E, Read_Data_2_E);*/
	//initial $monitor($time,," %h ", INSTR_D);


endmodule

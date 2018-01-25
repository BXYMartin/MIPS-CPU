`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:25:04 12/08/2017 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
	 input [31:0] INSTR_D,
	 input [31:0] INSTR_E,
	 input [31:0] INSTR_M,
	 input [4:0] WRITE_ADDR_E, WRITE_ADDR_M, WRITE_ADDR_W,
	 input REG_WRITE_ENABLED_E, REG_WRITE_ENABLED_M, REG_WRITE_ENABLED_W,
	 input [1:0] MEM_TO_REG_E, MEM_TO_REG_M,
	 input [1:0] RES_W,
	 input [1:0] RES_M,
	 input [1:0] RES_E,
	 output [1:0] RES_D,
	 output STALL_PC, STALL_D, FLUSH_E,
	 output [1:0] FORWRITE_ADDR_RD_1_D, FORWRITE_ADDR_RD_2_D,
	 output [1:0] FORWRITE_ADDR_RD_1_E, FORWRITE_ADDR_RD_2_E,
	 output FORWRITE_DATA_WD_M,
	 input  [1:0] WT_PR_E, WT_PR_M, WT_PR_W
    );

	 // Hazard


	stall STALL (
    .Instr_D(INSTR_D), 
    .Write_Addr_E(WRITE_ADDR_E), 
    .Write_Addr_M(WRITE_ADDR_M), 
    .Write_Enabled_E(REG_WRITE_ENABLED_E), 
    .Write_Enabled_M(REG_WRITE_ENABLED_M), 
    .Data_To_Reg_E(MEM_TO_REG_E), 
    .Data_To_Reg_M(MEM_TO_REG_M), 
    .Stall_PC(STALL_PC), 
    .Stall_D(STALL_D), 
    .Flush_E(FLUSH_E),
	 .Res_M(RES_M),
	 .Res_W(RES_W),
	 .Res_E(RES_E),
	 .Res_D(RES_D),
	 .WT_PR_E(WT_PR_E),
	 .WT_PR_M(WT_PR_M),
	 .WT_PR_W(WT_PR_W)
    );
	
	forward FORWARD (
    .Instr_D(INSTR_D), 
    .Instr_E(INSTR_E), 
	 .Instr_M(INSTR_M),
    .Write_Addr_E(WRITE_ADDR_E), 
    .Write_Addr_M(WRITE_ADDR_M), 
    .Write_Addr_W(WRITE_ADDR_W), 
	 .Data_To_Reg_M(MEM_TO_REG_M), 
    .Write_Enabled_E(REG_WRITE_ENABLED_E), 
    .Write_Enabled_M(REG_WRITE_ENABLED_M), 
    .Write_Enabled_W(REG_WRITE_ENABLED_W), 
    .Forward_Data_1_D(FORWRITE_ADDR_RD_1_D), 
    .Forward_Data_2_D(FORWRITE_ADDR_RD_2_D), 
    .Forward_Data_1_E(FORWRITE_ADDR_RD_1_E), 
    .Forward_Data_2_E(FORWRITE_ADDR_RD_2_E),
	 .Forward_Data_M(FORWRITE_DATA_WD_M)
    );


endmodule

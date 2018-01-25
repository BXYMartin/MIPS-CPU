//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:10:59 12/07/2017 
// Design Name: 
// Module Name:    head 
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
// PC_SRC_D Data
`define PC_8	2'b00
`define PC_BEQ	2'b01
`define PC_JR	2'b10
`define PC_JAL	2'b11
// FRead_Data_x_D Data
`define REG_D_Data_D	2'b00
`define ALU_M_Data_D	2'b01
`define PC_M_Data_D	2'b10
// REG_DST_D Data
`define REG_WR_RT	2'b00
`define REG_WR_RD	2'b01
`define REG_WR_RA	2'b10
// FRead_Data_x_E Data
`define REG_E_Data_E	2'b00
`define ALU_M_Data_E	2'b01
`define DM_W_Data_E	2'b10
`define PC_M_Data_E	2'b11
// SHIFT_SEL_E Data
`define ALU_A_Data	1'b0
`define ALU_A_Shift	1'b1
// ALU_IMM_E Data
`define ALU_B_Data	1'b0
`define ALU_B_Imm		1'b1
// ALU_OP Data
`define ADDU	4'b0000
`define SUB 	4'b1000
`define AND		4'b0001
`define OR		4'b0101
`define XOR		4'b0010
`define ADD		4'b1001
`define ASL		4'b1101	// Arithmatic Shift Left
`define LSL		4'b1010	// Logical Shift Left
`define LSR		4'b0111	// Logical Shift Right
`define ASR		4'b1111	// Arithmatic Shift Right
// COMMS Data
`define SLTU	4'b1000
`define SLT		4'b0100
`define MFHI	4'b0010
`define MFLO	4'b0001
// MEM_TO_REG_W Data
`define ALU_OUT_W	2'b00
`define MEM_OUT_W	2'b01
`define PC_8_W	2'b10
// STALL New Data Source
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11
`define NW 2'b00
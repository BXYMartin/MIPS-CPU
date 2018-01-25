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
// WT_PR Data
`define RGPR_WGPR 2'b00
`define RGPR_WCP0 2'b01
`define RCP0_WGPR 2'b10
`define ERET		2'b11
// PC_SRC_D Data
`define PC_INT 3'b100
`define PC_RET 3'b101
`define PC_8	3'b000
`define PC_BEQ	3'b001
`define PC_JR	3'b010
`define PC_JAL	3'b011
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
`define PC_8_W		2'b10
`define CP0_OUT_W 2'b11
// STALL New Data Source
`define ALU 2'b01
`define DM 2'b10
`define PC 2'b11
`define NW 2'b00
// ADDRESS READ Data
`define R_MEM		(Addr <= 32'h0000_1fff && Addr >= 0)
`define R_INSTR	(Addr >= 32'h0000_3000 && Addr <= 32'h0000_4fff)
`define R_TIMER	(Addr >= 32'h0000_7f00 && Addr <= 32'h0000_7f0b)
`define R_UART		(Addr >= 32'h0000_7f10 && Addr <= 32'h0000_7f2b)
`define R_SWITCH	(Addr >= 32'h0000_7f2c && Addr <= 32'h0000_7f33)
`define R_LED		(Addr >= 32'h0000_7f34 && Addr <= 32'h0000_7f37)
`define R_DIG		(Addr >= 32'h0000_7f38 && Addr <= 32'h0000_7f3f)
`define R_BUTTON	(Addr >= 32'h0000_7f40 && Addr <= 32'h0000_7f43)
// ADDRESS WRITE Data
`define W_MEM 		(Addr <= 32'h0000_1fff)
`define W_INSTR	(Addr >= 32'h0000_3000 && Addr <= 32'h0000_4fff)
`define W_TIMER	(Addr >= 32'h0000_7f00 && Addr <= 32'h0000_7f07)
`define W_UART		(Addr >= 32'h0000_7f10 && Addr <= 32'h0000_7f2b)
`define W_SWITCH	(Addr >= 32'h0000_7f2c && Addr <= 32'h0000_7f33)
`define W_LED		(Addr >= 32'h0000_7f34 && Addr <= 32'h0000_7f37)
`define W_DIG		(Addr >= 32'h0000_7f38 && Addr <= 32'h0000_7f3f)
`define W_BUTTON	(Addr >= 32'h0000_7f40 && Addr <= 32'h0000_7f43)
// ADDRESS LEGITIMATE
`define OP_WORD	(!(|Addr[1:0]))
`define OP_HWORD	(!Addr[0])
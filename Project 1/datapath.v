`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:54 12/06/2017 
// Design Name: 
// Module Name:    datapath 
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
module datapath(
	 input clk,
	 input reset,
	 input MEM_WRITE_ENABLED_D,
    input REG_WRITE_ENABLED_D,
    input [3:0] ALU_OP_D,
    input SHIFT_SEL_D,
	 input EXT_OP_D,
    input ALU_IMM_D,
    input [1:0] PC_SRC_D,
    input [1:0] MEM_TO_REG_D,
    input [1:0] REG_DST_D,
	 input [2:0] CMP_OP,
    input  START,
    input  HiLo,
    input  WRITE_ENABLED,
    input  [1:0] MDU_OP,
	 input  madd,
	 output [31:0] INSTR_D,
	 output [31:0] INSTR_E,
	 output [31:0] INSTR_M,
    output Br,
	 output [4:0] WRITE_ADDR_E, WRITE_ADDR_M, WRITE_ADDR_W,
	 output REG_WRITE_ENABLED_E, REG_WRITE_ENABLED_M, REG_WRITE_ENABLED_W,
	 output [1:0] MEM_TO_REG_E, MEM_TO_REG_M,
	 output BUSY,
	 input  STALL_PC, STALL_D, FLUSH_E,
	 output [1:0] RES_W,
	 output [1:0] RES_M,
	 output [1:0] RES_E,
	 input  [1:0] RES_D,
	 input  [1:0] FORWRITE_ADDR_RD_1_D, FORWRITE_ADDR_RD_2_D,
	 input  [1:0] FORWRITE_ADDR_RD_1_E, FORWRITE_ADDR_RD_2_E,
	 input  FORWRITE_DATA_WD_M
    );
	 
	 wire [31:0]  NPC, PC;
	 wire [31:0]  PC_D, PC_E, PC_M, PC_W;
	 wire [31:0]  PCadd4F, PCadd4D, PCadd4E, PCadd4M, PCadd4W, PCadd8W, 
	              ALU_OUT_E, ALU_OUT_M, ALU_OUT_W, Real_ALU_OUT_E, RESULT_W;
	 wire [31:0]  Read_Data_1_D, Read_Data_2_D;
	 wire [31:0]  Read_Data_1_E, Read_Data_2_E, FRead_Data_2_M;
	 wire [31:0]  FRead_Data_1_E, FRead_Data_2_E;
	 wire [31:0]  FRead_Data_1_D, FRead_Data_2_D;
	 wire [31:0]  PC_BEQ_D;
	 wire [31:0]  INSTR_F;
	 wire [31:0]  SHIFT_AMT_D, SHIFT_AMT_E, IMM_EXT_D, IMM_EXT_E;
	 wire [31:0]  ALU_A, ALU_B;
	 wire [31:0]  MEM_OUT_M, Real_MEM_OUT_M, MEM_OUT_W;
	 wire [3:0]   BIT_TYPE;
	 wire [31:0]  HI, LO;
	 wire [4:0]   WRITE_ADDR_D;
	 wire [3:0]   ALU_OP_E;
	 wire [1:0]   MEM_TO_REG_W;
	 wire [31:0]  MEM_IN_M;
	 wire DISABLED, REG_WRITE_REAL_ENABLED_E;
	 
//F
// Instantiate the module
f F (
    .clk(clk), 
    .reset(reset), 
    .STALL_PC(STALL_PC), 
    .NPC(NPC), 
    .INSTR_F(INSTR_F), 
    .PCadd4F(PCadd4F),
	 .PC(PC)
    );
	
// F - D Registers
f_d F_D (
	 .clk(clk),
	 .reset(reset),
    .STALL_D(STALL_D), 
    .PCadd4F(PCadd4F), 
    .INSTR_F(INSTR_F), 
    .PC(PC), 
    .PCadd4D(PCadd4D), 
    .INSTR_D(INSTR_D), 
    .PC_D(PC_D)
    );
// Registers End

//D
 


	// GPR
	grf GPR (
	 .PC(PC_W),
    .Read_1(INSTR_D[25:21]), 
    .Read_2(INSTR_D[20:16]), 
    .Write_Dst(WRITE_ADDR_W), 
    .Read_Data_1(Read_Data_1_D), 
    .Read_Data_2(Read_Data_2_D), 
    .WriteData(RESULT_W), 
    .WriteEnabled(REG_WRITE_ENABLED_W), 
    .clk(clk), 
    .rst(reset)
    );
	 
	// MUX REG_DST
	assign WRITE_ADDR_D	=	(REG_DST_D == `REG_WR_RT) ? INSTR_D[20:16]	:
									(REG_DST_D == `REG_WR_RD) ? INSTR_D[15:11]	:
									(REG_DST_D == `REG_WR_RA) ? 5'b11111			:
																		 5'b0					;
	// MUX 

	// EXT_IMM
	ext EXT_IMM (
    .EXT_Op(EXT_OP_D), 
    .a(INSTR_D[15:0]), 
    .b(IMM_EXT_D)
    );
	 
	 // EXT_SHIFT_AMT
	ext EXT_SHIFT (
    .EXT_Op(1'b0), 
    .a({11'b0,INSTR_D[10:6]}), 
    .b(SHIFT_AMT_D)
    );
	 
	 // Forward MUXs
	 assign FRead_Data_1_D	=	(FORWRITE_ADDR_RD_1_D == `PC_M_Data_D)	   ?	PCadd4M + 4		:
										(FORWRITE_ADDR_RD_1_D == `REG_D_Data_D)	?	Read_Data_1_D	:
										(FORWRITE_ADDR_RD_1_D == `ALU_M_Data_D)	?	ALU_OUT_M		:
																									32'b0				;

	 assign FRead_Data_2_D	=	(FORWRITE_ADDR_RD_2_D == `PC_M_Data_D)	   ?	PCadd4M + 4		:
										(FORWRITE_ADDR_RD_2_D == `REG_D_Data_D)	?	Read_Data_2_D	:
										(FORWRITE_ADDR_RD_2_D == `ALU_M_Data_D)	?	ALU_OUT_M		:
																									32'b0				;

	cmp CMP (
    .A(FRead_Data_1_D), 
    .B(FRead_Data_2_D), 
    .Op(CMP_OP), 
    .Branch(Br)
    );
	 
	 // NPC Part
	adder PCadd4_D (
    .PC(PCadd4D), 
    .Imm({IMM_EXT_D[29:0],2'B00}), 
    .Result(PC_BEQ_D)
    );
	 
	 // NPC MUX
	 assign NPC	=	(PC_SRC_D == `PC_8)	?	PCadd4F											:
						(PC_SRC_D == `PC_BEQ)?	PC_BEQ_D											:
						(PC_SRC_D == `PC_JR)	?	FRead_Data_1_D									:
						(PC_SRC_D == `PC_JAL)?	{PCadd4D[31:28],INSTR_D[25:0],2'b00}	:
														32'b0												;



	
// D - E Registers
d_e D_E (
	 .clk(clk),
	 .reset(reset),
    .FLUSH_E(FLUSH_E), 
    .WRITE_ADDR_D(WRITE_ADDR_D), 
    .INSTR_D(INSTR_D), 
    .SHIFT_AMT_D(SHIFT_AMT_D), 
    .IMM_EXT_D(IMM_EXT_D), 
    .PCadd4D(PCadd4D), 
    .FRead_Data_1_D(FRead_Data_1_D), 
    .FRead_Data_2_D(FRead_Data_2_D), 
    .PC_D(PC_D), 
    .SHIFT_SEL_D(SHIFT_SEL_D), 
    .ALU_IMM_D(ALU_IMM_D), 
    .ALU_OP_D(ALU_OP_D), 
    .MEM_WRITE_ENABLED_D(MEM_WRITE_ENABLED_D), 
    .MEM_TO_REG_D(MEM_TO_REG_D), 
    .REG_WRITE_ENABLED_D(REG_WRITE_ENABLED_D), 
    .WRITE_ADDR_E(WRITE_ADDR_E), 
    .INSTR_E(INSTR_E), 
    .SHIFT_AMT_E(SHIFT_AMT_E), 
    .IMM_EXT_E(IMM_EXT_E), 
    .PCadd4E(PCadd4E), 
    .Read_Data_1_E(Read_Data_1_E), 
    .Read_Data_2_E(Read_Data_2_E), 
    .PC_E(PC_E), 
    .SHIFT_SEL_E(SHIFT_SEL_E), 
    .ALU_IMM_E(ALU_IMM_E), 
    .ALU_OP_E(ALU_OP_E), 
    .MEM_WRITE_ENABLED_E(MEM_WRITE_ENABLED_E), 
    .MEM_TO_REG_E(MEM_TO_REG_E), 
    .REG_WRITE_ENABLED_E(REG_WRITE_ENABLED_E),
	 .RES_D(RES_D),
	 .RES_E(RES_E)
    );
// Registers End
	 
	  
	 
//E
	
	// Forward MUXs
	assign FRead_Data_1_E	=	(FORWRITE_ADDR_RD_1_E == `REG_E_Data_E)	?	Read_Data_1_E	:
										(FORWRITE_ADDR_RD_1_E == `ALU_M_Data_E)	?	ALU_OUT_M		:
										(FORWRITE_ADDR_RD_1_E == `DM_W_Data_E)		?	RESULT_W			:
										(FORWRITE_ADDR_RD_1_E == `PC_M_Data_E)		?	PCadd4M + 4		:
																									32'b0				;
	
	assign FRead_Data_2_E	=	(FORWRITE_ADDR_RD_2_E == `REG_E_Data_E)	?	Read_Data_2_E	:
										(FORWRITE_ADDR_RD_2_E == `ALU_M_Data_E)	?	ALU_OUT_M		:
										(FORWRITE_ADDR_RD_2_E == `DM_W_Data_E)		?	RESULT_W			:
										(FORWRITE_ADDR_RD_2_E == `PC_M_Data_E)		?	PCadd4M + 4		:
																									32'b0				;
	
	assign ALU_A				=	(SHIFT_SEL_E == `ALU_A_Data)	?	FRead_Data_1_E	:
																					SHIFT_AMT_E				;
																	
	assign ALU_B				=	(ALU_IMM_E == `ALU_B_Data)	?	FRead_Data_2_E	:
																				IMM_EXT_E		;

	alu ALU (
    .A(ALU_A), 
    .B(ALU_B), 
    .Op(ALU_OP_E), 
    .C(ALU_OUT_E), 
    .Overflow(Over),
	 .Disable_Reg(DISABLED)
    );

	mdu MDU (
    .D1(FRead_Data_1_E), 
    .D2(FRead_Data_2_E), 
    .HiLo(HiLo), 
    .Op(MDU_OP), 
    .Start(START), 
    .WriteEnabled(WRITE_ENABLED), 
    .Busy(BUSY), 
    .madd(madd), 
    .HI(HI), 
    .LO(LO), 
    .clk(clk), 
    .rst(reset)
    );
	 
	// Select the REAL Output for E State
	comms ALU_OUT_SEL (
    .Instr_E(INSTR_E), 
    .A(ALU_A), 
    .B(ALU_B), 
    .ALU_Out(ALU_OUT_E), 
    .HI(HI), 
    .LO(LO), 
    .ALU_Out_E(Real_ALU_OUT_E)
    );
	
	// MOVZ Modified
	assign REG_WRITE_REAL_ENABLED_E = (DISABLED == 1'b0)	?	REG_WRITE_ENABLED_E	:
																				1'b1;

// E - M Registers
e_m E_M (
    .clk(clk), 
    .reset(reset), 
    .WRITE_ADDR_E(WRITE_ADDR_E), 
    .WRITE_ADDR_M(WRITE_ADDR_M), 
    .INSTR_E(INSTR_E), 
    .INSTR_M(INSTR_M), 
    .Real_ALU_OUT_E(Real_ALU_OUT_E), 
    .ALU_OUT_M(ALU_OUT_M), 
    .PCadd4E(PCadd4E), 
    .PCadd4M(PCadd4M), 
    .FRead_Data_2_E(FRead_Data_2_E), 
    .FRead_Data_2_M(FRead_Data_2_M), 
    .PC_E(PC_E), 
    .PC_M(PC_M), 
    .MEM_WRITE_ENABLED_E(MEM_WRITE_ENABLED_E), 
    .MEM_TO_REG_E(MEM_TO_REG_E), 
    .REG_WRITE_ENABLED_E(REG_WRITE_REAL_ENABLED_E), 
    .MEM_WRITE_ENABLED_M(MEM_WRITE_ENABLED_M), 
    .MEM_TO_REG_M(MEM_TO_REG_M), 
    .REG_WRITE_ENABLED_M(REG_WRITE_ENABLED_M),
	 .RES_E(RES_E),
	 .RES_M(RES_M)
    );
// Registers End

	 
//M

	// MUX For Input
	assign MEM_IN_M = (FORWRITE_DATA_WD_M == 1'b1) ? RESULT_W 		:
																	 FRead_Data_2_M;


m M (
    .clk(clk), 
    .reset(reset), 
    .MEM_WRITE_ENABLED_M(MEM_WRITE_ENABLED_M), 
    .ALU_OUT_M(ALU_OUT_M), 
    .INSTR_M(INSTR_M), 
    .PC_M(PC_M), 
    .FRead_Data_2_M(MEM_IN_M), 
    .Real_MEM_OUT_M(Real_MEM_OUT_M)
    );	

// M - W Registers
m_w M_W (
    .clk(clk), 
    .reset(reset), 
    .Real_MEM_OUT_M(Real_MEM_OUT_M), 
    .MEM_OUT_W(MEM_OUT_W), 
    .ALU_OUT_M(ALU_OUT_M), 
    .ALU_OUT_W(ALU_OUT_W), 
    .PCadd4M(PCadd4M), 
    .PCadd4W(PCadd4W), 
    .PC_M(PC_M), 
    .PC_W(PC_W), 
    .WRITE_ADDR_M(WRITE_ADDR_M), 
    .WRITE_ADDR_W(WRITE_ADDR_W), 
    .MEM_TO_REG_M(MEM_TO_REG_M), 
    .REG_WRITE_ENABLED_M(REG_WRITE_ENABLED_M), 
    .MEM_TO_REG_W(MEM_TO_REG_W), 
    .REG_WRITE_ENABLED_W(REG_WRITE_ENABLED_W),
	 .RES_M(RES_M),
	 .RES_W(RES_W)
    );
// Registers End

	
//W 
w W (
    .PCadd4W(PCadd4W), 
    .ALU_OUT_W(ALU_OUT_W), 
    .MEM_OUT_W(MEM_OUT_W), 
    .MEM_TO_REG_W(MEM_TO_REG_W), 
    .RESULT_W(RESULT_W)
    );



endmodule

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
    input [2:0] PC_SRC_D,
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
	 input  FORWRITE_DATA_WD_M,
	 input  OP_EXP,
	 output INT_REQ,
	 input  [1:0] WT_PR,
	 output [1:0] WT_PR_E, WT_PR_M, WT_PR_W,
	 input  [5:0] HW_INT,
	 input  [31:0] DEVICE_OUT,
	 output DEVICE_WE,
	 output [31:0] DEVICE_ADDR, DEVICE_DATA
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
	 wire [31:0]  INSTR_F, INSTR_W, Real_INSTR_F;
	 wire [31:0]  SHIFT_AMT_D, SHIFT_AMT_E, IMM_EXT_D, IMM_EXT_E;
	 wire [31:0]  ALU_A, ALU_B;
	 wire [31:0]  MEM_OUT_M, Real_MEM_OUT_M, MEM_OUT_W;
	 wire [3:0]   BIT_TYPE;
	 wire [31:0]  HI, LO;
	 wire [4:0]   WRITE_ADDR_D;
	 wire [3:0]   ALU_OP_E;
	 wire [1:0]   MEM_TO_REG_W;
	 wire [31:0]  MEM_IN_M, EPC;
	 wire DISABLED, REG_WRITE_REAL_ENABLED_E;
	 wire [4:0]   EXP_F, EXP_D, EXP_E, EXP_M, EXP_W;
	 wire [4:0]   EXP_Di, EXP_Ei, EXP_Mi;
	 wire clr, PC_EXP, OV_EXP, DM_EXP, LW_EXP;
	 wire [6:2]   EXP_CODE;
	 wire CEL_M, CEL_W, COP0_WE;
	 wire [31:0] COP0_OUT_M, Real_M_OUT;
	 wire [31:0] MEM_OUT;
	 wire BD;
	 wire [2:0] PC_SRC_E, PC_SRC_M, PC_SRC_W;
	 wire [31:0] HI_M, LO_M;
//F
// Instantiate the module
f F (
    .clk(clk), 
    .reset(reset), 
    .STALL_PC(STALL_PC), 
    .NPC(NPC), 
    .INSTR_F(INSTR_F), 
    .PCadd4F(PCadd4F),
	 .PC(PC),
	 .PC_EXP(PC_EXP),
	 .INT_REQ(INT_REQ)
    );
	assign EXP_F = {4'b0, PC_EXP};
	assign Real_INSTR_F = (PC_EXP == 1'b0) ? INSTR_F :
														  32'b0   ;
// F - D Registers
f_d F_D (
	 .clk(clk),
	 .reset(reset),
	 .clr(INT_REQ), //  || (PC_SRC_D == `PC_RET && !STALL_D)
    .STALL_D(STALL_D), 
    .PCadd4F(PCadd4F), 
    .INSTR_F(Real_INSTR_F), 
    .PC(PC), 
    .PCadd4D(PCadd4D), 
    .INSTR_D(INSTR_D), 
    .PC_D(PC_D),
	 .EXP_F(EXP_F),
	 .EXP_D(EXP_D)
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
	 assign NPC	=	(PC_SRC_D == `PC_RET)?	EPC												:
						(PC_SRC_D == `PC_INT)?	32'h0000_4180									:
						(PC_SRC_D == `PC_8)	?	PCadd4F											:
						(PC_SRC_D == `PC_BEQ)?	PC_BEQ_D											:
						(PC_SRC_D == `PC_JR)	?	FRead_Data_1_D									:
						(PC_SRC_D == `PC_JAL)?	{PCadd4D[31:28],INSTR_D[25:0],2'b00}	:
														32'b0												;

	assign EXP_Di = {3'b0, OP_EXP, EXP_D[0]};

	
// D - E Registers
d_e D_E (
	 .clk(clk),
	 .reset(reset),
	 .clr(INT_REQ),
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
	 .RES_E(RES_E),
	 .EXP_D(EXP_Di),
	 .EXP_E(EXP_E),
	 .WT_PR(WT_PR),
	 .WT_PR_E(WT_PR_E),
	 .PC_SRC_D(PC_SRC_D),
	 .PC_SRC_E(PC_SRC_E)
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
																					SHIFT_AMT_E		;
																	
	assign ALU_B				=	(ALU_IMM_E == `ALU_B_Data)	?	FRead_Data_2_E	:
																				IMM_EXT_E		;
	
	alu ALU (
    .A(ALU_A), 
    .B(ALU_B), 
    .Op(ALU_OP_E), 
    .C(ALU_OUT_E), 
    .Overflow(OV_EXP)
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
    .rst(reset),
	 .INT_REQ(INT_REQ),
	 .HI_M(HI_M),
	 .LO_M(LO_M)
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
	

	
	assign EXP_Ei = {2'b0, OV_EXP, EXP_E[1:0]};
	
// E - M Registers
e_m E_M (
    .clk(clk), 
    .reset(reset), 
	 .clr(INT_REQ),
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
    .REG_WRITE_ENABLED_E(REG_WRITE_ENABLED_E), 
    .MEM_WRITE_ENABLED_M(MEM_WRITE_ENABLED_M), 
    .MEM_TO_REG_M(MEM_TO_REG_M), 
    .REG_WRITE_ENABLED_M(REG_WRITE_ENABLED_M),
	 .RES_E(RES_E),
	 .RES_M(RES_M),
	 .EXP_E(EXP_Ei),
	 .EXP_M(EXP_M),
	 .WT_PR_E(WT_PR_E),
	 .WT_PR_M(WT_PR_M),
	 .PC_SRC_M(PC_SRC_M),
	 .PC_SRC_E(PC_SRC_E),
	 .HI_E(HI),
	 .LO_E(LO),
	 .HI_M(HI_M),
	 .LO_M(LO_M)
    );
// Registers End

	 
//M

	// MUX For Input
	assign MEM_IN_M = (FORWRITE_DATA_WD_M == 1'b1) ? RESULT_W 		:
																	 FRead_Data_2_M;


	btdecoder BT_Decoder (
    .ALU_Out_M(ALU_OUT_M), 
	 .Write_Enabled(MEM_WRITE_ENABLED_M),
    .Instr_M(INSTR_M), 
    .Bit_Type(BIT_TYPE),
	 .DM_EXP(DM_EXP)
    );
	 
   assign MEM_WE = (ALU_OUT_M[14] == 0 && !INT_REQ) ? MEM_WRITE_ENABLED_M :
																		1'b0					  ;
																						  
	
	assign DEVICE_WE		= (!INT_REQ) ? MEM_WRITE_ENABLED_M :
												  1'b0					 ;
	assign DEVICE_ADDR	= ALU_OUT_M;
	assign DEVICE_DATA	= MEM_IN_M;
	
	dm DM (
	 .PC(PC_M),
    .Addr(ALU_OUT_M), 
    .Bit_Type(BIT_TYPE), 
    .WriteData(MEM_IN_M), 
    .ReadData(MEM_OUT), 
    .WriteEnabled(MEM_WE), 
    .clk(clk),
	 .reset(reset)
	 );
	 
	 
	 
	assign MEM_OUT_M = (ALU_OUT_M[14] == 0) ? MEM_OUT 	  :
							 (ALU_OUT_M[14] == 1) ? DEVICE_OUT :
															32'b0		  ;

	
	dmext DM_EXT (
    .DM_Out(MEM_OUT_M), 
    .Op(INSTR_M[31:26]), 
    .ALU_Out_M(ALU_OUT_M), 
    .DM_Out_M(Real_MEM_OUT_M),
	 .LW_EXP(LW_EXP)
    );
	 
	
	assign EXP_Mi = {LW_EXP, DM_EXP, EXP_M[2:0]};
	
	
	// COP0 Controller
	coctrl COP0_CTRL (
    .Instr(INSTR_M), 
    .Exception(EXP_Mi), 
	 .WT_PR(WT_PR_M),
	 .PC_SRC_M(PC_SRC_W),
    .Exception_Code(EXP_CODE), 
    .Clear_Exception_Level(CEL_M), 
	 .CP0_Write_Enabled(COP0_WE),
	 .Branch_Delay(BD)
    );
	
	// COP0
	coprocessor COP0 (
    .Op_Reg(INSTR_M[15:11]),  
    .Data_In(MEM_IN_M), 
    .PC(PC_M), 
	 .Branch_Delay(BD),
    .Exception_Code(EXP_CODE), 
    .Hardware_Interruption(HW_INT), 
    .Write_Enabled(COP0_WE), 
    .Clear_Exception_Level(CEL_W), 
    .clk(clk), 
    .rst(reset), 
    .Ex_Request(INT_REQ), 
    .E_PC(EPC), 
    .Data_Out(COP0_OUT_M)
    );
	 
	 assign Real_M_OUT = (WT_PR_M == 2'b10) ? COP0_OUT_M		:
															Real_MEM_OUT_M	;
	
// M - W Registers
m_w M_W (
    .clk(clk), 
    .reset(reset), 
	 .clr(INT_REQ),
    .Real_MEM_OUT_M(Real_M_OUT), 
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
	 .RES_W(RES_W),
	 .EXP_M(EXP_Mi),
	 .EXP_W(EXP_W),
	 .INSTR_M(INSTR_M),
	 .INSTR_W(INSTR_W),
	 .WT_PR_M(WT_PR_M),
	 .WT_PR_W(WT_PR_W),
	 .PC_SRC_M(PC_SRC_M),
	 .PC_SRC_W(PC_SRC_W),
	 .CEL_M(CEL_M),
	 .CEL_W(CEL_W)
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

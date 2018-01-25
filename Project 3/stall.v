`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:18 12/04/2017 
// Design Name: 
// Module Name:    stall 
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
module stall(
	input [31:0] Instr_D,
	input [4:0] Write_Addr_E, Write_Addr_M,
	input Write_Enabled_E, Write_Enabled_M,
	input [1:0] Data_To_Reg_E, Data_To_Reg_M,
	output Stall_PC, Stall_D, Flush_E,
	input	 [1:0] Res_W,
	input	 [1:0] Res_M,
	input  [1:0] Res_E,
	output reg [1:0] Res_D,
	input  [1:0] WT_PR_E, WT_PR_M, WT_PR_W
    );

///////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// Stall GPR //////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
		wire [4:0] Field_rs_D, Field_rt_D;
		wire Tuse_RS0, Tuse_RS1, Tuse_RT0, Tuse_RT1;//, Tuse_RT2;
		wire Stall_RS0_E1, Stall_RS0_E2, Stall_RS0_M1, Stall_RS1_E2;
		wire Stall_RT0_E1, Stall_RT0_E2, Stall_RT0_M1, Stall_RT1_E2;
		wire Stall_RS, Stall_RT;
		wire Stall_ERET;
		assign Field_rs_D = Instr_D[25:21];
		assign Field_rt_D = Instr_D[20:16];
		
		wire [5:0] Op_D, Func_D, Id_D;
		wire [4:0] Mt_D;

		assign Op_D 	= 	Instr_D[31:26];
		assign Func_D 	= 	Instr_D[5:0];
		assign Id_D		=	Instr_D[20:16];
		assign Mt_D		=	Instr_D[25:21];
		
		wire branch, beq, cal_r, cal_i, load, store, jr, jalr, branchal, cal_x, load_m, store_m, eret;
		assign branchal=	(Op_D == 6'b000001 & Id_D == 5'b10001) | 
								(Op_D == 6'b000001 & Id_D == 5'b10000);				// bgezal bltzal
		assign branch	=	(Op_D == 6'b000111) | (Op_D == 6'b000001 & Id_D == 5'b00001) | 
								(Op_D == 6'b000001 & Id_D == 5'b00000) | (Op_D == 6'b000110);	// bgez bltz bgtz blez
		assign beq		=	(Op_D == 6'b000100) | (Op_D == 6'b000101);			// beq bne
		assign cal_r	=	((Op_D == 6'b000000) & (Func_D == 6'b100000)) |		// add
								((Op_D == 6'b000000) & (Func_D == 6'b100001)) |		// addu
								((Op_D == 6'b000000) & (Func_D == 6'b100010)) |		// sub
								((Op_D == 6'b000000) & (Func_D == 6'b100100)) |		// and
								((Op_D == 6'b000000) & (Func_D == 6'b100101)) |		// or
								((Op_D == 6'b000000) & (Func_D == 6'b100110)) |		// xor
								((Op_D == 6'b000000) & (Func_D == 6'b100111)) |		// nor
								((Op_D == 6'b000000) & (Func_D == 6'b000000)) |		// sll
								((Op_D == 6'b000000) & (Func_D == 6'b000010)) |		// srl
								((Op_D == 6'b000000) & (Func_D == 6'b000011)) |		// sra
								((Op_D == 6'b000000) & (Func_D == 6'b000100)) |		// sllv
								((Op_D == 6'b000000) & (Func_D == 6'b000110)) |		// srlv
								((Op_D == 6'b000000) & (Func_D == 6'b000111)) |		// srav
								((Op_D == 6'b000000) & (Func_D == 6'b101010)) |		// slt
								((Op_D == 6'b000000) & (Func_D == 6'b101011)) |		// sltu
								((Op_D == 6'b000000) & (Func_D == 6'b100011)) |		// subu
								((Op_D == 6'b000000) & (Func_D == 6'b001010)) |		// movz	
								((Op_D == 6'b000000) & (Func_D == 6'b000010));		// rotr	
		assign cal_i	=	(Op_D == 6'b001101) | (Op_D == 6'b001111) | 			// lui  ori
								(Op_D == 6'b001000) | (Op_D == 6'b001001) |			// addi addiu
								(Op_D == 6'b001100) | (Op_D == 6'b001110) | 			// andi xori
								(Op_D == 6'b001010) | (Op_D == 6'b001011);			// slti sltiu
		assign load		=	(Op_D == 6'b100011) | (Op_D == 6'b100000) | (Op_D == 6'b100001) |	// lw lh lb
								(Op_D == 6'b100101) | (Op_D == 6'b100100) | (Op_D == 6'b010000 & Mt_D == 5'b00000);								// lhu lbu mfc0
		assign store	=	(Op_D == 6'b101011) | (Op_D == 6'b101001) | (Op_D == 6'b101000) | (Op_D == 6'b010000 & Mt_D == 5'b00100);	// sw sh sb mtc0
		assign jr		=	((Op_D == 6'b000000) & (Func_D == 6'b001000));		// jr
		assign jalr		=	((Op_D == 6'b000000) & (Func_D == 6'b001001));		// jalr	
		assign cal_x	=	((Op_D == 6'b000000)&(
								(Func_D == 6'b011010)| (Func_D == 6'b011011)|	   // div divu
								(Func_D == 6'b011000)| (Func_D == 6'b011001)));    // mult multu
		assign load_m	=	((Op_D == 6'b000000)&(
								(Func_D == 6'b010010)| (Func_D == 6'b010000)));    // mflo mfhi
		assign store_m	=	((Op_D == 6'b000000)&(
								(Func_D == 6'b010001)| (Func_D == 6'b010011)));  	// mthi mtlo
		assign eret		=	(Op_D == 6'b010000 & Mt_D == 5'b10000);				// eret
		
		wire [6:0] ID = {cal_r, cal_i, load, jr, jalr, branchal, load_m};
		assign Tuse_RS0=	branch + beq + jr + jalr + branchal;
		assign Tuse_RS1=	cal_r + cal_i + load + store + store_m + cal_x;
		
		assign Tuse_RT0=	beq;
		assign Tuse_RT1=	cal_r + cal_x;
		
		always @* begin
			case(ID)
				7'b1000000: Res_D <= `ALU;
				7'b0100000: Res_D <= `ALU;
				7'b0010000: Res_D <= `DM;
				7'b0001000: Res_D <= `PC;
				7'b0000100: Res_D <= `PC;
				7'b0000010: Res_D <= `PC;
				7'b0000001: Res_D <= `ALU;
				default: Res_D <= `NW;
			endcase
		end
		
		assign Stall_RS0_E1 = Tuse_RS0 & (Res_E == `ALU) & (Write_Addr_E == Field_rs_D) & (Write_Addr_E != 0);
		assign Stall_RS0_E2 = Tuse_RS0 & (Res_E == `DM)  & (Write_Addr_E == Field_rs_D) & (Write_Addr_E != 0);
		assign Stall_RS0_M1 = Tuse_RS0 & (Res_M == `DM)  & (Write_Addr_M == Field_rs_D) & (Write_Addr_M != 0);
		assign Stall_RS1_E2 = Tuse_RS1 & (Res_E == `DM)  & (Write_Addr_E == Field_rs_D) & (Write_Addr_E != 0);
		
		assign Stall_RT0_E1 = Tuse_RT0 & (Res_E == `ALU) & (Write_Addr_E == Field_rt_D) & (Write_Addr_E != 0);
		assign Stall_RT0_E2 = Tuse_RT0 & (Res_E == `DM)  & (Write_Addr_E == Field_rt_D) & (Write_Addr_E != 0);
		assign Stall_RT0_M1 = Tuse_RT0 & (Res_M == `DM)  & (Write_Addr_M == Field_rt_D) & (Write_Addr_M != 0);
		assign Stall_RT1_E2 = Tuse_RT1 & (Res_E == `DM)  & (Write_Addr_E == Field_rt_D) & (Write_Addr_E != 0);
		
		assign Stall_RS 	= Stall_RS0_E1 | Stall_RS0_E2 | Stall_RS0_M1 | Stall_RS1_E2;
		assign Stall_RT 	= Stall_RT0_E1 | Stall_RT0_E2 | Stall_RT0_M1 | Stall_RT1_E2;
		assign Stall_ERET	= eret & (WT_PR_E == 2'b01) & (Write_Addr_E == 14);
		
		assign  Stall_D 		= 	Stall_RS | Stall_RT | Stall_ERET;
		assign  Stall_PC 		= 	Stall_D;
		assign  Flush_E 		= 	Stall_D;


endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:47:36 12/03/2017 
// Design Name: 
// Module Name:    ctrl 
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
module ctrl(
    input  [31:0] Instr,
    input  Branch,
	 input  INT_REQ,
    output Mem_Write,
    output Reg_Write,
    output [3:0] ALU_Op,
    output Shift,
	 output EXT_Op,
    output ALU_B_Sel,
    output [2:0] PC_Src,
    output [1:0] Data_To_Reg,
    output [1:0] Reg_Dst,
	 output OP_EXP,
	 output [1:0] WT_PR
    );
	 wire [5:0] Op		= Instr[31:26];
	 wire [5:0] Func	= Instr[5:0];
	 wire [4:0] Id		= Instr[20:16];
	 wire [4:0] Wt		= Instr[25:21];
	 reg [18:0] control;
	 
	 assign {WT_PR,OP_EXP,Mem_Write,Reg_Write,ALU_Op,Shift,ALU_B_Sel, EXT_Op, PC_Src, Data_To_Reg, Reg_Dst} = control;
	 always @(*) begin
		case(Op)
			6'b100011 : control <= 19'b00_0_0_1_0000_0_1_1_000_01_00;//lw
			6'b100000 : control <= 19'b00_0_0_1_0000_0_1_1_000_01_00;//lb
			6'b100100 : control <= 19'b00_0_0_1_0000_0_1_1_000_01_00;//lbu
			6'b100001 : control <= 19'b00_0_0_1_0000_0_1_1_000_01_00;//lh
			6'b100101 : control <= 19'b00_0_0_1_0000_0_1_1_000_01_00;//lhu
			6'b101011 : control <= 19'b00_0_1_0_0000_0_1_1_000_00_00;//sw
			6'b101000 : control <= 19'b00_0_1_0_0000_0_1_1_000_00_00;//sb
			6'b101001 : control <= 19'b00_0_1_0_0000_0_1_1_000_00_00;//sh
			
			
			6'b000100 : begin
						  if(Branch) 
								control <= 19'b00_0_0_0_0100_0_0_1_001_00_00;
					     else   
								control <= 19'b00_0_0_0_0100_0_0_1_000_00_00; //beq
						  end
			6'b000101 :if(Branch) control <= 19'b00_0_0_0_0100_0_0_1_001_00_00; 
						  else   control <= 19'b00_0_0_0_0100_0_0_1_000_00_00; //bne
			6'b000111 :if(Branch) control <= 19'b00_0_0_0_0100_0_0_1_001_00_00; 
						  else   control <= 19'b00_0_0_0_0100_0_0_1_000_00_00; //bgtz 
			6'b000001 : begin
				if(Id == 5'b00000 || Id == 5'b00001) begin
							if(Branch) 
								control <= 19'b00_0_0_0_0100_0_0_1_001_00_00; 
					      else   
								control <= 19'b00_0_0_0_0100_0_0_1_000_00_00; //bgez & bltz
				end
				else
							if(Branch) 
								control <= 19'b00_0_0_1_0100_0_0_1_001_10_10; 
					      else   
								control <= 19'b00_0_0_0_0100_0_0_1_000_10_10; //bgezal & bltzal
				end
			6'b000110 :if(Branch) control <= 19'b00_0_0_0_0100_0_0_1_001_00_00; 
					     else   control <= 19'b00_0_0_0_0100_0_0_1_000_00_00; //blez
	
					
			//WT_PR,EXP_OP,Mem_Write,Reg_Write,ALU_Op,Shift,ALU_B_Sel, EXT_Op, PC_Src, Data_To_Reg, Reg_Dst 
			6'b000010 : control <= 19'b00_0_0_0_0000_0_0_0_011_00_00;//j
			6'b000011 : control <= 19'b00_0_0_1_0000_0_0_0_011_10_10;//jal
			
			//6'b011100 : begin 
			//					if(Func==6'b000000) 
			//						control <= 19'b00_0_0_0_0000_0_0_0_000_00_00;//madd
			//				end
			
			
			6'b001111 : control <= 19'b00_0_0_1_0110_0_1_0_000_00_00;//lui
			6'b001000 : control <= 19'b00_0_0_1_1001_0_1_1_000_00_00;//addi
			6'b001001 : control <= 19'b00_0_0_1_0000_0_1_1_000_00_00;//addiu
			6'b001100 : control <= 19'b00_0_0_1_0001_0_1_0_000_00_00;//andi
			6'b001101 : control <= 19'b00_0_0_1_0101_0_1_0_000_00_00;//ori
			6'b001110 : control <= 19'b00_0_0_1_0010_0_1_0_000_00_00;//xori
			
			6'b001010 : control <= 19'b00_0_0_1_0100_0_1_1_000_00_00;//slti
		   6'b001011 : control <= 19'b00_0_0_1_1000_0_1_1_000_00_00;//sltiu
			
			6'b010000 : //COP0
			    begin
					case(Wt)
						5'b00000	: control <= 19'b10_0_0_1_0000_0_0_0_000_01_00;//mfc0
						5'b00100	: control <= 19'b01_0_0_0_0000_0_0_0_000_00_01;//mtc0
						5'b10000	: control <= 19'b11_0_0_0_0000_0_0_0_101_00_00;//eret
						default  : control <= 19'b01_1_0_0_0000_0_0_0_000_00_00;
					endcase
				 end
				 
			
			6'b000000 : //R
			    begin
					case(Func)
					   //WT_PR,EXP_OP,Mem_Write,Reg_Write,ALU_Op,Shift,ALU_B_Sel, EXT_Op, PC_Src, Data_To_Reg, Reg_Dst 
					   
						6'b100000 : control <= 19'b00_0_0_1_1001_0_0_0_000_00_01;//add
						6'b100001 : control <= 19'b00_0_0_1_0000_0_0_0_000_00_01;//addu
						6'b100010 : control <= 19'b00_0_0_1_0100_0_0_0_000_00_01;//sub
						6'b100011 : control <= 19'b00_0_0_1_1000_0_0_0_000_00_01;//subu
						6'b100100 : control <= 19'b00_0_0_1_0001_0_0_0_000_00_01;//and
						6'b100101 : control <= 19'b00_0_0_1_0101_0_0_0_000_00_01;//or
						6'b100110 : control <= 19'b00_0_0_1_0010_0_0_0_000_00_01;//xor						
						6'b100111 : control <= 19'b00_0_0_1_1110_0_0_0_000_00_01;//nor
						
						
						6'b000010 : control <= 19'b00_0_0_1_0111_1_0_0_000_00_01;//srl
						6'b000011 : control <= 19'b00_0_0_1_1111_1_0_0_000_00_01;//sra
						6'b000100 : control <= 19'b00_0_0_1_0011_0_0_0_000_00_01;//sllv
						6'b000110 : control <= 19'b00_0_0_1_0111_0_0_0_000_00_01;//srlv
						6'b000111 : control <= 19'b00_0_0_1_1111_0_0_0_000_00_01;//srav
						
						//WT_PR,EXP_OP,Mem_Write,Reg_Write,ALU_Op,Shift,ALU_B_Sel, EXT_Op, PC_Src, Data_To_Reg, Reg_Dst 
						
						6'b001000 : control <= 19'b00_0_0_0_0000_0_0_0_010_00_00;//jr
						6'b001001 : control <= 19'b00_0_0_1_0000_0_0_0_010_10_01;//jalr
						
						
						6'b101010 : control <= 19'b00_0_0_1_0100_0_0_0_000_00_01;//slt
						6'b101011 : control <= 19'b00_0_0_1_1000_0_0_0_000_00_01;//sltu
						
						
						6'b011010 : control <= 19'b00_0_0_0_0000_0_0_0_000_00_00;//div
						6'b011011 : control <= 19'b00_0_0_0_0000_0_0_0_000_00_00;//divu
						6'b011000 : control <= 19'b00_0_0_0_0000_0_0_0_000_00_00;//mult
						6'b011001 : control <= 19'b00_0_0_0_0000_0_0_0_000_00_00;//multu
						6'b010000 : control <= 19'b00_0_0_1_0000_0_0_0_000_00_01;//mfhi
						6'b010010 : control <= 19'b00_0_0_1_0000_0_0_0_000_00_01;//mflo
						6'b010001 : control <= 19'b00_0_0_0_0000_0_0_0_000_00_00;//mthi
						6'b010011 : control <= 19'b00_0_0_0_0000_0_0_0_000_00_00;//mtlo
						6'b000000 : begin
						if(Instr == 32'b0)
							control <= 19'b00_0_0_0_0000_0_0_0_000_00_00;//nop
						else
							control <= 19'b00_0_0_1_0011_1_0_0_000_00_01;//sll
						end
						default : control <= 19'b01_1_0_0_0000_0_0_0_000_00_00;
						
				endcase
			end
		default : control <= 19'b01_1_0_0_0000_0_0_0_000_00_00;
		endcase
		if(INT_REQ)
			control <= 19'b00_0_0_0_0000_0_0_0_100_00_00;//Interrupt
	end
endmodule

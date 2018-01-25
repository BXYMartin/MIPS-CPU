`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:15:00 12/03/2017 
// Design Name: 
// Module Name:    cmpdecoder 
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
module cmpdecoder(
    input [31:0] Instr_D,
    output [2:0] CMP_Op
    );
	 
	 assign CMP_Op	=	(Instr_D[31:26] == 6'b000100) ? 3'b000 :
							(Instr_D[31:26] == 6'b000111) ? 3'b001 :
							(Instr_D[31:26] == 6'b000110) ? 3'b010 :
							(Instr_D[31:26] == 6'b000101) ? 3'b011 :
							(Instr_D[31:26] == 6'b000001 & Instr_D[20:16] == 5'b00001) ? 3'b100 :
							(Instr_D[31:26] == 6'b000001 & Instr_D[20:16] == 5'b00000) ? 3'b101 :
							(Instr_D[31:26] == 6'b000001 & Instr_D[20:16] == 5'b10001) ? 3'b100 :
							(Instr_D[31:26] == 6'b000001 & Instr_D[20:16] == 5'b10000) ? 3'b101 :
																											 3'bxxx ;
endmodule

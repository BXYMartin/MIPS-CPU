`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:46 12/03/2017 
// Design Name: 
// Module Name:    comms 
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
module comms(
    input [31:0] Instr_E, 
    input [31:0] A, B, ALU_Out, HI, LO,
    output reg [31:0] ALU_Out_E
    );
	 
	 wire [5:0]  Op, Func;
	 wire [31:0] Sub;
	 wire C_Signed, C_Unsigned;
	 wire sltu, slt, mfhi, mflo; 
	 wire [3:0] ctrl;
	 
	 assign Op 	 = Instr_E[31:26];
	 assign Func = Instr_E[5:0];
	 
	 assign ctrl = {sltu, slt, mfhi, mflo};
	 assign slt  = (Op == 6'b001010) | (Op == 6'b000000 & Func == 6'b101010);	// sign select
	 assign sltu = (Op == 6'b001011) | (Op == 6'b000000 & Func == 6'b101011);	// no sign select
	 assign mfhi = (Op == 6'b000000 & Func == 6'b010000);								// mfhi
	 assign mflo = (Op == 6'b000000 & Func == 6'b010010);								// mflo
	 
	 
	 assign {C_Signed, Sub}   = {A[31], A} - {B[31], B};
	 assign {C_Unsigned, Sub} = {1'b0, A} - {1'b0, B};
	 
	always @(*) begin
			case(ctrl)
			 4'b1000 : ALU_Out_E = {31'b0,C_Unsigned};//sltu
			 4'b0100 : ALU_Out_E = {31'b0,C_Signed};  //slt
			 4'b0010 : ALU_Out_E = HI;						//mfhi
			 4'b0001 : ALU_Out_E = LO;						//mflo
			 default : ALU_Out_E = ALU_Out;
			endcase
	end
endmodule

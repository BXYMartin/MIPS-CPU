`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:58 12/06/2017 
// Design Name: 
// Module Name:    f 
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
module f(
	input  clk, 
	input  reset,
	input  STALL_PC,
	input  [31:0] NPC,
	output [31:0] INSTR_F,
	output [31:0] PCadd4F,
	output [31:0] PC
    );
	
	// Instantiate the module
regfilepc #(32) R_PIM_1 (.clk(clk), .reset(reset), .stall(STALL_PC), .Data_In(NPC), .Data_Out(PC));

im IM (
    .Addr(PC[13:2]), 
    .Data_Out(INSTR_F)
    );
	 
adder PCadd4_F (
    .PC(PC), 
    .Imm(32'b100), 
    .Result(PCadd4F)
    );


endmodule

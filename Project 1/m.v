`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:30:36 12/07/2017 
// Design Name: 
// Module Name:    m 
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
module m(
	input  clk,
	input  reset,
	input  MEM_WRITE_ENABLED_M,
	input  [31:0] ALU_OUT_M,
	input  [31:0] INSTR_M,
	input  [31:0] PC_M,
	input  [31:0] FRead_Data_2_M,
	output [31:0] Real_MEM_OUT_M
    );
	
	wire [3:0] BIT_TYPE;
	wire [31:0] MEM_OUT_M;
	
	btdecoder BT_Decoder (
    .ALU_Out_M(ALU_OUT_M[1:0]), 
    .Instr_M(INSTR_M), 
    .Bit_Type(BIT_TYPE)
    );
	 
	dm DM (
	 .PC(PC_M),
    .Addr(ALU_OUT_M), 
    .Bit_Type(BIT_TYPE), 
    .WriteData(FRead_Data_2_M), 
    .ReadData(MEM_OUT_M), 
    .WriteEnabled(MEM_WRITE_ENABLED_M), 
    .clk(clk),
	 .reset(reset)
	 );
	
	dmext DM_EXT (
    .DM_Out(MEM_OUT_M), 
    .Op(INSTR_M[31:26]), 
    .ALU_Out_M(ALU_OUT_M[1:0]), 
    .DM_Out_M(Real_MEM_OUT_M)
    );


endmodule

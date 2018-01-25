`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:34 12/04/2017 
// Design Name: 
// Module Name:    forward 
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
module forward(
	input  [31:0] Instr_D, Instr_E, Instr_M,
	input  [4:0] Write_Addr_E, Write_Addr_M, Write_Addr_W,
	input  Write_Enabled_E, Write_Enabled_M, Write_Enabled_W,
	input  [1:0] Data_To_Reg_M,
	output [1:0] Forward_Data_1_D, Forward_Data_2_D,
	output reg [1:0] Forward_Data_1_E, Forward_Data_2_E,
	output Forward_Data_M
		);
	
///////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Forward GPR ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

	wire [4:0] Field_rs_D, Field_rt_D, Field_rs_E, Field_rt_E, Field_rs_M, Field_rt_M;
	
	assign Field_rs_D = Instr_D[25:21];
	assign Field_rt_D = Instr_D[20:16];
	
	assign Field_rs_E = Instr_E[25:21];
	assign Field_rt_E = Instr_E[20:16];
	
	assign Field_rs_M = Instr_M[25:21];
	assign Field_rt_M = Instr_M[20:16];
	
	// M -> D      
	assign Forward_Data_1_D = (Field_rs_D != 0 & Field_rs_D == Write_Addr_M & Write_Enabled_M & Data_To_Reg_M == `PC_8_W) 	 ? 2'b10:
									  (Field_rs_D != 0 & Field_rs_D == Write_Addr_M & Write_Enabled_M & Data_To_Reg_M == `ALU_OUT_W) ? 2'b01:
																																									   2'b00;
	assign Forward_Data_2_D = (Field_rt_D != 0 & Field_rt_D == Write_Addr_M & Write_Enabled_M & Data_To_Reg_M == `PC_8_W)    ? 2'b10:
									  (Field_rt_D != 0 & Field_rt_D == Write_Addr_M & Write_Enabled_M & Data_To_Reg_M == `ALU_OUT_W) ? 2'b01:
																																										2'b00;
	
	// M -> E
	// W -> E
	always @(*) begin
			Forward_Data_1_E = 2'b00;
			Forward_Data_2_E = 2'b00;
			if (Field_rs_E != 0)
				if (Field_rs_E == Write_Addr_M & Write_Enabled_M)			// Comes from M
					if(Data_To_Reg_M == `PC_8_W)
						Forward_Data_1_E = 2'b11;
					else if(Data_To_Reg_M == `ALU_OUT_W)
						Forward_Data_1_E = 2'b01;
					else
						Forward_Data_1_E = 2'b00;
				else if (Field_rs_E == Write_Addr_W & Write_Enabled_W) 	// Comes from W
						Forward_Data_1_E = 2'b10;
			if (Field_rt_E != 0)
				if (Field_rt_E == Write_Addr_M & Write_Enabled_M)			// Comes from M
						if(Data_To_Reg_M == `PC_8_W)
							Forward_Data_2_E = 2'b11;
						else if(Data_To_Reg_M == `ALU_OUT_W)
							Forward_Data_2_E = 2'b01;
						else
						Forward_Data_2_E = 2'b00;
				else if (Field_rt_E == Write_Addr_W & Write_Enabled_W) 	// Comes from W
						Forward_Data_2_E = 2'b10;
	end
	// W -> M
	assign Forward_Data_M =	(Field_rt_M != 0 & Field_rt_M == Write_Addr_W & Write_Enabled_W) ? 1'b1:
																															 1'b0;

endmodule

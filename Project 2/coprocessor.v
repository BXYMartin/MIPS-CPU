`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:49:19 12/25/2017 
// Design Name: 
// Module Name:    coprocessor 
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
`define im SR[15:10]
`define exl SR[1]
`define ie SR[0]
`define ip Cause_In[15:10]
`define exccode Cause_In[6:2]
`define slot Cause_In[31]
module coprocessor(
    input [4:0] Op_Reg,
    input [31:0] Data_In,
    input [31:0] PC,
    input [6:2] Exception_Code,
    input [15:10] Hardware_Interruption,
    input Write_Enabled,
    input Clear_Exception_Level,
    input clk,
    input rst,
    input Branch_Delay,
    output Ex_Request,
    output [31:0] E_PC,
    output [31:0] Data_Out
    );
	 
	 wire [31:0] Cause_In;
	 
	 wire [6:2] EXP_CODE;
	 
	 reg [31:0] EPC = 0, PrID = 0, Cause = 0, SR = 0;
	 
	 assign EXP_CODE = (((Hardware_Interruption & `im)&&`ie) && !`exl) ? 0              :
																								Exception_Code ;
	 
	 assign Cause_In = {Branch_Delay, 15'b0, Hardware_Interruption, 3'b0, EXP_CODE, 2'b0};

	 assign Ex_Request = (((`ip&`im)&&`ie) || (`exccode!=5'b0)) && !`exl;
	 
	 assign E_PC = (Write_Enabled && Op_Reg==5'd14) ? Data_In :
																	  EPC     ;
	 
	 assign Data_Out = (Op_Reg==5'd12) ? SR	:
							 (Op_Reg==5'd13) ? Cause:
							 (Op_Reg==5'd14) ? EPC	:
							 (Op_Reg==5'd8)  ? PrID	:
													 32'b0;
	initial begin
		SR <= 32'h0; // 32'h0000ff11;
		Cause <= 0;
		EPC <= 0;
		PrID = 32'h20180101;
	end
	
	
	always @(posedge clk) begin
		Cause[15:10] <= Hardware_Interruption;
		if(rst)begin
			SR <= 0; // 32'h0000ff11;
			Cause <= 0;
			EPC <= 0;
		end
		else if(Ex_Request)begin
			`exl <= 1;
			Cause <= Cause_In;
			EPC <= (`slot==1) ? PC-4:
									  PC  ;
		end
		else if(Clear_Exception_Level) begin
			`exl <= 0;
		end
		else if(Write_Enabled) begin
			case(Op_Reg)
				5'd12		: SR <= Data_In;
				5'd14		: EPC <= Data_In;
				default	: ;
			endcase
		end
	end

endmodule

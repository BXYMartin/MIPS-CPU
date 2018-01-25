`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:01 12/03/2017 
// Design Name: 
// Module Name:    btdecoder 
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
module btdecoder(
    input [1:0] ALU_Out_M,
    input [31:0] Instr_M,
    output reg [3:0] Bit_Type
    );
	 
	 wire [31:0] Op, Func;
	 
	 assign Op  = Instr_M[31:26];
	 
	 always @(*) begin
	  if(Op == 6'b101001)	// SH
	     if(ALU_Out_M[1]) 
			  Bit_Type = 4'b1100;
		   else 
			  Bit_Type = 4'b0011;
	  if(Op == 6'b101000)	//SB
	      case(ALU_Out_M)
			   2'b00 :  Bit_Type = 4'b0001;
				2'b01 :  Bit_Type = 4'b0010;
				2'b10 :  Bit_Type = 4'b0100;
				2'b11 :  Bit_Type = 4'b1000;
			endcase
	  if(Op == 6'b101011)	//SW
	        Bit_Type=4'b1111;
    end
endmodule

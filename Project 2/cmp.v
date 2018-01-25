`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:43 12/03/2017 
// Design Name: 
// Module Name:    cmp 
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
module cmp(
    input [31:0] A,
    input [31:0] B,
    input [2:0] Op,
    output reg Branch
    );
	 
	 always @(*) begin
		case(Op) 
			3'b000 : Branch = (A == B);             		//beq
			3'b001 : Branch = (A[31] != 1) & (A != 0);  	//bgtz
			3'b010 : Branch = (A[31] == 1) | (A == 0);  	//blez
			3'b011 : Branch = (A != B);         			//bne
			3'b100 : Branch = (A[31] != 1);         		//bgez
			3'b101 : Branch = (A[31] == 1);         		//bltz
			default: Branch = 1'bx; 
		endcase
	 end
	 
endmodule

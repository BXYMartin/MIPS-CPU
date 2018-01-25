`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:07:44 12/03/2017 
// Design Name: 
// Module Name:    alu 
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
module alu(
	input			[31:0] A,
	input 		[31:0] B,
	input 		[3:0]  Op,
	output reg  [31:0] C,
	output reg			 Overflow
    );
	reg C_Top;
	reg [31:0] C_Temp;
	integer i;
	always @* begin
		case(Op)
			4'b0000:	C = A + B;						// add without sign
			4'b0001: C = A & B;
			4'b0010: C = A ^ B;
			4'b0011: C = B << A[4:0];
			4'b0100: 
				begin
					{C_Top, C} = {A[31], A} - {B[31], B};
					Overflow = (C_Top != C[31]);
				end
			4'b0101: C = A | B;
			4'b0110: C = {B[15:0], 16'b0};		// lui
			4'b0111: C = B >> A[4:0]; 				// logical shift right
			4'b1000: C = A - B;						// sub without sign
			4'b1001:
				begin
					{C_Top, C} = {A[31], A} + {B[31], B};
					Overflow = (C_Top != C[31]);
				end
			4'b1010: C = B << A[4:0]; 				// logical shift left
			4'b1011: C = B;							// move
			4'b1100: ;
			4'b1101: C = $signed(B) <<< A[4:0];	// mathimatically shift left
			4'b1110: C = ~( A | B );
			4'b1111: C = $signed(B) >>> A[4:0];	// mathimatically shift right
			default:	C = 32'bx;
		endcase
		if(Op != 4'b0100 && Op != 4'b1001)
			Overflow = 0;
			
	end

endmodule

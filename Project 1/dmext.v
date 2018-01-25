`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:20:52 12/03/2017 
// Design Name: 
// Module Name:    dmext 
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
module dmext(
    input [31:0] DM_Out,
    input [31:26] Op,
    input [1:0] ALU_Out_M,
    output reg [31:0] DM_Out_M
    );
  always@(*) begin
	case(Op)
	 6'b100000 : case(ALU_Out_M)		// LB
						2'b00 : DM_Out_M <= {{24{DM_Out[7]}} ,DM_Out[7:0]};
						2'b01 : DM_Out_M <= {{24{DM_Out[15]}},DM_Out[15:8]};
						2'b10 : DM_Out_M <= {{24{DM_Out[23]}},DM_Out[23:16]};
						2'b11 : DM_Out_M <= {{24{DM_Out[31]}},DM_Out[31:24]};
					 endcase
	 6'b100100 : case(ALU_Out_M)		// LBU
						2'b00 : DM_Out_M <= {{24'b0},DM_Out[7:0]};
						2'b01 : DM_Out_M <= {{24'b0},DM_Out[15:8]};
						2'b10 : DM_Out_M <= {{24'b0},DM_Out[23:16]};
						2'b11 : DM_Out_M <= {{24'b0},DM_Out[31:24]};
					 endcase
	 6'b100001 : case(ALU_Out_M[1]) // LH
	               1'b0 : DM_Out_M <= {{24{DM_Out[15]}},DM_Out[15:0]};
						1'b1 : DM_Out_M <= {{24{DM_Out[31]}},DM_Out[31:16]};
					 endcase
	 6'b100101 : case(ALU_Out_M[1])	// LHU
	               1'b0 : DM_Out_M <= {24'b0,DM_Out[15:0]};
						1'b1 : DM_Out_M <= {24'b0,DM_Out[31:16]};
					 endcase
	 default :  DM_Out_M <= DM_Out;
	endcase
  end
endmodule

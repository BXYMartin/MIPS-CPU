`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:11:50 12/27/2017 
// Design Name: 
// Module Name:    bridge 
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
module bridge(
    input [31:0] Addr,
	 input Device_WE,
    input [31:0] From_CPU,
    output [31:0] To_Counter,
    input [31:0] From_Counter_0,
    input [31:0] From_Counter_1,
    output [31:0] To_CPU,
    output [7:2] INT_REQ,
	 output Counter_0_WE,
	 output Counter_1_WE,
	 output [31:0] ADDR,
	 input  INT_REQ_0, INT_REQ_1
    );
	

	assign Counter_0_WE = (Addr[14] == 1 && Addr[5] == 0) ? Device_WE :
																			  1'b0	  ;
	 
	assign Counter_1_WE = (Addr[14] == 1 && Addr[5] == 1) ? Device_WE :
																			  1'b0	  ;
																			  
	assign To_Counter = From_CPU;
	
	assign ADDR = Addr;
	
	assign To_CPU = (Addr[14] == 1 && Addr[5] == 0) ? From_Counter_0 :
						 (Addr[14] == 1 && Addr[5] == 1) ? From_Counter_1 :
																				32'b0	  ;
																				
																				
	assign INT_REQ = {4'b0, INT_REQ_1, INT_REQ_0};

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:56 12/03/2017 
// Design Name: 
// Module Name:    grf 
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
module grf(PC, Read_1, Read_2, Write_Dst, Read_Data_1, Read_Data_2, WriteData, WriteEnabled, clk, rst);
	 input  [31:0] PC;
	 input  [4:0]  Read_1;
    input  [4:0]  Read_2;
    input  [4:0]  Write_Dst;
    output [31:0] Read_Data_1;  
    output [31:0] Read_Data_2;
	 input  [31:0] WriteData;
	 input  WriteEnabled;             
	 input  clk;
    input  rst;
	
	reg [31:0] GPR[31:0];	// Define Register Files
	
	assign Read_Data_1 = (WriteEnabled & Read_1 == Write_Dst & Write_Dst != 0) ? WriteData	 :
																										  GPR[Read_1];
	assign Read_Data_2 = (WriteEnabled & Read_2 == Write_Dst & Write_Dst != 0) ? WriteData	 :
																										  GPR[Read_2];
	// Handle Instant Read & Write
	integer i;
	
	initial begin 
		for(i = 0 ; i < 32 ; i = i + 1)
			GPR[i] = 0;
	end
	
	always @(posedge clk) begin
			if(rst == 1) begin
				for(i = 0; i <32; i = i + 1) begin
					case(i)
						28 		:	GPR[i] <= 32'h0000_1800;
						29 		:	GPR[i] <= 32'h0000_2ffc;
						default  :	GPR[i] <= 32'b0;
					endcase
				 end
				end
			else if(WriteEnabled) begin
            $display("%d@%h: $%d <= %h", $time, PC, Write_Dst, WriteData);
				if(Write_Dst != 0)
					GPR[Write_Dst] <= WriteData;
			end
			//else if(WriteEnabled & Write_Dst == 0) begin
			//	$display("%d@%h: $%d <= %h", $time, PC, Write_Dst, WriteData);
			//end
	end

endmodule

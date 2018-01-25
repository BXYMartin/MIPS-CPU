`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:18:01 12/03/2017 
// Design Name: 
// Module Name:    im 
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
module im(
    input [13:2] Addr,
    output [31:0] Data_Out
    );
	 
	 reg [31:0] IM[4095:0];
	 wire [11:0] Real_Addr = Addr - 12'b110000000000;
	 initial begin
		$readmemh ("code.txt", IM);
	 end
	 
	 
	 assign Data_Out = IM[Real_Addr];

endmodule

`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:10:32 12/05/2017
// Design Name:   mips
// Module Name:   E:/Xilinx ISE Programming/PipeLine_CPU/CPU_TEST.v
// Project Name:  PipeLine_CPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPU_TEST;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips CPU (
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 0;
		#100;
		reset = 0;
		// $stop;
		// Add stimulus here
		Test;
	end
	
	task Test;
	begin
      #1000000;
	end
	endtask
	
	always #10 clk = ~clk;
      
endmodule


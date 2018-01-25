`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:21 01/01/2018 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

	wire [31:0] DEVICE_OUT, TO_COUNTER_DATA, FROM_COUNTER_0, FROM_COUNTER_1;
	wire DEVICE_WE, Counter_0_WE, Counter_1_WE, INT_REQ_0, INT_REQ_1;
	wire [31:0] DEVICE_ADDR, DEVICE_DATA, ADDR;
	wire [5:0] HW_INT;
	
	// Instantiate the Unit Under Test (UUT)
	cpu CPU (
		.clk(clk), 
		.reset(reset),
		.HW_INT(HW_INT),
		.DEVICE_OUT(DEVICE_OUT), 
		.DEVICE_WE(DEVICE_WE),
		.DEVICE_ADDR(DEVICE_ADDR), 
		.DEVICE_DATA(DEVICE_DATA)
	);
	
	bridge BRIDGE (
    .Addr(DEVICE_ADDR), 
    .Device_WE(DEVICE_WE), 
    .From_CPU(DEVICE_DATA), 
    .From_Counter_0(FROM_COUNTER_0), 
    .From_Counter_1(FROM_COUNTER_1), 
	 .Counter_0_WE(Counter_0_WE),
	 .Counter_1_WE(Counter_1_WE),
	 .To_Counter(TO_COUNTER_DATA), 
    .To_CPU(DEVICE_OUT), 
    .INT_REQ(HW_INT),
	 .ADDR(ADDR),
	 .INT_REQ_0(INT_REQ_0),
	 .INT_REQ_1(INT_REQ_1)
    );
	 
	counter COUNTER_0 (
    .clk(clk), 
    .rst(reset), 
    .Addr(ADDR[3:2]), 
    .Write_Enabled(Counter_0_WE), 
    .Data_In(TO_COUNTER_DATA), 
    .Data_Out(FROM_COUNTER_0), 
    .INT_REQ(INT_REQ_0)
    );
	 
	 counter COUNTER_1 (
    .clk(clk), 
    .rst(reset), 
    .Addr(ADDR[3:2]), 
    .Write_Enabled(Counter_1_WE), 
    .Data_In(TO_COUNTER_DATA), 
    .Data_Out(FROM_COUNTER_1), 
    .INT_REQ(INT_REQ_1)
    );


endmodule

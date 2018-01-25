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
    input clk_in,
    input sys_rstn,
	 output [31:0] led_light,
	 input  [7:0] user_key,
	 input  [7:0] dip_switch0,
	 input  [7:0] dip_switch1,
	 input  [7:0] dip_switch2,
	 input  [7:0] dip_switch3,
	 input  [7:0] dip_switch4,
	 input  [7:0] dip_switch5,
	 input  [7:0] dip_switch6,
	 input  [7:0] dip_switch7,
	 output [3:0] digital_tube_sel0,
	 output [3:0] digital_tube_sel1,
	 output digital_tube_sel2,
	 output [7:0] digital_tube0,
	 output [7:0] digital_tube1,
	 output [7:0] digital_tube2,
	 input  RxD,
	 output TxD
    );

	wire [31:0] DEVICE_OUT, TO_DEV_DATA, FROM_DEV_0, FROM_DEV_1, FROM_DEV_2, FROM_DEV_3, FROM_DEV_4, FROM_DEV_5;
	wire DEVICE_WE, INT_REQ_0, INT_REQ_1, INT_REQ_2, INT_REQ_3, INT_REQ_4, INT_REQ_5;
	wire [5:0] DEV_X_WE;
	wire clk, clk_m;
	wire [31:0] DEVICE_ADDR, DEVICE_DATA, ADDR;
	wire [5:0] HW_INT;
	wire [15:0] digit0, digit1;
	wire [3:0]  digit2;
	wire reset;
	
	assign reset = sys_rstn;
	
	clock CLOCK
   (// Clock in ports
    .CLK_IN1(clk_in),      // IN
    // Clock out ports
    .CLK_OUT1(clk),     // OUT
    .CLK_OUT2(clk_m));    // OUT
	
	button BUTTON (
    .user_key(user_key), 
    .out(FROM_DEV_5)
    );
	
	
	light LIGHT (
    .clk(clk), 
    .reset(reset), 
    .we(DEV_X_WE[3]), 
    .in(TO_DEV_DATA), 
    .out(FROM_DEV_3), 
    .led_light(led_light)
    );

	
	
	switch SWITCH (
    .dip_switch0(dip_switch0), 
    .dip_switch1(dip_switch1), 
    .dip_switch2(dip_switch2), 
    .dip_switch3(dip_switch3), 
    .dip_switch4(dip_switch4), 
    .dip_switch5(dip_switch5), 
    .dip_switch6(dip_switch6), 
    .dip_switch7(dip_switch7), 
    .out(FROM_DEV_2), 
    .addr(ADDR[2])
    );
	
	MiniUART UART (
    .ADD_I(ADDR[4:2]), 
    .DAT_I(TO_DEV_DATA), 
    .DAT_O(FROM_DEV_1), 
    .STB_I(DEV_X_WE[1]), 
    .WE_I(DEV_X_WE[1]), 
    .CLK_I(clk), 
    .RST_I(reset), 
    //.ACK_O(ACK_O),  // Tell CPU Ready?
    .RxD(RxD), 
    .TxD(TxD), 
    .INT(INT_REQ_1)
    );
	
	
	// Instantiate the Unit Under Test (UUT)
	cpu CPU (
		.clk(clk), 
		.clk_m(clk_m),
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
    .From_Dev_0(FROM_DEV_0), 
	 .From_Dev_1(FROM_DEV_1), 
	 .From_Dev_2(FROM_DEV_2), 
	 .From_Dev_3(FROM_DEV_3), 
	 .From_Dev_4(FROM_DEV_4), 
	 .From_Dev_5(FROM_DEV_5), 
	 .DEV_X_WE(DEV_X_WE),
	 .To_Dev(TO_DEV_DATA), 
    .To_CPU(DEVICE_OUT), 
    .INT_REQ(HW_INT),
	 .ADDR(ADDR),
	 .INT_REQ_X({4'b0, INT_REQ_1, INT_REQ_0}) // {INT_REQ_5, INT_REQ_4, INT_REQ_3, INT_REQ_2, INT_REQ_1, INT_REQ_0}
    );
	 
	timer COUNTER (
    .clk(clk), 
    .rst(reset), 
    .Addr(ADDR[3:2]), 
    .Write_Enabled(DEV_X_WE[0]), 
    .Data_In(TO_DEV_DATA), 
    .Data_Out(FROM_DEV_0), 
    .INT_REQ(INT_REQ_0)
    );
	 
	led LED (
    .clk(clk), 
    .reset(reset), 
    .addr(ADDR[2]), 
    .digit0(digit0), 
    .digit1(digit1), 
    .digit2(digit2), 
    .we(DEV_X_WE[4]), 
    .in(TO_DEV_DATA), 
    .out(FROM_DEV_4)
    );

	ledctrl0 LED_CTRL0 (
    .clk(clk), 
    .reset(reset), 
    .digit(digit0), // 
    .digital_tube_sel0(digital_tube_sel0), 
    .digital_tube0(digital_tube0)
    );
	 
	 ledctrl1 LED_CTRL1 (
    .clk(clk), 
    .reset(reset), 
    .digit(digit1), // 
    .digital_tube_sel1(digital_tube_sel1), 
    .digital_tube1(digital_tube1)
    );

	ledctrl2 LED_CTRL2 (
    .clk(clk), 
    .reset(reset), 
    .digit(digit2), 
    .digital_tube_sel2(digital_tube_sel2), 
    .digital_tube2(digital_tube2)
    );

endmodule

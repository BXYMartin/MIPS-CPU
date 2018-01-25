`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:38 01/08/2018 
// Design Name: 
// Module Name:    ledctrl 
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
module ledctrl0 #(parameter Interval = 40000000 / 50 - 1)(
    input clk,
	 input reset,
    input [15:0] digit,
    output [3:0] digital_tube_sel0,
    output [7:0] digital_tube0
    );
	
	wire [3:0] Data;
	reg [1:0] Sel;
	integer Count;
	

	
	assign Data = (Sel == 2'b00) ? digit[15:12] :
					  (Sel == 2'b01) ? digit[11:8] :
					  (Sel == 2'b10) ? digit[7:4] :
					  (Sel == 2'b11) ? digit[3:0] :
											 4'b0	  ;
											 
	assign digital_tube_sel0 = (Sel == 2'b00) ? 4'b1000 :
										(Sel == 2'b01) ? 4'b0100 :
										(Sel == 2'b10) ? 4'b0010 :
										(Sel == 2'b11) ? 4'b0001 :
															  4'b1111 ;
	assign digital_tube0[7] = 1;//!Data[7];	// DP/Display Point
	
	assign digital_tube0[6:0] = (Data == 4'h00) ? 7'b0000001 :
										 (Data == 4'h01) ? 7'b1001111 :
										 (Data == 4'h02) ? 7'b0010010 :
										 (Data == 4'h03) ? 7'b0000110 :
										 (Data == 4'h04) ? 7'b1001100 :
										 (Data == 4'h05) ? 7'b0100100 :
										 (Data == 4'h06) ? 7'b0100000 :
										 (Data == 4'h07) ? 7'b0001111 :
										 (Data == 4'h08) ? 7'b0000000 :
										 (Data == 4'h09) ? 7'b0000100 :
										 (Data == 4'h0a) ? 7'b0001000 :
										 (Data == 4'h0b) ? 7'b1100000 :
										 (Data == 4'h0c) ? 7'b0110001 :
										 (Data == 4'h0d) ? 7'b1000010 :
										 (Data == 4'h0e) ? 7'b0110000 :
										 (Data == 4'h0f) ? 7'b0111000 :
																 7'b1111110 ;
	
	
always @(posedge clk) begin
	if(reset) begin
		Count <= 0;
		Sel <= 0;
	end
	else begin
		Count <= Count + 1;
		
		if(Count >= Interval) begin
			Count <= 0;
			Sel <= Sel + 1;
		end
	end
end

endmodule

module ledctrl1 #(parameter Interval = 40000000 / 50 - 1)(
    input clk,
	 input reset,
    input [15:0] digit,
    output [3:0] digital_tube_sel1,
    output [7:0] digital_tube1
    );
	
	wire [4:0] Data;
	reg [1:0] Sel;
	integer Count;
	

	
	assign Data = (Sel == 2'b00) ? digit[15:12] :
					  (Sel == 2'b01) ? digit[11:8] :
					  (Sel == 2'b10) ? digit[7:4] :
					  (Sel == 2'b11) ? digit[3:0] :
											 4'b0	  ;
											 
	assign digital_tube_sel1 = (Sel == 2'b00) ? 4'b1000 :
										(Sel == 2'b01) ? 4'b0100 :
										(Sel == 2'b10) ? 4'b0010 :
										(Sel == 2'b11) ? 4'b0001 :
															  4'b1111 ;
	assign digital_tube1[7] = 1;//!Data[7];	// DP/Display Point
	
	assign digital_tube1[6:0] = (Data == 4'h00) ? 7'b0000001 :
										 (Data == 4'h01) ? 7'b1001111 :
										 (Data == 4'h02) ? 7'b0010010 :
										 (Data == 4'h03) ? 7'b0000110 :
										 (Data == 4'h04) ? 7'b1001100 :
										 (Data == 4'h05) ? 7'b0100100 :
										 (Data == 4'h06) ? 7'b0100000 :
										 (Data == 4'h07) ? 7'b0001111 :
										 (Data == 4'h08) ? 7'b0000000 :
										 (Data == 4'h09) ? 7'b0000100 :
										 (Data == 4'h0a) ? 7'b0001000 :
										 (Data == 4'h0b) ? 7'b1100000 :
										 (Data == 4'h0c) ? 7'b0110001 :
										 (Data == 4'h0d) ? 7'b1000010 :
										 (Data == 4'h0e) ? 7'b0110000 :
										 (Data == 4'h0f) ? 7'b0111000 :
																 7'b1111110 ;
	
	
always @(posedge clk) begin
	if(reset) begin
		Count <= 0;
		Sel <= 0;
	end
	else begin
		Count <= Count + 1;
		
		if(Count >= Interval) begin
			Count <= 0;
			Sel <= Sel + 1;
		end
	end
end

endmodule

module ledctrl2(
    input clk,
	 input reset,
    input [3:0] digit,
    output digital_tube_sel2,
    output [7:0] digital_tube2
    );
	
	wire [3:0] Data;
	

	
	assign Data = digit;
											 
	assign digital_tube_sel2 = 1; // Constant ?
	
	assign digital_tube2[7] = 1;//!Data[7];	// DP/Display Point
	
	assign digital_tube2[6:0] = (Data == 4'h0) ? 7'b0000001 :
										 (Data == 4'h1) ? 7'b1001111 :
										 (Data == 4'h2) ? 7'b0010010 :
										 (Data == 4'h3) ? 7'b0000110 :
										 (Data == 4'h4) ? 7'b1001100 :
										 (Data == 4'h5) ? 7'b0100100 :
										 (Data == 4'h6) ? 7'b0100000 :
										 (Data == 4'h7) ? 7'b0001111 :
										 (Data == 4'h8) ? 7'b0000000 :
										 (Data == 4'h9) ? 7'b0000100 :
										 (Data == 4'ha) ? 7'b0001000 :
										 (Data == 4'hb) ? 7'b1100000 :
										 (Data == 4'hc) ? 7'b0110001 :
										 (Data == 4'hd) ? 7'b1000010 :
										 (Data == 4'he) ? 7'b0110000 :
										 (Data == 4'hf) ? 7'b0111000 :
																 7'b1111110 ;

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:38 12/27/2017 
// Design Name: 
// Module Name:    counter 
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
`define im CTRL[3]
`define mode CTRL[2:1]
`define enable CTRL[0]

`define idle 2'b00
`define load 2'b01
`define cnting 2'b10
`define int 2'b11

module counter(
    input clk,
    input rst,
    input [1:0] Addr,
    input Write_Enabled,
    input [31:0] Data_In,
    output [31:0] Data_Out,
    output INT_REQ
    );
	 
	 reg [31:0] CTRL = 0;
	 reg [31:0] PRESET = 0;
	 reg [31:0] COUNT = 0;
	 reg [1:0] STATE = 0;
	 reg INT;
	 
	 // assign INT = `im&&(COUNT==0)&&(`enable==0);
	 
	 assign INT_REQ = `im && INT;
	 
	 assign Data_Out = (Addr==2'b00)?CTRL:
							 (Addr==2'b01)?PRESET:
							 (Addr==2'b10)?COUNT:
												32'b0;
	 
	always@(posedge clk)begin
		 if(rst)begin
			CTRL<= 0;
			PRESET<= 0;
			COUNT<= 0;
			STATE<= 0;
			INT<=0;
		 end
		 
		 else begin
		 if(Write_Enabled)begin
			if(Addr==2'b00) 
				CTRL<=Data_In[3:0];
			else if(Addr==2'b01)
				PRESET<=Data_In;
		 end
		 
			case(STATE)
				`idle:begin
					STATE<=(`enable)?`load:`idle;
				end
				
				`load:begin
					INT<=(`enable && PRESET==0) ?1'b1:1'b0;
					STATE<=(`enable && PRESET!=0) ?`cnting:
							 (`enable && PRESET==0) ?`int   :
														    `idle  ;
					COUNT<=(`enable)?PRESET:0;
				end
				
				`cnting:begin
					if(`enable) begin
					if(COUNT!=1)begin
						COUNT<=COUNT-1;
					end
					else begin 
						STATE<=`int;
						COUNT<= COUNT-1;
					end
					end
					else begin
						STATE<=`idle;
						INT<=1'b0;
					end
				end
				
				`int:begin
					if(`enable) begin
						STATE<=(`mode==2'b00)?`idle:`load;
						INT<=1'b1;
						`enable<=(`mode==2'b00)?0:1;
					end
					else begin
						STATE<=`idle;
						INT<=1'b0;
					end
				end
				default:STATE<=`idle;
			endcase
		end
	end
endmodule
	
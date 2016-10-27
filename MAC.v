`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:01 09/30/2016 
// Design Name: 
// Module Name:    MAC 
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
module MAC(output [3:0] cnt_w, input clk, input [7:0] datain1, input [7:0] datain2, input [3:0] addr_in, output reg [3:0] cnt, output [7:0] r2, output [7:0] r3, input write, output [31:0] r1, input read, input reset);

initial
begin
	cnt<=0;
end 
assign cnt_w=cnt|addr_in ;
RAMic d1(.addr_in (cnt_w), .clk (clk), .read (read), .reset(reset), .read_out(r2), .write (write),.data_in(datain1) );
RAMic d2(.addr_in (cnt_w), .clk (clk), .read (read), .reset(reset), .read_out(r3), .write (write),.data_in(datain2) );


MACic mac(.r3 (r3), .r2(r2), .enable(read), .reset(reset), .r1(r1), .clk(clk));
always @(negedge clk)
begin
if (read)
begin
	if (reset==1)
	cnt<=0;
	else if(cnt==15)
	$finish;
	else 
	cnt <= cnt + 1;
end
end
			
   
endmodule

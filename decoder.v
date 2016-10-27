`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:46:09 09/30/2016 
// Design Name: 
// Module Name:    decoder 
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
module decoder(input enable, input [3:0]addr_in, output [15:0]addr_out);
assign addr_out[0]=(!addr_in[3])&(!addr_in[2])&(!addr_in[1])&(!addr_in[0])&enable; 
assign addr_out[1]=(!addr_in[3])&(!addr_in[2])&(!addr_in[1])&(addr_in[0])&enable; 
assign addr_out[2]=(!addr_in[3])&(!addr_in[2])&(addr_in[1])&(!addr_in[0])&enable; 
assign addr_out[3]=(!addr_in[3])&(!addr_in[2])&(addr_in[1])&(addr_in[0])&enable; 
assign addr_out[4]=(!addr_in[3])&(addr_in[2])&(!addr_in[1])&(!addr_in[0])&enable; 
assign addr_out[5]=(!addr_in[3])&(addr_in[2])&(!addr_in[1])&(addr_in[0])&enable; 
assign addr_out[6]=(!addr_in[3])&(addr_in[2])&(addr_in[1])&(!addr_in[0])&enable;
assign addr_out[7]=(!addr_in[3])&(addr_in[2])&(addr_in[1])&(addr_in[0])&enable; 
assign addr_out[8]=(addr_in[3])&(!addr_in[2])&(!addr_in[1])&(!addr_in[0])&enable; 
assign addr_out[9]=(addr_in[3])&(!addr_in[2])&(!addr_in[1])&(addr_in[0])&enable; 
assign addr_out[10]=(addr_in[3])&(!addr_in[2])&(addr_in[1])&(!addr_in[0])&enable; 
assign addr_out[11]=(addr_in[3])&(!addr_in[2])&(addr_in[1])&(addr_in[0])&enable; 
assign addr_out[12]=(addr_in[3])&(addr_in[2])&(!addr_in[1])&(!addr_in[0])&enable; 
assign addr_out[13]=(addr_in[3])&(addr_in[2])&(!addr_in[1])&(addr_in[0])&enable; 
assign addr_out[14]=(addr_in[3])&(addr_in[2])&(addr_in[1])&(!addr_in[0])&enable; 
assign addr_out[15]=(addr_in[3])&(addr_in[2])&(addr_in[1])&(addr_in[0])&enable;

 
//assign addr_out = (enable) ? (1 << addr_in) : 16'b0;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Group 15
// Engineer: 
// 
// Create Date:    16:32:11 02/29/2016 
// Design Name: 
// Module Name:    CLAA16bit 
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
//21.509ns
//////////////////////////////////////////////////////////////////////////////////
module CLAA16bit(
    input [15:0] a,
    input [15:0] b,
   
    output [15:0] s,
    output cout
    );
	 wire cin;
	 wire car[3:0];
	 wire pout[3:0],gout[3:0];
	 wire fcar[2:0];
assign cin=0;
claa4bit d1(a[3:0],b[3:0],cin,s[3:0],car[0],pout[0],gout[0]);
claa4bit d2(a[7:4],b[7:4],fcar[0],s[7:4],car[1],pout[1],gout[1]);
claa4bit d3(a[11:8],b[11:8],fcar[1],s[11:8],car[2],pout[2],gout[2]);
claa4bit d4(a[15:12],b[15:12],fcar[2],s[15:12],car[3],pout[3],gout[3]);
assign fcar[0]=gout[0]|(cin&pout[0]);
assign fcar[1]=(gout[0]&pout[1])|(cin&pout[0]&pout[1])|gout[1];
assign fcar[2]=(gout[0]&pout[1]&pout[2])|(cin&pout[0]&pout[1]&pout[2])|(gout[1]&pout[2])|gout[2];
assign cout=car[3];

endmodule

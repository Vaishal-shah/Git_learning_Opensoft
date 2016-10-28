`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:35:31 02/29/2016 
// Design Name: 
// Module Name:    CLA4bit 
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
// 12.813ns-cla 
// 22.433ns-rca 4 bit(hierarchy true) 13.902 (false)
//////////////////////////////////////////////////////////////////////////////////
module CLA4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] s,
	 
    output cout
    );
wire c[3:0],g[3:0],p[3:0];

half_adder f1(a[0],b[0],p[0],g[0]),
				f2(a[1],b[1],p[1],g[1]),
				f3(a[2],b[2],p[2],g[2]),
				f4(a[3],b[3],p[3],g[3]);
				
assign c[0]=(cin&p[0])|g[0];
assign c[1]=(g[0]&p[1])|g[1]|(cin&p[0]&p[1]);
assign c[2]=(g[0]&p[1]&p[2])|(g[1]&p[2])|(cin&p[0]&p[1]&p[2])|g[2];
assign c[3]=(g[0]&p[1]&p[2]&p[3])|(g[1]&p[2]&p[3])|(g[2]&p[3])|(cin&p[0]&p[1]&p[2]&p[3])|g[3];
assign s[0]=p[0]^cin;
assign s[1]=p[1]^c[0];
assign s[2]=p[2]^c[1];
assign s[3]=p[3]^c[2];
assign cout=c[3];
endmodule

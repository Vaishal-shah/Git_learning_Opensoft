`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:34:58 02/29/2016 
// Design Name: 
// Module Name:    rca16cla 
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
//24.362ns 
//////////////////////////////////////////////////////////////////////////////////
module rca16cla(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] s,
    output cout
    );

wire car[3:0];
CLA4bit d1(a[3:0],b[3:0],cin,s[3:0],car[0]);
CLA4bit d2(a[7:4],b[7:4],car[0],s[7:4],car[1]);
CLA4bit d3(a[11:8],b[11:8],car[1],s[11:8],car[2]);
CLA4bit d4(a[15:12],b[15:12],car[2],s[15:12],car[3]);
assign cout=car[3];
endmodule

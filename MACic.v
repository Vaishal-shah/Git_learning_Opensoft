`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:33:10 10/16/2016 
// Design Name: 
// Module Name:    MACic 
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
module MACic(input [7:0] r3, r2, input enable, input reset, output reg [31:0] r1, input clk);
wire [31:0] S;
initial
begin
	r1<=0;
end 
wire [31:0] P;
multiplier m1(r2,r3,P);
adder_32bit s(P,r1,S);
always @(negedge clk)
begin
if(enable)
begin
	r1<=S;
end
if (reset)
begin
	r1<=0;
end
end

endmodule

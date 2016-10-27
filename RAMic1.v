`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:57:09 09/30/2016 
// Design Name: 
// Module Name:    RAMic1 
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
module RAMic(input [7:0] data_in, input [3:0]addr_in, input clk, input read,input write, input reset, output [7:0] read_out );


wire [15:0] addr_out;
wire [7:0] dataout[0:15]; 


decoder dec(.enable (1'b1), .addr_in (addr_in), .addr_out (addr_out));

reg8 rin0(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[0]), .out (dataout[0]));
reg8 rin1(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[1]), .out (dataout[1]));
reg8 rin2(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[2]), .out (dataout[2]));
reg8 rin3(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[3]), .out (dataout[3]));
reg8 rin4(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[4]), .out (dataout[4]));
reg8 rin5(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[5]), .out (dataout[5]));
reg8 rin6(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[6]), .out (dataout[6]));
reg8 rin7(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[7]), .out (dataout[7]));
reg8 rin8(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[8]), .out (dataout[8]));
reg8 rin9(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[9]), .out (dataout[9]));
reg8 rin10(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[10]), .out (dataout[10]));
reg8 rin11(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[11]), .out (dataout[11]));
reg8 rin12(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[12]), .out (dataout[12]));
reg8 rin13(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[13]), .out (dataout[13]));
reg8 rin14(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[14]), .out (dataout[14]));
reg8 rin15(.din (data_in),.clk (clk), .reset (reset), .enable (write && addr_out[15]), .out (dataout[15]));

buff8 b0(.in  (dataout[0]), .out (read_out), .read_en (addr_out[0] && read));
buff8 b1(.in  (dataout[1]), .out (read_out), .read_en (addr_out[1] && read));
buff8 b2(.in  (dataout[2]), .out (read_out), .read_en (addr_out[2] && read));
buff8 b3(.in  (dataout[3]), .out (read_out), .read_en (addr_out[3] && read));
buff8 b4(.in  (dataout[4]), .out (read_out), .read_en (addr_out[4] && read));
buff8 b5(.in  (dataout[5]), .out (read_out), .read_en (addr_out[5] && read));
buff8 b6(.in  (dataout[6]), .out (read_out), .read_en (addr_out[6] && read));
buff8 b7(.in  (dataout[7]), .out (read_out), .read_en (addr_out[7] && read));
buff8 b8(.in  (dataout[8]), .out (read_out), .read_en (addr_out[8] && read));
buff8 b9(.in  (dataout[9]), .out (read_out), .read_en (addr_out[9] && read));
buff8 b10(.in  (dataout[10]), .out (read_out), .read_en (addr_out[10] && read));
buff8 b11(.in  (dataout[11]), .out (read_out), .read_en (addr_out[11] && read));
buff8 b12(.in  (dataout[12]), .out (read_out), .read_en (addr_out[12] && read));
buff8 b13(.in  (dataout[13]), .out (read_out), .read_en (addr_out[13] && read));
buff8 b14(.in  (dataout[14]), .out (read_out), .read_en (addr_out[14] && read));
buff8 b15(.in  (dataout[15]), .out (read_out), .read_en (addr_out[15] && read));




endmodule

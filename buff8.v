`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:54:19 09/30/2016 
// Design Name: 
// Module Name:    buff8 
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
module buff8(input [7:0] in, output reg [7:0] out,input read_en);
			//read_en : read enable comes from the decoder

initial
begin
out<=0;
end

//assign out = read_en ? in : 8'bz ;                

always @ ((read_en) or in)
	begin 
	if ( (read_en)== 1'b1 )
		begin
			out = in;
		end
	else 		out = 8'bz;
	
	end
endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:10 09/30/2016 
// Design Name: 
// Module Name:    adder_32bit 
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
module adder_32bit(a,b,sum);
input [31:0] a, b;
output [31:0] sum;
wire [32:0] carry;

assign carry[0] = 1'b0;

fulladder s0(a[0],b[0],carry[0],sum[0],carry[1]);
fulladder s1(a[1],b[1],carry[1],sum[1],carry[2]);
fulladder s2(a[2],b[2],carry[2],sum[2],carry[3]);
fulladder s3(a[3],b[3],carry[3],sum[3],carry[4]);
fulladder s4(a[4],b[4],carry[4],sum[4],carry[5]);
fulladder s5(a[5],b[5],carry[5],sum[5],carry[6]);
fulladder s6(a[6],b[6],carry[6],sum[6],carry[7]);
fulladder s7(a[7],b[7],carry[7],sum[7],carry[8]);
fulladder s8(a[8],b[8],carry[8],sum[8],carry[9]);
fulladder s9(a[9],b[9],carry[9],sum[9],carry[10]);
fulladder s10(a[10],b[10],carry[10],sum[10],carry[11]);
fulladder s11(a[11],b[11],carry[11],sum[11],carry[12]);
fulladder s12(a[12],b[12],carry[12],sum[12],carry[13]);
fulladder s13(a[13],b[13],carry[13],sum[13],carry[14]);
fulladder s14(a[14],b[14],carry[14],sum[14],carry[15]);
fulladder s15(a[15],b[15],carry[15],sum[15],carry[16]);
fulladder s16(a[16],b[16],carry[16],sum[16],carry[17]);
fulladder s17(a[17],b[17],carry[17],sum[17],carry[18]);
fulladder s18(a[18],b[18],carry[18],sum[18],carry[19]);
fulladder s19(a[19],b[19],carry[19],sum[19],carry[20]);
fulladder s20(a[20],b[20],carry[20],sum[20],carry[21]);
fulladder s21(a[21],b[21],carry[21],sum[21],carry[22]);
fulladder s22(a[22],b[22],carry[22],sum[22],carry[23]);
fulladder s23(a[23],b[23],carry[23],sum[23],carry[24]);
fulladder s24(a[24],b[24],carry[24],sum[24],carry[25]);
fulladder s25(a[25],b[25],carry[25],sum[25],carry[26]);
fulladder s26(a[26],b[26],carry[26],sum[26],carry[27]);
fulladder s27(a[27],b[27],carry[27],sum[27],carry[28]);
fulladder s28(a[28],b[28],carry[28],sum[28],carry[29]);
fulladder s29(a[29],b[29],carry[29],sum[29],carry[30]);
fulladder s30(a[30],b[30],carry[30],sum[30],carry[31]);
fulladder s31(a[31],b[31],carry[31],sum[31],carry[32]);



endmodule


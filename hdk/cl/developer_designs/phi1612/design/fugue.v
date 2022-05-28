/*
 * Copyright (c) 2017 Sprocket
 *
 * This is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License with
 * additional permissions to the one published by the Free Software
 * Foundation, either version 3 of the License, or (at your option)
 * any later version. For more information see LICENSE.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

module fugue512 (
	input clk,
	input [511:0] data,
	output [511:0] hash
);

	reg phase = 1'b0;
	reg phase2 = 1'b0;

	reg [31:0] i0,i1,i2,i3,i4,i5,i6,i7,i8;

	reg [1151:0] S0,S1,S2,S3,S4,S5,S6,S7,S8,S9;
	
	reg [1151:0] ci0,ci1,ci2,ci3,ci4,ci5,ci6,ci7;
	reg [1151:0] ci8,ci9,ciA,ciB,ciC,ciD,ciE,ciF;
	reg [1151:0] C15x;

	reg [1151:0] di0,di1,di2,di3,di4,di5,di6,D6x;

	reg [511:0] H;
	
	assign hash = H;

	reg [511:0] x0, x0_1, x0_2, x0_3, x0_4, x0_5;
	reg [479:0] x1, x1_1, x1_2, x1_3, x1_4, x1_5;
	reg [447:0] x2, x2_1, x2_2, x2_3, x2_4, x2_5;
	reg [415:0] x3, x3_1, x3_2, x3_3, x3_4, x3_5;
	reg [383:0] x4, x4_1, x4_2, x4_3, x4_4, x4_5;
	reg [351:0] x5, x5_1, x5_2, x5_3, x5_4, x5_5;
	reg [319:0] x6, x6_1, x6_2, x6_3, x6_4, x6_5;
	reg [287:0] x7, x7_1, x7_2, x7_3, x7_4, x7_5;
	reg [255:0] x8, x8_1, x8_2, x8_3, x8_4, x8_5;
	reg [223:0] x9, x9_1, x9_2, x9_3, x9_4, x9_5;
	reg [191:0] x10, x10_1, x10_2, x10_3, x10_4, x10_5;
	reg [159:0] x11, x11_1, x11_2, x11_3, x11_4, x11_5;
	reg [127:0] x12, x12_1, x12_2, x12_3, x12_4, x12_5;
	reg [ 95:0] x13, x13_1, x13_2, x13_3, x13_4, x13_5;
	reg [ 63:0] x14, x14_1, x14_2, x14_3, x14_4, x14_5;
	reg [ 31:0] x15, x15_1, x15_2, x15_3, x15_4, x15_5;
	
	reg [1151:0] Sx;

	wire [1151:0] S1_d, S2_d, S3_d, S4_d, S5_d, S6_d, S7_d, S8_d, S9_d;

	wire [1151:0] C0,C1,C2,C3,C4,C5,C6,C7;
	wire [1151:0] C8,C9,C10,C11,C12,C13,C14,C15;

	wire [1151:0] D0,D1,D2,D3,D4,D5,D6;
	
	round r0  (clk, i0, S0,  S1_d);
	round r1  (clk, i1, S1,  S2_d);
	round r2  (clk, i2, S2,  S3_d);
	round r3  (clk, i3, S3,  S4_d);
	round r4  (clk, i4, S4,  S5_d);
	round r5  (clk, i5, S5,  S6_d);
	round r6  (clk, i6, S6,  S7_d);
	round r7  (clk, i7, S7,  S8_d);
	round r8  (clk, i8, S8,  S9_d);

	close_1 c0 (clk, ci0, C0);
	close_1 c1 (clk, ci1, C1);
	close_1 c2 (clk, ci2, C2);
	close_1 c3 (clk, ci3, C3);
	close_1 c4 (clk, ci4, C4);
	close_1 c5 (clk, ci5, C5);
	close_1 c6 (clk, ci6, C6);
	close_1 c7 (clk, ci7, C7);
	close_1 c8 (clk, ci8, C8);
	close_1 c9 (clk, ci9, C9);
	close_1 c10 (clk, ciA, C10);
	close_1 c11 (clk, ciB, C11);
	close_1 c12 (clk, ciC, C12);
	close_1 c13 (clk, ciD, C13);
	close_1 c14 (clk, ciE, C14);
	close_1 c15 (clk, ciF, C15);

	close_2 d0 (clk, di0, D0);
	close_2 d1 (clk, di1, D1);
	close_2 d2 (clk, di2, D2);
	close_2 d3 (clk, di3, D3);
	close_2 d4 (clk, di4, D4);
	close_2 d5 (clk, di5, D5);
	close_2 d6 (clk, di6, D6);
	
	always @ (posedge clk) begin
	
		if ( !phase ) begin
		
			i0 <= x0[511:480];
			i1 <= x1[479:448];
			i2 <= x2[447:416];
			i3 <= x3[415:384];
			i4 <= x4[383:352];
			i5 <= x5[351:320];
			i6 <= x6[319:288];
			i7 <= x7[287:256];
			i8 <= x8[255:224];

			S0[1151:640] <= 512'he13e3567da6ed11d951fddd625ea78e7437f203fcae65838ddb21398aac6e2c94a92efd106e8020bb6eecc54d915f117ac9ab027c5d3e4dbe616af758807a57e;
			S0[639:0] <= 640'd0;
			
			Sx <= S9_d;

			ci0 <= C15x;
			
			di0 <= C15;

			x15 <= x15_4;
			x15_4 <= x15_3;
			x15_3 <= x15_2;
			x15_2 <= x15_1;
			x15_1 <= x14[31:0];
			x14 <= x14_4;
			x14_4 <= x14_3;
			x14_3 <= x14_2;
			x14_2 <= x14_1;
			x14_1 <= x13[63:0];
			x13 <= x13_4;
			x13_4 <= x13_3;
			x13_3 <= x13_2;
			x13_2 <= x13_1;
			x13_1 <= x12[95:0];
			x12 <= x12_4;
			x12_4 <= x12_3;
			x12_3 <= x12_2;
			x12_2 <= x12_1;
			x12_1 <= x11[127:0];
			x11 <= x11_4;
			x11_4 <= x11_3;
			x11_3 <= x11_2;
			x11_2 <= x11_1;
			x11_1 <= x10[159:0];
			x10 <= x10_4;
			x10_4 <= x10_3;
			x10_3 <= x10_2;
			x10_2 <= x10_1;
			x10_1 <= x9[191:0];
			x9 <= x9_5;
			x9_5 <= x9_4;
			x9_4 <= x9_3;
			x9_3 <= x9_2;
			x9_2 <= x9_1;
			x9_1 <= x8[223:0];
			x8 <= x8_4;
			x8_4 <= x8_3;
			x8_3 <= x8_2;
			x8_2 <= x8_1;
			x8_1 <= x7[255:0];
			x7 <= x7_4;
			x7_4 <= x7_3;
			x7_3 <= x7_2;
			x7_2 <= x7_1;
			x7_1 <= x6[287:0];
			x6 <= x6_4;
			x6_4 <= x6_3;
			x6_3 <= x6_2;
			x6_2 <= x6_1;
			x6_1 <= x5[319:0];
			x5 <= x5_4;
			x5_4 <= x5_3;
			x5_3 <= x5_2;
			x5_2 <= x5_1;
			x5_1 <= x4[351:0];
			x4 <= x4_4;
			x4_4 <= x4_3;
			x4_3 <= x4_2;
			x4_2 <= x4_1;
			x4_1 <= x3[383:0];
			x3 <= x3_4;
			x3_4 <= x3_3;
			x3_3 <= x3_2;
			x3_2 <= x3_1;
			x3_1 <= x2[415:0];
			x2 <= x2_4;
			x2_4 <= x2_3;
			x2_3 <= x2_2;
			x2_2 <= x2_1;
			x2_1 <= x1[447:0];
			x1 <= x1_4;
			x1_4 <= x1_3;
			x1_3 <= x1_2;
			x1_2 <= x1_1;
			x1_1 <= x0[479:0];
			x0 <= data;

		end
		else begin

			S0 <= { Sx[767:0], Sx[1151:768] };
			
			i0 <= x9[223:192];
			i1 <= x10[191:160];
			i2 <= x11[159:128];
			i3 <= x12[127: 96];
			i4 <= x13[ 95: 64];
			i5 <= x14[ 63: 32];
			i6 <= x15[ 31:  0];
			i7 <= 32'h00000000;
			i8 <= 32'h00000200;
			
			ci0 <= { S9_d[767:0], S9_d[1151:768] };
			
			di0 <= D6x;

			H <= { D5[ 32 +: 32],
					D5[ 64 +: 32],
					D5[ 96 +: 32],
					D5[128 +: 32] ^ D5[0 +: 32],
					D5[288 +: 32] ^ D5[0 +: 32],
					D5[320 +: 32],
					D5[352 +: 32],
					D5[384 +: 32],
					D5[576 +: 32] ^ D5[0 +: 32],
					D5[608 +: 32],
					D5[640 +: 32],
					D5[672 +: 32],
					D5[864 +: 32] ^ D5[0 +: 32],
					D5[896 +: 32],
					D5[928 +: 32],
					D5[960 +: 32] };
		
		end

		S1 <= { S1_d[767:0], S1_d[1151:768] };
		S2 <= { S2_d[767:0], S2_d[1151:768] };
		S3 <= { S3_d[767:0], S3_d[1151:768] };
		S4 <= { S4_d[767:0], S4_d[1151:768] };
		S5 <= { S5_d[767:0], S5_d[1151:768] };
		S6 <= { S6_d[767:0], S6_d[1151:768] };
		S7 <= { S7_d[767:0], S7_d[1151:768] };
		S8 <= { S8_d[767:0], S8_d[1151:768] };

		ci1 <= C0;
		ci2 <= C1;
		ci3 <= C2;
		ci4 <= C3;
		ci5 <= C4;
		ci6 <= C5;
		ci7 <= C6;
		ci8 <= C7;
		ci9 <= C8;
		ciA <= C9;
		ciB <= C10;
		ciC <= C11;
		ciD <= C12;
		ciE <= C13;
		ciF <= C14;
		C15x <= C15;

		di1 <= D0;
		di2 <= D1;
		di3 <= D2;
		di4 <= D3;
		di5 <= D4;
		di6 <= D5;
		D6x <= D6;
		
		phase <= ~phase;
		
//		$finish;
		
	end

endmodule

//module TIX (
//	input [1151:0] in,
//	input [31:0] q,
//	output [1151:0] out
//);
//
//	assign out[1152-((36- 0)*32) +: 32] = q;
//	assign out[1152-((36- 1)*32) +: 32] = in[1152-((36- 1)*32) +: 32] ^ in[1152-((36-24)*32) +: 32];
//	assign out[1152-((36- 2)*32) +: 32] = in[1152-((36- 2)*32) +: 32];
//	assign out[1152-((36- 3)*32) +: 32] = in[1152-((36- 3)*32) +: 32];
//	assign out[1152-((36- 4)*32) +: 32] = in[1152-((36- 4)*32) +: 32] ^ in[1152-((36-27)*32) +: 32];
//	assign out[1152-((36- 5)*32) +: 32] = in[1152-((36- 5)*32) +: 32];
//	assign out[1152-((36- 6)*32) +: 32] = in[1152-((36- 6)*32) +: 32];
//	assign out[1152-((36- 7)*32) +: 32] = in[1152-((36- 7)*32) +: 32] ^ in[1152-((36-30)*32) +: 32];
//	assign out[1152-((36- 8)*32) +: 32] = in[1152-((36- 8)*32) +: 32] ^ q;
//	assign out[1152-((36- 9)*32) +: 32] = in[1152-((36- 9)*32) +: 32];
//	assign out[1152-((36-10)*32) +: 32] = in[1152-((36-10)*32) +: 32];
//	assign out[1152-((36-11)*32) +: 32] = in[1152-((36-11)*32) +: 32];
//	assign out[1152-((36-12)*32) +: 32] = in[1152-((36-12)*32) +: 32];
//	assign out[1152-((36-13)*32) +: 32] = in[1152-((36-13)*32) +: 32];
//	assign out[1152-((36-14)*32) +: 32] = in[1152-((36-14)*32) +: 32];
//	assign out[1152-((36-15)*32) +: 32] = in[1152-((36-15)*32) +: 32];
//	assign out[1152-((36-16)*32) +: 32] = in[1152-((36-16)*32) +: 32];
//	assign out[1152-((36-17)*32) +: 32] = in[1152-((36-17)*32) +: 32];
//	assign out[1152-((36-18)*32) +: 32] = in[1152-((36-18)*32) +: 32];
//	assign out[1152-((36-19)*32) +: 32] = in[1152-((36-19)*32) +: 32];
//	assign out[1152-((36-20)*32) +: 32] = in[1152-((36-20)*32) +: 32];
//	assign out[1152-((36-21)*32) +: 32] = in[1152-((36-21)*32) +: 32];
//	assign out[1152-((36-22)*32) +: 32] = in[1152-((36-22)*32) +: 32] ^ in[1152-((36- 0)*32) +: 32];
//	assign out[1152-((36-23)*32) +: 32] = in[1152-((36-23)*32) +: 32];
//	assign out[1152-((36-24)*32) +: 32] = in[1152-((36-24)*32) +: 32];
//	assign out[1152-((36-25)*32) +: 32] = in[1152-((36-25)*32) +: 32];
//	assign out[1152-((36-26)*32) +: 32] = in[1152-((36-26)*32) +: 32];
//	assign out[1152-((36-27)*32) +: 32] = in[1152-((36-27)*32) +: 32];
//	assign out[1152-((36-28)*32) +: 32] = in[1152-((36-28)*32) +: 32];
//	assign out[1152-((36-29)*32) +: 32] = in[1152-((36-29)*32) +: 32];
//	assign out[1152-((36-30)*32) +: 32] = in[1152-((36-30)*32) +: 32];
//	assign out[1152-((36-31)*32) +: 32] = in[1152-((36-31)*32) +: 32];
//	assign out[1152-((36-32)*32) +: 32] = in[1152-((36-32)*32) +: 32];
//	assign out[1152-((36-33)*32) +: 32] = in[1152-((36-33)*32) +: 32];
//	assign out[1152-((36-34)*32) +: 32] = in[1152-((36-34)*32) +: 32];
//	assign out[1152-((36-35)*32) +: 32] = in[1152-((36-35)*32) +: 32];
//
//endmodule


//module CMIX (
//	input [95:0] i0,
//	input [95:0] i1,
//	input [95:0] i2,
//	output [95:0] o1,
//	output [95:0] o2
//);
//
//	assign o1 = i0 ^ i2;
//	assign o2 = i1 ^ i2;
//
//endmodule


module round (
	input clk,
	input [31:0] q,
	input [1151:0] S,
	output [1151:0] O
);

	wire [127:0] S1, S2, S3, S4;
	wire [1151:0] tix;

	reg [1151:0] S0i, S0ix, S1i, S1ix, S2i, S2ix, S3i, S3ix, S4i;

	assign tix[1152-((36- 0)*32) +: 32] = q;
	assign tix[1152-((36- 1)*32) +: 32] = S[1152-((36- 1)*32) +: 32] ^ S[1152-((36-24)*32) +: 32];
	assign tix[1152-((36- 2)*32) +: 32] = S[1152-((36- 2)*32) +: 32];
	assign tix[1152-((36- 3)*32) +: 32] = S[1152-((36- 3)*32) +: 32];
	assign tix[1152-((36- 4)*32) +: 32] = S[1152-((36- 4)*32) +: 32] ^ S[1152-((36-27)*32) +: 32];
	assign tix[1152-((36- 5)*32) +: 32] = S[1152-((36- 5)*32) +: 32];
	assign tix[1152-((36- 6)*32) +: 32] = S[1152-((36- 6)*32) +: 32];
	assign tix[1152-((36- 7)*32) +: 32] = S[1152-((36- 7)*32) +: 32] ^ S[1152-((36-30)*32) +: 32];
	assign tix[1152-((36- 8)*32) +: 32] = S[1152-((36- 8)*32) +: 32] ^ q;
	assign tix[1152-((36- 9)*32) +: 32] = S[1152-((36- 9)*32) +: 32];
	assign tix[1152-((36-10)*32) +: 32] = S[1152-((36-10)*32) +: 32];
	assign tix[1152-((36-11)*32) +: 32] = S[1152-((36-11)*32) +: 32];
	assign tix[1152-((36-12)*32) +: 32] = S[1152-((36-12)*32) +: 32];
	assign tix[1152-((36-13)*32) +: 32] = S[1152-((36-13)*32) +: 32];
	assign tix[1152-((36-14)*32) +: 32] = S[1152-((36-14)*32) +: 32];
	assign tix[1152-((36-15)*32) +: 32] = S[1152-((36-15)*32) +: 32];
	assign tix[1152-((36-16)*32) +: 32] = S[1152-((36-16)*32) +: 32];
	assign tix[1152-((36-17)*32) +: 32] = S[1152-((36-17)*32) +: 32];
	assign tix[1152-((36-18)*32) +: 32] = S[1152-((36-18)*32) +: 32];
	assign tix[1152-((36-19)*32) +: 32] = S[1152-((36-19)*32) +: 32];
	assign tix[1152-((36-20)*32) +: 32] = S[1152-((36-20)*32) +: 32];
	assign tix[1152-((36-21)*32) +: 32] = S[1152-((36-21)*32) +: 32];
	assign tix[1152-((36-22)*32) +: 32] = S[1152-((36-22)*32) +: 32] ^ S[1152-((36- 0)*32) +: 32];
	assign tix[1152-((36-23)*32) +: 32] = S[1152-((36-23)*32) +: 32];
	assign tix[1152-((36-24)*32) +: 32] = S[1152-((36-24)*32) +: 32];
	assign tix[1152-((36-25)*32) +: 32] = S[1152-((36-25)*32) +: 32];
	assign tix[1152-((36-26)*32) +: 32] = S[1152-((36-26)*32) +: 32];
	assign tix[1152-((36-27)*32) +: 32] = S[1152-((36-27)*32) +: 32];
	assign tix[1152-((36-28)*32) +: 32] = S[1152-((36-28)*32) +: 32];
	assign tix[1152-((36-29)*32) +: 32] = S[1152-((36-29)*32) +: 32];
	assign tix[1152-((36-30)*32) +: 32] = S[1152-((36-30)*32) +: 32];
	assign tix[1152-((36-31)*32) +: 32] = S[1152-((36-31)*32) +: 32];
	assign tix[1152-((36-32)*32) +: 32] = S[1152-((36-32)*32) +: 32];
	assign tix[1152-((36-33)*32) +: 32] = S[1152-((36-33)*32) +: 32];
	assign tix[1152-((36-34)*32) +: 32] = S[1152-((36-34)*32) +: 32];
	assign tix[1152-((36-35)*32) +: 32] = S[1152-((36-35)*32) +: 32];
	
	smix smix0(clk, S0i[1152-((36-33)*32) +: 32], S0i[1152-((36-34)*32) +: 32], S0i[1152-((36-35)*32) +: 32], S0i[1152-((36- 0)*32) +: 32], S1);
	smix smix1(clk, S1i[1152-((36-30)*32) +: 32], S1i[1152-((36-31)*32) +: 32], S1i[1152-((36-32)*32) +: 32], S1i[1152-((36-33)*32) +: 32], S2);
	smix smix2(clk, S2i[1152-((36-27)*32) +: 32], S2i[1152-((36-28)*32) +: 32], S2i[1152-((36-29)*32) +: 32], S2i[1152-((36-30)*32) +: 32], S3);
	smix smix3(clk, S3i[1152-((36-24)*32) +: 32], S3i[1152-((36-25)*32) +: 32], S3i[1152-((36-26)*32) +: 32], S3i[1152-((36-27)*32) +: 32], S4);

	assign O = S4i;

//	assign O[1152-((36-24)*32) +: 32] = S4[127:96];
//	assign O[1152-((36-25)*32) +: 32] = S4[95:64];
//	assign O[1152-((36-26)*32) +: 32] = S4[63:32];
//	assign O[1152-((36-27)*32) +: 32] = S4[31:0];
//	assign O[1151-((36-24)*32) : 1152-((36-0)*32)] = S3ix[1151-((36-24)*32) : 1152-((36-0)*32)];
//	assign O[1151-((36-36)*32) : 1152-((36-28)*32)] = S3ix[1151-((36-36)*32) : 1152-((36-28)*32)];
	
	always @ (posedge clk) begin

//		tix[1152-((36- 0)*32) +: 32] <= q;
//		tix[1152-((36- 1)*32) +: 32] <= S[1152-((36- 1)*32) +: 32] ^ S[1152-((36-24)*32) +: 32];
//		tix[1152-((36- 2)*32) +: 32] <= S[1152-((36- 2)*32) +: 32];
//		tix[1152-((36- 3)*32) +: 32] <= S[1152-((36- 3)*32) +: 32];
//		tix[1152-((36- 4)*32) +: 32] <= S[1152-((36- 4)*32) +: 32] ^ S[1152-((36-27)*32) +: 32];
//		tix[1152-((36- 5)*32) +: 32] <= S[1152-((36- 5)*32) +: 32];
//		tix[1152-((36- 6)*32) +: 32] <= S[1152-((36- 6)*32) +: 32];
//		tix[1152-((36- 7)*32) +: 32] <= S[1152-((36- 7)*32) +: 32] ^ S[1152-((36-30)*32) +: 32];
//		tix[1152-((36- 8)*32) +: 32] <= S[1152-((36- 8)*32) +: 32] ^ q;
//		tix[1152-((36- 9)*32) +: 32] <= S[1152-((36- 9)*32) +: 32];
//		tix[1152-((36-10)*32) +: 32] <= S[1152-((36-10)*32) +: 32];
//		tix[1152-((36-11)*32) +: 32] <= S[1152-((36-11)*32) +: 32];
//		tix[1152-((36-12)*32) +: 32] <= S[1152-((36-12)*32) +: 32];
//		tix[1152-((36-13)*32) +: 32] <= S[1152-((36-13)*32) +: 32];
//		tix[1152-((36-14)*32) +: 32] <= S[1152-((36-14)*32) +: 32];
//		tix[1152-((36-15)*32) +: 32] <= S[1152-((36-15)*32) +: 32];
//		tix[1152-((36-16)*32) +: 32] <= S[1152-((36-16)*32) +: 32];
//		tix[1152-((36-17)*32) +: 32] <= S[1152-((36-17)*32) +: 32];
//		tix[1152-((36-18)*32) +: 32] <= S[1152-((36-18)*32) +: 32];
//		tix[1152-((36-19)*32) +: 32] <= S[1152-((36-19)*32) +: 32];
//		tix[1152-((36-20)*32) +: 32] <= S[1152-((36-20)*32) +: 32];
//		tix[1152-((36-21)*32) +: 32] <= S[1152-((36-21)*32) +: 32];
//		tix[1152-((36-22)*32) +: 32] <= S[1152-((36-22)*32) +: 32] ^ S[1152-((36- 0)*32) +: 32];
//		tix[1152-((36-23)*32) +: 32] <= S[1152-((36-23)*32) +: 32];
//		tix[1152-((36-24)*32) +: 32] <= S[1152-((36-24)*32) +: 32];
//		tix[1152-((36-25)*32) +: 32] <= S[1152-((36-25)*32) +: 32];
//		tix[1152-((36-26)*32) +: 32] <= S[1152-((36-26)*32) +: 32];
//		tix[1152-((36-27)*32) +: 32] <= S[1152-((36-27)*32) +: 32];
//		tix[1152-((36-28)*32) +: 32] <= S[1152-((36-28)*32) +: 32];
//		tix[1152-((36-29)*32) +: 32] <= S[1152-((36-29)*32) +: 32];
//		tix[1152-((36-30)*32) +: 32] <= S[1152-((36-30)*32) +: 32];
//		tix[1152-((36-31)*32) +: 32] <= S[1152-((36-31)*32) +: 32];
//		tix[1152-((36-32)*32) +: 32] <= S[1152-((36-32)*32) +: 32];
//		tix[1152-((36-33)*32) +: 32] <= S[1152-((36-33)*32) +: 32];
//		tix[1152-((36-34)*32) +: 32] <= S[1152-((36-34)*32) +: 32];
//		tix[1152-((36-35)*32) +: 32] <= S[1152-((36-35)*32) +: 32];

		// CMIX36 - 0
		S0i[1152-((36-33)*32) +: 32] <= tix[1152-((36-33)*32) +: 32] ^ tix[1152-((36- 1)*32) +: 32];
		S0i[1152-((36-34)*32) +: 32] <= tix[1152-((36-34)*32) +: 32] ^ tix[1152-((36- 2)*32) +: 32];
		S0i[1152-((36-35)*32) +: 32] <= tix[1152-((36-35)*32) +: 32] ^ tix[1152-((36- 3)*32) +: 32];
		S0i[1152-((36-15)*32) +: 32] <= tix[1152-((36-15)*32) +: 32] ^ tix[1152-((36- 1)*32) +: 32];
		S0i[1152-((36-16)*32) +: 32] <= tix[1152-((36-16)*32) +: 32] ^ tix[1152-((36- 2)*32) +: 32];
		S0i[1152-((36-17)*32) +: 32] <= tix[1152-((36-17)*32) +: 32] ^ tix[1152-((36- 3)*32) +: 32];
		S0i[1151-((36-15)*32) : 1152-((36-0)*32)] <= tix[1151-((36-15)*32) : 1152-((36-0)*32)];
		S0i[1151-((36-33)*32) : 1152-((36-18)*32)] <= tix[1151-((36-33)*32) : 1152-((36-18)*32)];
		
		S0ix <= S0i;

		// CMIX36 - 1
		S1i[1152-((36-33)*32) +: 32] <= S1[127:96];
		S1i[1152-((36-34)*32) +: 32] <= S1[95:64];
		S1i[1152-((36-35)*32) +: 32] <= S1[63:32];
		S1i[1152-((36- 0)*32) +: 32] <= S1[31:0];
		S1i[1152-((36-30)*32) +: 32] <= S0ix[1152-((36-30)*32) +: 32] ^ S1[95:64];
		S1i[1152-((36-31)*32) +: 32] <= S0ix[1152-((36-31)*32) +: 32] ^ S1[63:32];
		S1i[1152-((36-32)*32) +: 32] <= S0ix[1152-((36-32)*32) +: 32] ^ S1[31:0];
		S1i[1152-((36-12)*32) +: 32] <= S0ix[1152-((36-12)*32) +: 32] ^ S1[95:64];
		S1i[1152-((36-13)*32) +: 32] <= S0ix[1152-((36-13)*32) +: 32] ^ S1[63:32];
		S1i[1152-((36-14)*32) +: 32] <= S0ix[1152-((36-14)*32) +: 32] ^ S1[31:0];
		S1i[1151-((36-12)*32) : 1152-((36-1)*32)] <= S0ix[1151-((36-12)*32) : 1152-((36-1)*32)];
		S1i[1151-((36-30)*32) : 1152-((36-15)*32)] <= S0ix[1151-((36-30)*32) : 1152-((36-15)*32)];

		S1ix <= S1i;

		// CMIX36 - 2
		S2i[1152-((36-30)*32) +: 32] <= S2[127:96];
		S2i[1152-((36-31)*32) +: 32] <= S2[95:64];
		S2i[1152-((36-32)*32) +: 32] <= S2[63:32];
		S2i[1152-((36-33)*32) +: 32] <= S2[31:0];
		S2i[1152-((36-27)*32) +: 32] <= S1ix[1152-((36-27)*32) +: 32] ^ S2[95:64];
		S2i[1152-((36-28)*32) +: 32] <= S1ix[1152-((36-28)*32) +: 32] ^ S2[63:32];
		S2i[1152-((36-29)*32) +: 32] <= S1ix[1152-((36-29)*32) +: 32] ^ S2[31:0];
		S2i[1152-((36- 9)*32) +: 32] <= S1ix[1152-((36- 9)*32) +: 32] ^ S2[95:64];
		S2i[1152-((36-10)*32) +: 32] <= S1ix[1152-((36-10)*32) +: 32] ^ S2[63:32];
		S2i[1152-((36-11)*32) +: 32] <= S1ix[1152-((36-11)*32) +: 32] ^ S2[31:0];
		S2i[1151-((36- 9)*32) : 1152-((36-0)*32)] <= S1ix[1151-((36- 9)*32) : 1152-((36-0)*32)];
		S2i[1151-((36-27)*32) : 1152-((36-12)*32)] <= S1ix[1151-((36-27)*32) : 1152-((36-12)*32)];
		S2i[1151-((36-36)*32) : 1152-((36-34)*32)] <= S1ix[1151-((36-36)*32) : 1152-((36-34)*32)];

		S2ix <= S2i;

		// CMIX36 - 3
		S3i[1152-((36-27)*32) +: 32] <= S3[127:96];
		S3i[1152-((36-28)*32) +: 32] <= S3[95:64];
		S3i[1152-((36-29)*32) +: 32] <= S3[63:32];
		S3i[1152-((36-30)*32) +: 32] <= S3[31:0];
		S3i[1152-((36-24)*32) +: 32] <= S2ix[1152-((36-24)*32) +: 32] ^ S3[95:64];
		S3i[1152-((36-25)*32) +: 32] <= S2ix[1152-((36-25)*32) +: 32] ^ S3[63:32];
		S3i[1152-((36-26)*32) +: 32] <= S2ix[1152-((36-26)*32) +: 32] ^ S3[31:0];
		S3i[1152-((36- 6)*32) +: 32] <= S2ix[1152-((36- 6)*32) +: 32] ^ S3[95:64];
		S3i[1152-((36- 7)*32) +: 32] <= S2ix[1152-((36- 7)*32) +: 32] ^ S3[63:32];
		S3i[1152-((36- 8)*32) +: 32] <= S2ix[1152-((36- 8)*32) +: 32] ^ S3[31:0];
		S3i[1151-((36- 6)*32) : 1152-((36-0)*32)] <= S2ix[1151-((36- 6)*32) : 1152-((36-0)*32)];
		S3i[1151-((36-24)*32) : 1152-((36-9)*32)] <= S2ix[1151-((36-24)*32) : 1152-((36-9)*32)];
		S3i[1151-((36-36)*32) : 1152-((36-31)*32)] <= S2ix[1151-((36-36)*32) : 1152-((36-31)*32)];

		S3ix <= S3i;

		S4i[1152-((36-24)*32) +: 32] <= S4[127:96];
		S4i[1152-((36-25)*32) +: 32] <= S4[95:64];
		S4i[1152-((36-26)*32) +: 32] <= S4[63:32];
		S4i[1152-((36-27)*32) +: 32] <= S4[31:0];
		S4i[1151-((36-24)*32) : 1152-((36-0)*32)] <= S3ix[1151-((36-24)*32) : 1152-((36-0)*32)];
		S4i[1151-((36-36)*32) : 1152-((36-28)*32)] <= S3ix[1151-((36-36)*32) : 1152-((36-28)*32)];

	end

endmodule

module close_1 (
	input clk,
	input [1151:0] S,
	output reg [1151:0] O
);

	wire [127:0] S1;
	wire [1151:0] Si;
	
	assign Si = { S[1055:0], S[1151:1056] };

	reg [1151:0] S0i, S0ix;

	smix smix0(clk, S0i[1152-((36-0)*32) +: 32], S0i[1152-((36-1)*32) +: 32], S0i[1152-((36-2)*32) +: 32], S0i[1152-((36-3)*32) +: 32], S1);
	
//	assign O = { S0_q[1151:128], S1[31:0], S1[63:32], S1[95:64], S1[127:96] };
	
	always @ (posedge clk) begin

		S0i[1152-((36- 0)*32) +: 32] <= Si[1152-((36- 0)*32) +: 32] ^ Si[1152-((36- 4)*32) +: 32];
		S0i[1152-((36- 1)*32) +: 32] <= Si[1152-((36- 1)*32) +: 32] ^ Si[1152-((36- 5)*32) +: 32];
		S0i[1152-((36- 2)*32) +: 32] <= Si[1152-((36- 2)*32) +: 32] ^ Si[1152-((36- 6)*32) +: 32];
		S0i[1152-((36-18)*32) +: 32] <= Si[1152-((36-18)*32) +: 32] ^ Si[1152-((36- 4)*32) +: 32];
		S0i[1152-((36-19)*32) +: 32] <= Si[1152-((36-19)*32) +: 32] ^ Si[1152-((36- 5)*32) +: 32];
		S0i[1152-((36-20)*32) +: 32] <= Si[1152-((36-20)*32) +: 32] ^ Si[1152-((36- 6)*32) +: 32];
		S0i[1151-((36-18)*32) : 1152-((36-3)*32)] <= Si[1151-((36-18)*32) : 1152-((36-3)*32)];
		S0i[1151-((36-36)*32) : 1152-((36-21)*32)] <= Si[1151-((36-36)*32) : 1152-((36-21)*32)];
		
		S0ix <= S0i;

		O <= { S0ix[1151:128], S1[31:0], S1[63:32], S1[95:64], S1[127:96] };

	end

endmodule

module close_2 (
	input clk,
	input [1151:0] S,
	output [1151:0] O
);

	wire [127:0] S1, S2, S3, S4;

	reg [1151:0] S0i, S0ix, S1i, S1ix, S2i, S2ix, S3i, S3ix, S4i;
	
	smix smix0 (clk, S0i[1152-((36-0)*32) +: 32], S0i[1152-((36-1)*32) +: 32], S0i[1152-((36-2)*32) +: 32], S0i[1152-((36-3)*32) +: 32], S1);
	smix smix1 (clk, S1i[1152-((36-0)*32) +: 32], S1i[1152-((36-1)*32) +: 32], S1i[1152-((36-2)*32) +: 32], S1i[1152-((36-3)*32) +: 32], S2);
	smix smix2 (clk, S2i[1152-((36-0)*32) +: 32], S2i[1152-((36-1)*32) +: 32], S2i[1152-((36-2)*32) +: 32], S2i[1152-((36-3)*32) +: 32], S3);
	smix smix3 (clk, S3i[1152-((36-1)*32) +: 32], S3i[1152-((36-2)*32) +: 32], S3i[1152-((36-3)*32) +: 32], S3i[1152-((36-4)*32) +: 32], S4);
	
	assign O = S4i;
	
	always @ (posedge clk) begin
	
//		S0_d = S;
//
//		S0_d[1152-((36-4)*32) +: 32] = S0_d[1152-((36-4)*32) +: 32] ^ S0_d[1152-((36-0)*32) +: 32];
//		S0_d[1152-((36-9)*32) +: 32] = S0_d[1152-((36-9)*32) +: 32] ^ S0_d[1152-((36-0)*32) +: 32];
//		S0_d[1152-((36-18)*32) +: 32] = S0_d[1152-((36-18)*32) +: 32] ^ S0_d[1152-((36-0)*32) +: 32];
//		S0_d[1152-((36-27)*32) +: 32] = S0_d[1152-((36-27)*32) +: 32] ^ S0_d[1152-((36-0)*32) +: 32];
//		S0_d = { S0_d[863:0], S0_d[1151:864] };

		S0i[1152-((36-13)*32) +: 32] <= S[1152-((36- 4)*32) +: 32] ^ S[1152-((36- 0)*32) +: 32];
		S0i[1152-((36-18)*32) +: 32] <= S[1152-((36- 9)*32) +: 32] ^ S[1152-((36- 0)*32) +: 32];
		S0i[1152-((36-27)*32) +: 32] <= S[1152-((36-18)*32) +: 32] ^ S[1152-((36- 0)*32) +: 32];
		S0i[1152-((36- 0)*32) +: 32] <= S[1152-((36-27)*32) +: 32] ^ S[1152-((36- 0)*32) +: 32];
		S0i[1151-((36- 9)*32) : 1152-((36- 1)*32)] <= S[1151-((36-36)*32) : 1152-((36-28)*32)];
		S0i[1151-((36-13)*32) : 1152-((36- 9)*32)] <= S[1151-((36- 4)*32) : 1152-((36- 0)*32)];
		S0i[1151-((36-18)*32) : 1152-((36-14)*32)] <= S[1151-((36- 9)*32) : 1152-((36- 5)*32)];
		S0i[1151-((36-27)*32) : 1152-((36-19)*32)] <= S[1151-((36-18)*32) : 1152-((36-10)*32)];
		S0i[1151-((36-36)*32) : 1152-((36-28)*32)] <= S[1151-((36-27)*32) : 1152-((36-19)*32)];
		
		S0ix <= S0i;

//		S1_d = S0_q;
//		S1_d[31:0] = S1[127:96];
//		S1_d[63:32] = S1[95:64];
//		S1_d[95:64] = S1[63:32];
//		S1_d[127:96] = S1[31:0];
//
//		S1_d[1152-((36-4)*32) +: 32] = S1_d[1152-((36-4)*32) +: 32] ^ S1_d[1152-((36-0)*32) +: 32];
//		S1_d[1152-((36-10)*32) +: 32] = S1_d[1152-((36-10)*32) +: 32] ^ S1_d[1152-((36-0)*32) +: 32];
//		S1_d[1152-((36-18)*32) +: 32] = S1_d[1152-((36-18)*32) +: 32] ^ S1_d[1152-((36-0)*32) +: 32];
//		S1_d[1152-((36-27)*32) +: 32] = S1_d[1152-((36-27)*32) +: 32] ^ S1_d[1152-((36-0)*32) +: 32];
//		S1_d = { S1_d[863:0], S1_d[1151:864] };

		S1i[1152-((36- 9)*32) +: 32] <= S1[127:96];
		S1i[1152-((36-10)*32) +: 32] <= S1[95:64];
		S1i[1152-((36-11)*32) +: 32] <= S1[63:32];
		S1i[1152-((36-12)*32) +: 32] <= S1[31:0];
		S1i[1152-((36-13)*32) +: 32] <= S0ix[1152-((36- 4)*32) +: 32] ^ S1[127:96];
		S1i[1152-((36-19)*32) +: 32] <= S0ix[1152-((36-10)*32) +: 32] ^ S1[127:96];
		S1i[1152-((36-27)*32) +: 32] <= S0ix[1152-((36-18)*32) +: 32] ^ S1[127:96];
		S1i[1152-((36- 0)*32) +: 32] <= S0ix[1152-((36-27)*32) +: 32] ^ S1[127:96];
		S1i[1151-((36- 9)*32) : 1152-((36- 1)*32)] <= S0ix[1151-((36-36)*32) : 1152-((36-28)*32)];
		S1i[1151-((36-19)*32) : 1152-((36-14)*32)] <= S0ix[1151-((36-10)*32) : 1152-((36- 5)*32)];
		S1i[1151-((36-27)*32) : 1152-((36-20)*32)] <= S0ix[1151-((36-18)*32) : 1152-((36-11)*32)];
		S1i[1151-((36-36)*32) : 1152-((36-28)*32)] <= S0ix[1151-((36-27)*32) : 1152-((36-19)*32)];

		S1ix <= S1i;

//		S2_d = S1_q;
//		S2_d[31:0] = S2[127:96];
//		S2_d[63:32] = S2[95:64];
//		S2_d[95:64] = S2[63:32];
//		S2_d[127:96] = S2[31:0];
//
//		S2_d[1152-((36-4)*32) +: 32] = S2_d[1152-((36-4)*32) +: 32] ^ S2_d[1152-((36-0)*32) +: 32];
//		S2_d[1152-((36-10)*32) +: 32] = S2_d[1152-((36-10)*32) +: 32] ^ S2_d[1152-((36-0)*32) +: 32];
//		S2_d[1152-((36-19)*32) +: 32] = S2_d[1152-((36-19)*32) +: 32] ^ S2_d[1152-((36-0)*32) +: 32];
//		S2_d[1152-((36-27)*32) +: 32] = S2_d[1152-((36-27)*32) +: 32] ^ S2_d[1152-((36-0)*32) +: 32];
//		S2_d = { S2_d[863:0], S2_d[1151:864] };

		S2i[1152-((36- 9)*32) +: 32] <= S2[127:96];
		S2i[1152-((36-10)*32) +: 32] <= S2[95:64];
		S2i[1152-((36-11)*32) +: 32] <= S2[63:32];
		S2i[1152-((36-12)*32) +: 32] <= S2[31:0];
		S2i[1152-((36-13)*32) +: 32] <= S1ix[1152-((36- 4)*32) +: 32] ^ S2[127:96];
		S2i[1152-((36-19)*32) +: 32] <= S1ix[1152-((36-10)*32) +: 32] ^ S2[127:96];
		S2i[1152-((36-28)*32) +: 32] <= S1ix[1152-((36-19)*32) +: 32] ^ S2[127:96];
		S2i[1152-((36- 0)*32) +: 32] <= S1ix[1152-((36-27)*32) +: 32] ^ S2[127:96];
		S2i[1151-((36- 9)*32) : 1152-((36- 1)*32)] <= S1ix[1151-((36-36)*32) : 1152-((36-28)*32)];
		S2i[1151-((36-19)*32) : 1152-((36-14)*32)] <= S1ix[1151-((36-10)*32) : 1152-((36- 5)*32)];
		S2i[1151-((36-28)*32) : 1152-((36-20)*32)] <= S1ix[1151-((36-19)*32) : 1152-((36-11)*32)];
		S2i[1151-((36-36)*32) : 1152-((36-29)*32)] <= S1ix[1151-((36-27)*32) : 1152-((36-20)*32)];

		S2ix <= S2i;

//		S3_d = S2_q;
//		S3_d[31:0] = S3[127:96];
//		S3_d[63:32] = S3[95:64];
//		S3_d[95:64] = S3[63:32];
//		S3_d[127:96] = S3[31:0];
//
//		S3_d[1152-((36-4)*32) +: 32] = S3_d[1152-((36-4)*32) +: 32] ^ S3_d[1152-((36-0)*32) +: 32];
//		S3_d[1152-((36-10)*32) +: 32] = S3_d[1152-((36-10)*32) +: 32] ^ S3_d[1152-((36-0)*32) +: 32];
//		S3_d[1152-((36-19)*32) +: 32] = S3_d[1152-((36-19)*32) +: 32] ^ S3_d[1152-((36-0)*32) +: 32];
//		S3_d[1152-((36-28)*32) +: 32] = S3_d[1152-((36-28)*32) +: 32] ^ S3_d[1152-((36-0)*32) +: 32];
//		S3_d = { S3_d[895:0], S3_d[1151:896] };

//		S3i[1152-((36- 0)*32) +: 32] <= S3[127:96];
//		S3i[1152-((36- 1)*32) +: 32] <= S3[95:64];
//		S3i[1152-((36- 2)*32) +: 32] <= S3[63:32];
//		S3i[1152-((36- 3)*32) +: 32] <= S3[31:0];
//		S3i[1152-((36- 4)*32) +: 32] <= S2ix[1152-((36- 4)*32) +: 32] ^ S3[127:96];
//		S3i[1152-((36-10)*32) +: 32] <= S2ix[1152-((36-10)*32) +: 32] ^ S3[127:96];
//		S3i[1152-((36-19)*32) +: 32] <= S2ix[1152-((36-19)*32) +: 32] ^ S3[127:96];
//		S3i[1152-((36-28)*32) +: 32] <= S2ix[1152-((36-28)*32) +: 32] ^ S3[127:96];
//		S3i[1152-((36- 0)*32) +: 32] <= S2ix[1152-((36-27)*32) +: 32];
//		S3i[1151-((36- 9)*32) : 1152-((36- 2)*32)] <= S2ix[1151-((36-36)*32) : 1152-((36-29)*32)];
//		S3i[1151-((36-19)*32) : 1152-((36-14)*32)] <= S2ix[1151-((36-10)*32) : 1152-((36- 5)*32)];
//		S3i[1151-((36-28)*32) : 1152-((36-20)*32)] <= S2ix[1151-((36-19)*32) : 1152-((36-11)*32)];
//		S3i[1151-((36-36)*32) : 1152-((36-29)*32)] <= S2ix[1151-((36-27)*32) : 1152-((36-20)*32)];

		S3i[1152-((36- 9)*32) +: 32] <= S3[127:96];
		S3i[1152-((36-10)*32) +: 32] <= S3[95:64];
		S3i[1152-((36-11)*32) +: 32] <= S3[63:32];
		S3i[1152-((36-12)*32) +: 32] <= S3[31:0];
		S3i[1152-((36-13)*32) +: 32] <= S2ix[1152-((36- 4)*32) +: 32] ^ S3[127:96];
		S3i[1152-((36-19)*32) +: 32] <= S2ix[1152-((36-10)*32) +: 32] ^ S3[127:96];
		S3i[1152-((36-28)*32) +: 32] <= S2ix[1152-((36-19)*32) +: 32] ^ S3[127:96];
		S3i[1152-((36- 1)*32) +: 32] <= S2ix[1152-((36-28)*32) +: 32] ^ S3[127:96];
		S3i[1152-((36- 0)*32) +: 32] <= S2ix[1152-((36-27)*32) +: 32];
		S3i[1151-((36- 9)*32) : 1152-((36- 2)*32)] <= S2ix[1151-((36-36)*32) : 1152-((36-29)*32)];
		S3i[1151-((36-19)*32) : 1152-((36-14)*32)] <= S2ix[1151-((36-10)*32) : 1152-((36- 5)*32)];
		S3i[1151-((36-28)*32) : 1152-((36-20)*32)] <= S2ix[1151-((36-19)*32) : 1152-((36-11)*32)];
		S3i[1151-((36-36)*32) : 1152-((36-29)*32)] <= S2ix[1151-((36-27)*32) : 1152-((36-20)*32)];

		S3ix <= { S3i[31:0], S3i[1151:32] };

//		S4_d = S3_q;
//		S4_d[31:0] = S4[127:96];
//		S4_d[63:32] = S4[95:64];
//		S4_d[95:64] = S4[63:32];
//		S4_d[127:96] = S4[31:0];

		S4i[1152-((36- 0)*32) +: 32] <= S4[127:96];
		S4i[1152-((36- 1)*32) +: 32] <= S4[95:64];
		S4i[1152-((36- 2)*32) +: 32] <= S4[63:32];
		S4i[1152-((36- 3)*32) +: 32] <= S4[31:0];
		S4i[1151-((36-36)*32) : 1152-((36- 4)*32)] <= S3ix[1151-((36-36)*32) : 1152-((36- 4)*32)];

	end

endmodule


module Dadda_Multiplier_24bit_pipelined (
    input logic clk, rst, 
    input logic[23:0] in1, in2,
    output logic[47:0] out
);
//partial products
logic[23:0] pp[23:0];

genvar i,j;
generate
    for(i = 0; i < 24; i++) begin
        for(j = 0; j < 24; j++) begin
            assign pp[i][j] = in1[j] & in2[i]; 
        end
    end
endgenerate

//reduction tree stages
//stage 0 (height of 24) reduce to height of 19

//column 19
logic s0_c19_sum, s0_c19_carry;
half_adder s0_c19_adder0(.A(pp[0][19]), .B(pp[1][18]), .sum(s0_c19_sum), .cout(s0_c19_carry));

//column 20
logic s0_c20_sum[2], s0_c20_carry[2];
half_adder s0_c20_adder0(.A(pp[0][20]), .B(pp[1][19]), .sum(s0_c20_sum[0]), .cout(s0_c20_carry[0]));
full_adder s0_c20_adder1(.A(pp[2][18]), .B(pp[3][17]), .cin(pp[4][16]), .sum(s0_c20_sum[1]), .cout(s0_c20_carry[1]));

//column 21
logic s0_c21_sum[3], s0_c21_carry[3];
half_adder s0_c21_adder0(.A(pp[0][21]), .B(pp[1][20]), .sum(s0_c21_sum[0]), .cout(s0_c21_carry[0]));
full_adder s0_c21_adder1(.A(pp[2][19]), .B(pp[3][18]), .cin(pp[4][17]), .sum(s0_c21_sum[1]), .cout(s0_c21_carry[1]));
full_adder s0_c21_adder2(.A(pp[5][16]), .B(pp[6][15]), .cin(pp[7][14]), .sum(s0_c21_sum[2]), .cout(s0_c21_carry[2]));

//column 22
logic s0_c22_sum[4], s0_c22_carry[4];
half_adder s0_c22_adder0(.A(pp[0][22]), .B(pp[1][21]), .sum(s0_c22_sum[0]), .cout(s0_c22_carry[0]));
full_adder s0_c22_adder1(.A(pp[2][20]), .B(pp[3][19]), .cin(pp[4][18]), .sum(s0_c22_sum[1]), .cout(s0_c22_carry[1]));
full_adder s0_c22_adder2(.A(pp[5][17]), .B(pp[6][16]), .cin(pp[7][15]), .sum(s0_c22_sum[2]), .cout(s0_c22_carry[2]));
full_adder s0_c22_adder3(.A(pp[8][14]), .B(pp[9][13]), .cin(pp[10][12]), .sum(s0_c22_sum[3]), .cout(s0_c22_carry[3]));

//column 23
logic s0_c23_sum[5], s0_c23_carry[5];
half_adder s0_c23_adder0(.A(pp[0][23]), .B(pp[1][22]), .sum(s0_c23_sum[0]), .cout(s0_c23_carry[0]));
full_adder s0_c23_adder1(.A(pp[2][21]), .B(pp[3][20]), .cin(pp[4][19]), .sum(s0_c23_sum[1]), .cout(s0_c23_carry[1]));
full_adder s0_c23_adder2(.A(pp[5][18]), .B(pp[6][17]), .cin(pp[7][16]), .sum(s0_c23_sum[2]), .cout(s0_c23_carry[2]));
full_adder s0_c23_adder3(.A(pp[8][15]), .B(pp[9][14]), .cin(pp[10][13]), .sum(s0_c23_sum[3]), .cout(s0_c23_carry[3]));
full_adder s0_c23_adder4(.A(pp[11][12]), .B(pp[12][11]), .cin(pp[13][10]), .sum(s0_c23_sum[4]), .cout(s0_c23_carry[4]));

//column 24
logic s0_c24_sum[5], s0_c24_carry[5];
half_adder s0_c24_adder0(.A(pp[1][23]), .B(pp[2][22]), .sum(s0_c24_sum[0]), .cout(s0_c24_carry[0]));
full_adder s0_c24_adder1(.A(pp[3][21]), .B(pp[4][20]), .cin(pp[5][19]), .sum(s0_c24_sum[1]), .cout(s0_c24_carry[1]));
full_adder s0_c24_adder2(.A(pp[6][18]), .B(pp[7][17]), .cin(pp[8][16]), .sum(s0_c24_sum[2]), .cout(s0_c24_carry[2]));
full_adder s0_c24_adder3(.A(pp[9][15]), .B(pp[10][14]), .cin(pp[11][13]), .sum(s0_c24_sum[3]), .cout(s0_c24_carry[3]));
full_adder s0_c24_adder4(.A(pp[12][12]), .B(pp[13][11]), .cin(pp[14][10]), .sum(s0_c24_sum[4]), .cout(s0_c24_carry[4]));

//column 25
logic s0_c25_sum[4], s0_c25_carry[4];
full_adder s0_c25_adder0(.A(pp[2][23]), .B(pp[3][22]), .cin(pp[4][21]), .sum(s0_c25_sum[0]), .cout(s0_c25_carry[0]));
full_adder s0_c25_adder1(.A(pp[5][20]), .B(pp[6][19]), .cin(pp[7][18]), .sum(s0_c25_sum[1]), .cout(s0_c25_carry[1]));
full_adder s0_c25_adder2(.A(pp[8][17]), .B(pp[9][16]), .cin(pp[10][15]), .sum(s0_c25_sum[2]), .cout(s0_c25_carry[2]));
full_adder s0_c25_adder3(.A(pp[11][14]), .B(pp[12][13]), .cin(pp[13][12]), .sum(s0_c25_sum[3]), .cout(s0_c25_carry[3]));

//column 26
logic s0_c26_sum[3], s0_c26_carry[3];
full_adder s0_c26_adder0(.A(pp[3][23]), .B(pp[4][22]), .cin(pp[5][21]), .sum(s0_c26_sum[0]), .cout(s0_c26_carry[0]));
full_adder s0_c26_adder1(.A(pp[6][20]), .B(pp[7][19]), .cin(pp[8][18]), .sum(s0_c26_sum[1]), .cout(s0_c26_carry[1]));
full_adder s0_c26_adder2(.A(pp[9][17]), .B(pp[10][16]), .cin(pp[11][15]), .sum(s0_c26_sum[2]), .cout(s0_c26_carry[2]));

//column 27
logic s0_c27_sum[2], s0_c27_carry[2];
full_adder s0_c27_adder0(.A(pp[4][23]), .B(pp[5][22]), .cin(pp[6][21]), .sum(s0_c27_sum[0]), .cout(s0_c27_carry[0]));
full_adder s0_c27_adder1(.A(pp[7][20]), .B(pp[8][19]), .cin(pp[9][18]), .sum(s0_c27_sum[1]), .cout(s0_c27_carry[1]));

//column 28
logic s0_c28_sum, s0_c28_carry;
full_adder s0_c28_adder0(.A(pp[5][23]), .B(pp[6][22]), .cin(pp[7][21]), .sum(s0_c28_sum), .cout(s0_c28_carry));

//stage 1 reduce height to 13

//column 13
logic s1_c13_sum, s1_c13_carry;
half_adder s1_c13_adder0(.A(pp[0][13]), .B(pp[1][12]), .sum(s1_c13_sum), .cout(s1_c13_carry));

//column 14
logic s1_c14_sum[2], s1_c14_carry[2];
half_adder s1_c14_adder0(.A(pp[0][14]), .B(pp[1][13]), .sum(s1_c14_sum[0]), .cout(s1_c14_carry[0]));
full_adder s1_c14_adder1(.A(pp[2][12]), .B(pp[3][11]), .cin(pp[4][10]), .sum(s1_c14_sum[1]), .cout(s1_c14_carry[1]));

//column 15
logic s1_c15_sum[3], s1_c15_carry[3];
half_adder s1_c15_adder0(.A(pp[0][15]), .B(pp[1][14]), .sum(s1_c15_sum[0]), .cout(s1_c15_carry[0]));
full_adder s1_c15_adder1(.A(pp[2][13]), .B(pp[3][12]), .cin(pp[4][11]), .sum(s1_c15_sum[1]), .cout(s1_c15_carry[1]));
full_adder s1_c15_adder2(.A(pp[5][10]), .B(pp[6][9]), .cin(pp[7][8]), .sum(s1_c15_sum[2]), .cout(s1_c15_carry[2]));

//column 16
logic s1_c16_sum[4], s1_c16_carry[4];
half_adder s1_c16_adder0(.A(pp[0][16]), .B(pp[1][15]), .sum(s1_c16_sum[0]), .cout(s1_c16_carry[0]));
full_adder s1_c16_adder1(.A(pp[2][14]), .B(pp[3][13]), .cin(pp[4][12]), .sum(s1_c16_sum[1]), .cout(s1_c16_carry[1]));
full_adder s1_c16_adder2(.A(pp[5][11]), .B(pp[6][10]), .cin(pp[7][9]), .sum(s1_c16_sum[2]), .cout(s1_c16_carry[2]));
full_adder s1_c16_adder3(.A(pp[8][8]), .B(pp[9][7]), .cin(pp[10][6]), .sum(s1_c16_sum[3]), .cout(s1_c16_carry[3]));

//column 17
logic s1_c17_sum[5], s1_c17_carry[5];
half_adder s1_c17_adder0(.A(pp[0][17]), .B(pp[1][16]), .sum(s1_c17_sum[0]), .cout(s1_c17_carry[0]));
full_adder s1_c17_adder1(.A(pp[2][15]), .B(pp[3][14]), .cin(pp[4][13]), .sum(s1_c17_sum[1]), .cout(s1_c17_carry[1]));
full_adder s1_c17_adder2(.A(pp[5][12]), .B(pp[6][11]), .cin(pp[7][10]), .sum(s1_c17_sum[2]), .cout(s1_c17_carry[2]));
full_adder s1_c17_adder3(.A(pp[8][9]), .B(pp[9][8]), .cin(pp[10][7]), .sum(s1_c17_sum[3]), .cout(s1_c17_carry[3]));
full_adder s1_c17_adder4(.A(pp[11][6]), .B(pp[12][5]), .cin(pp[13][4]), .sum(s1_c17_sum[4]), .cout(s1_c17_carry[4]));

//column 18
logic s1_c18_sum[6], s1_c18_carry[6];
half_adder s1_c18_adder0(.A(pp[0][18]), .B(pp[1][17]), .sum(s1_c18_sum[0]), .cout(s1_c18_carry[0]));
full_adder s1_c18_adder1(.A(pp[2][16]), .B(pp[3][15]), .cin(pp[4][14]), .sum(s1_c18_sum[1]), .cout(s1_c18_carry[1]));
full_adder s1_c18_adder2(.A(pp[5][13]), .B(pp[6][12]), .cin(pp[7][11]), .sum(s1_c18_sum[2]), .cout(s1_c18_carry[2]));
full_adder s1_c18_adder3(.A(pp[8][10]), .B(pp[9][9]), .cin(pp[10][8]), .sum(s1_c18_sum[3]), .cout(s1_c18_carry[3]));
full_adder s1_c18_adder4(.A(pp[11][7]), .B(pp[12][6]), .cin(pp[13][5]), .sum(s1_c18_sum[4]), .cout(s1_c18_carry[4]));
full_adder s1_c18_adder5(.A(pp[14][4]), .B(pp[15][3]), .cin(pp[16][2]), .sum(s1_c18_sum[5]), .cout(s1_c18_carry[5]));

//column 19
logic s1_c19_sum[6], s1_c19_carry[6];
full_adder s1_c19_adder0(.A(s0_c19_sum), .B(pp[2][17]), .cin(pp[3][16]), .sum(s1_c19_sum[0]), .cout(s1_c19_carry[0]));
full_adder s1_c19_adder1(.A(pp[4][15]), .B(pp[5][14]), .cin(pp[6][13]), .sum(s1_c19_sum[1]), .cout(s1_c19_carry[1]));
full_adder s1_c19_adder2(.A(pp[7][12]), .B(pp[8][11]), .cin(pp[9][10]), .sum(s1_c19_sum[2]), .cout(s1_c19_carry[2]));
full_adder s1_c19_adder3(.A(pp[10][9]), .B(pp[11][8]), .cin(pp[12][7]), .sum(s1_c19_sum[3]), .cout(s1_c19_carry[3]));
full_adder s1_c19_adder4(.A(pp[13][6]), .B(pp[14][5]), .cin(pp[15][4]), .sum(s1_c19_sum[4]), .cout(s1_c19_carry[4]));
full_adder s1_c19_adder5(.A(pp[16][3]), .B(pp[17][2]), .cin(pp[18][1]), .sum(s1_c19_sum[5]), .cout(s1_c19_carry[5]));

//column 20
logic s1_c20_sum[6], s1_c20_carry[6];
full_adder s1_c20_adder0(.A(s0_c19_carry), .B(s0_c20_sum[0]), .cin(s0_c20_sum[1]), .sum(s1_c20_sum[0]), .cout(s1_c20_carry[0]));
full_adder s1_c20_adder1(.A(pp[5][15]), .B(pp[6][14]), .cin(pp[7][13]), .sum(s1_c20_sum[1]), .cout(s1_c20_carry[1]));
full_adder s1_c20_adder2(.A(pp[8][12]), .B(pp[9][11]), .cin(pp[10][10]), .sum(s1_c20_sum[2]), .cout(s1_c20_carry[2]));
full_adder s1_c20_adder3(.A(pp[11][9]), .B(pp[12][8]), .cin(pp[13][7]), .sum(s1_c20_sum[3]), .cout(s1_c20_carry[3]));
full_adder s1_c20_adder4(.A(pp[14][6]), .B(pp[15][5]), .cin(pp[16][4]), .sum(s1_c20_sum[4]), .cout(s1_c20_carry[4]));
full_adder s1_c20_adder5(.A(pp[17][3]), .B(pp[18][2]), .cin(pp[19][1]), .sum(s1_c20_sum[5]), .cout(s1_c20_carry[5]));

//column 21
logic s1_c21_sum[6], s1_c21_carry[6];
full_adder s1_c21_adder0(.A(s0_c20_carry[0]), .B(s0_c20_carry[1]), .cin(s0_c21_sum[0]), .sum(s1_c21_sum[0]), .cout(s1_c21_carry[0]));
full_adder s1_c21_adder1(.A(s0_c21_sum[1]), .B(s0_c21_sum[2]), .cin(pp[8][13]), .sum(s1_c21_sum[1]), .cout(s1_c21_carry[1]));
full_adder s1_c21_adder2(.A(pp[9][12]), .B(pp[10][11]), .cin(pp[11][10]), .sum(s1_c21_sum[2]), .cout(s1_c21_carry[2]));
full_adder s1_c21_adder3(.A(pp[12][9]), .B(pp[13][8]), .cin(pp[14][7]), .sum(s1_c21_sum[3]), .cout(s1_c21_carry[3]));
full_adder s1_c21_adder4(.A(pp[15][6]), .B(pp[16][5]), .cin(pp[17][4]), .sum(s1_c21_sum[4]), .cout(s1_c21_carry[4]));
full_adder s1_c21_adder5(.A(pp[18][3]), .B(pp[19][2]), .cin(pp[20][1]), .sum(s1_c21_sum[5]), .cout(s1_c21_carry[5]));

//column 22
logic s1_c22_sum[6], s1_c22_carry[6];
full_adder s1_c22_adder0(.A(s0_c21_carry[0]), .B(s0_c21_carry[1]), .cin(s0_c21_carry[2]), .sum(s1_c22_sum[0]), .cout(s1_c22_carry[0]));
full_adder s1_c22_adder1(.A(s0_c22_sum[0]), .B(s0_c22_sum[1]), .cin(s0_c22_sum[2]), .sum(s1_c22_sum[1]), .cout(s1_c22_carry[1]));
full_adder s1_c22_adder2(.A(s0_c22_sum[3]), .B(pp[11][11]), .cin(pp[12][10]), .sum(s1_c22_sum[2]), .cout(s1_c22_carry[2]));
full_adder s1_c22_adder3(.A(pp[13][9]), .B(pp[14][8]), .cin(pp[15][7]), .sum(s1_c22_sum[3]), .cout(s1_c22_carry[3]));
full_adder s1_c22_adder4(.A(pp[16][6]), .B(pp[17][5]), .cin(pp[18][4]), .sum(s1_c22_sum[4]), .cout(s1_c22_carry[4]));
full_adder s1_c22_adder5(.A(pp[19][3]), .B(pp[20][2]), .cin(pp[21][1]), .sum(s1_c22_sum[5]), .cout(s1_c22_carry[5]));

//column 23
logic s1_c23_sum[6], s1_c23_carry[6];
full_adder s1_c23_adder0(.A(s0_c22_carry[0]), .B(s0_c22_carry[1]), .cin(s0_c22_carry[2]), .sum(s1_c23_sum[0]), .cout(s1_c23_carry[0]));
full_adder s1_c23_adder1(.A(s0_c22_carry[3]), .B(s0_c23_sum[0]), .cin(s0_c23_sum[1]), .sum(s1_c23_sum[1]), .cout(s1_c23_carry[1]));
full_adder s1_c23_adder2(.A(s0_c23_sum[2]), .B(s0_c23_sum[3]), .cin(s0_c23_sum[4]), .sum(s1_c23_sum[2]), .cout(s1_c23_carry[2]));
full_adder s1_c23_adder3(.A(pp[14][9]), .B(pp[15][8]), .cin(pp[16][7]), .sum(s1_c23_sum[3]), .cout(s1_c23_carry[3]));
full_adder s1_c23_adder4(.A(pp[17][6]), .B(pp[18][5]), .cin(pp[19][4]), .sum(s1_c23_sum[4]), .cout(s1_c23_carry[4]));
full_adder s1_c23_adder5(.A(pp[20][3]), .B(pp[21][2]), .cin(pp[22][1]), .sum(s1_c23_sum[5]), .cout(s1_c23_carry[5]));

//column 24
logic s1_c24_sum[6], s1_c24_carry[6];
full_adder s1_c24_adder0(.A(s0_c23_carry[0]), .B(s0_c23_carry[1]), .cin(s0_c23_carry[2]), .sum(s1_c24_sum[0]), .cout(s1_c24_carry[0]));
full_adder s1_c24_adder1(.A(s0_c23_carry[3]), .B(s0_c23_carry[4]), .cin(s0_c24_sum[0]), .sum(s1_c24_sum[1]), .cout(s1_c24_carry[1]));
full_adder s1_c24_adder2(.A(s0_c24_sum[1]), .B(s0_c24_sum[2]), .cin(s0_c24_sum[3]), .sum(s1_c24_sum[2]), .cout(s1_c24_carry[2]));
full_adder s1_c24_adder3(.A(s0_c24_sum[4]), .B(pp[15][9]), .cin(pp[16][8]), .sum(s1_c24_sum[3]), .cout(s1_c24_carry[3]));
full_adder s1_c24_adder4(.A(pp[17][7]), .B(pp[18][6]), .cin(pp[19][5]), .sum(s1_c24_sum[4]), .cout(s1_c24_carry[4]));
full_adder s1_c24_adder5(.A(pp[20][4]), .B(pp[21][3]), .cin(pp[22][2]), .sum(s1_c24_sum[5]), .cout(s1_c24_carry[5]));

//column 25
logic s1_c25_sum[6], s1_c25_carry[6];
full_adder s1_c25_adder0(.A(s0_c24_carry[0]), .B(s0_c24_carry[1]), .cin(s0_c24_carry[2]), .sum(s1_c25_sum[0]), .cout(s1_c25_carry[0]));
full_adder s1_c25_adder1(.A(s0_c24_carry[3]), .B(s0_c24_carry[4]), .cin(s0_c25_sum[0]), .sum(s1_c25_sum[1]), .cout(s1_c25_carry[1]));
full_adder s1_c25_adder2(.A(s0_c25_sum[1]), .B(s0_c25_sum[2]), .cin(s0_c25_sum[3]), .sum(s1_c25_sum[2]), .cout(s1_c25_carry[2]));
full_adder s1_c25_adder3(.A(pp[14][11]), .B(pp[15][10]), .cin(pp[16][9]), .sum(s1_c25_sum[3]), .cout(s1_c25_carry[3]));
full_adder s1_c25_adder4(.A(pp[17][8]), .B(pp[18][7]), .cin(pp[19][6]), .sum(s1_c25_sum[4]), .cout(s1_c25_carry[4]));
full_adder s1_c25_adder5(.A(pp[20][5]), .B(pp[21][4]), .cin(pp[22][3]), .sum(s1_c25_sum[5]), .cout(s1_c25_carry[5]));

//column 26
logic s1_c26_sum[6], s1_c26_carry[6];
full_adder s1_c26_adder0(.A(s0_c25_carry[0]), .B(s0_c25_carry[1]), .cin(s0_c25_carry[2]), .sum(s1_c26_sum[0]), .cout(s1_c26_carry[0]));
full_adder s1_c26_adder1(.A(s0_c25_carry[3]), .B(s0_c26_sum[0]), .cin(s0_c26_sum[1]), .sum(s1_c26_sum[1]), .cout(s1_c26_carry[1]));
full_adder s1_c26_adder2(.A(s0_c26_sum[2]), .B(pp[12][14]), .cin(pp[13][13]), .sum(s1_c26_sum[2]), .cout(s1_c26_carry[2]));
full_adder s1_c26_adder3(.A(pp[14][12]), .B(pp[15][11]), .cin(pp[16][10]), .sum(s1_c26_sum[3]), .cout(s1_c26_carry[3]));
full_adder s1_c26_adder4(.A(pp[17][9]), .B(pp[18][8]), .cin(pp[19][7]), .sum(s1_c26_sum[4]), .cout(s1_c26_carry[4]));
full_adder s1_c26_adder5(.A(pp[20][6]), .B(pp[21][5]), .cin(pp[22][4]), .sum(s1_c26_sum[5]), .cout(s1_c26_carry[5]));

//column 27
logic s1_c27_sum[6], s1_c27_carry[6];
full_adder s1_c27_adder0(.A(s0_c26_carry[0]), .B(s0_c26_carry[1]), .cin(s0_c26_carry[2]), .sum(s1_c27_sum[0]), .cout(s1_c27_carry[0]));
full_adder s1_c27_adder1(.A(s0_c27_sum[0]), .B(s0_c27_sum[1]), .cin(pp[10][17]), .sum(s1_c27_sum[1]), .cout(s1_c27_carry[1]));
full_adder s1_c27_adder2(.A(pp[11][16]), .B(pp[12][15]), .cin(pp[13][14]), .sum(s1_c27_sum[2]), .cout(s1_c27_carry[2]));
full_adder s1_c27_adder3(.A(pp[14][13]), .B(pp[15][12]), .cin(pp[16][11]), .sum(s1_c27_sum[3]), .cout(s1_c27_carry[3]));
full_adder s1_c27_adder4(.A(pp[17][10]), .B(pp[18][9]), .cin(pp[19][8]), .sum(s1_c27_sum[4]), .cout(s1_c27_carry[4]));
full_adder s1_c27_adder5(.A(pp[20][7]), .B(pp[21][6]), .cin(pp[22][5]), .sum(s1_c27_sum[5]), .cout(s1_c27_carry[5]));

//column 28
logic s1_c28_sum[6], s1_c28_carry[6];
full_adder s1_c28_adder0(.A(s0_c27_carry[0]), .B(s0_c27_carry[1]), .cin(s0_c28_sum), .sum(s1_c28_sum[0]), .cout(s1_c28_carry[0]));
full_adder s1_c28_adder1(.A(pp[8][20]), .B(pp[9][19]), .cin(pp[10][18]), .sum(s1_c28_sum[1]), .cout(s1_c28_carry[1]));
full_adder s1_c28_adder2(.A(pp[11][17]), .B(pp[12][16]), .cin(pp[13][15]), .sum(s1_c28_sum[2]), .cout(s1_c28_carry[2]));
full_adder s1_c28_adder3(.A(pp[14][14]), .B(pp[15][13]), .cin(pp[16][12]), .sum(s1_c28_sum[3]), .cout(s1_c28_carry[3]));
full_adder s1_c28_adder4(.A(pp[17][11]), .B(pp[18][10]), .cin(pp[19][9]), .sum(s1_c28_sum[4]), .cout(s1_c28_carry[4]));
full_adder s1_c28_adder5(.A(pp[20][8]), .B(pp[21][7]), .cin(pp[22][6]), .sum(s1_c28_sum[5]), .cout(s1_c28_carry[5]));

//column 29
logic s1_c29_sum[6], s1_c29_carry[6];
full_adder s1_c29_adder0(.A(s0_c28_carry), .B(pp[6][23]), .cin(pp[7][22]), .sum(s1_c29_sum[0]), .cout(s1_c29_carry[0]));
full_adder s1_c29_adder1(.A(pp[8][21]), .B(pp[9][20]), .cin(pp[10][19]), .sum(s1_c29_sum[1]), .cout(s1_c29_carry[1]));
full_adder s1_c29_adder2(.A(pp[11][18]), .B(pp[12][17]), .cin(pp[13][16]), .sum(s1_c29_sum[2]), .cout(s1_c29_carry[2]));
full_adder s1_c29_adder3(.A(pp[14][15]), .B(pp[15][14]), .cin(pp[16][13]), .sum(s1_c29_sum[3]), .cout(s1_c29_carry[3]));
full_adder s1_c29_adder4(.A(pp[17][12]), .B(pp[18][11]), .cin(pp[19][10]), .sum(s1_c29_sum[4]), .cout(s1_c29_carry[4]));
full_adder s1_c29_adder5(.A(pp[20][9]), .B(pp[21][8]), .cin(pp[22][7]), .sum(s1_c29_sum[5]), .cout(s1_c29_carry[5]));

//column 30
logic s1_c30_sum[5], s1_c30_carry[5];
full_adder s1_c30_adder0(.A(pp[21][9]), .B(pp[7][23]), .cin(pp[8][22]), .sum(s1_c30_sum[0]), .cout(s1_c30_carry[0]));
full_adder s1_c30_adder1(.A(pp[9][21]), .B(pp[10][20]), .cin(pp[11][19]), .sum(s1_c30_sum[1]), .cout(s1_c30_carry[1]));
full_adder s1_c30_adder2(.A(pp[12][18]), .B(pp[13][17]), .cin(pp[14][16]), .sum(s1_c30_sum[2]), .cout(s1_c30_carry[2]));
full_adder s1_c30_adder3(.A(pp[15][15]), .B(pp[16][14]), .cin(pp[17][13]), .sum(s1_c30_sum[3]), .cout(s1_c30_carry[3]));
full_adder s1_c30_adder4(.A(pp[18][12]), .B(pp[19][11]), .cin(pp[20][10]), .sum(s1_c30_sum[4]), .cout(s1_c30_carry[4]));

//column 31
logic s1_c31_sum[4], s1_c31_carry[4];
full_adder s1_c31_adder0(.A(pp[19][12]), .B(pp[8][23]), .cin(pp[9][22]), .sum(s1_c31_sum[0]), .cout(s1_c31_carry[0]));
full_adder s1_c31_adder1(.A(pp[10][21]), .B(pp[11][20]), .cin(pp[12][19]), .sum(s1_c31_sum[1]), .cout(s1_c31_carry[1]));
full_adder s1_c31_adder2(.A(pp[13][18]), .B(pp[14][17]), .cin(pp[15][16]), .sum(s1_c31_sum[2]), .cout(s1_c31_carry[2]));
full_adder s1_c31_adder3(.A(pp[16][15]), .B(pp[17][14]), .cin(pp[18][13]), .sum(s1_c31_sum[3]), .cout(s1_c31_carry[3]));

//column 32
logic s1_c32_sum[3], s1_c32_carry[3];
full_adder s1_c32_adder0(.A(pp[17][15]), .B(pp[9][23]), .cin(pp[10][22]), .sum(s1_c32_sum[0]), .cout(s1_c32_carry[0]));
full_adder s1_c32_adder1(.A(pp[11][21]), .B(pp[12][20]), .cin(pp[13][19]), .sum(s1_c32_sum[1]), .cout(s1_c32_carry[1]));
full_adder s1_c32_adder2(.A(pp[14][18]), .B(pp[15][17]), .cin(pp[16][16]), .sum(s1_c32_sum[2]), .cout(s1_c32_carry[2]));

//column 33
logic s1_c33_sum[2], s1_c33_carry[2];
full_adder s1_c33_adder0(.A(pp[15][18]), .B(pp[10][23]), .cin(pp[11][22]), .sum(s1_c33_sum[0]), .cout(s1_c33_carry[0]));
full_adder s1_c33_adder1(.A(pp[12][21]), .B(pp[13][20]), .cin(pp[14][19]), .sum(s1_c33_sum[1]), .cout(s1_c33_carry[1]));

//column 34
logic s1_c34_sum, s1_c34_carry;
full_adder s1_c34_adder0(.A(pp[11][23]), .B(pp[12][22]), .cin(pp[13][21]), .sum(s1_c34_sum), .cout(s1_c34_carry));

//stage 2 reduce height to 9

//column 9
logic s2_c9_sum, s2_c9_carry;
half_adder s2_c9_adder0(.A(pp[0][9]), .B(pp[1][8]), .sum(s2_c9_sum), .cout(s2_c9_carry));

//column 10
logic s2_c10_sum[2], s2_c10_carry[2];
half_adder s2_c10_adder0(.A(pp[0][10]), .B(pp[1][9]), .sum(s2_c10_sum[0]), .cout(s2_c10_carry[0]));
full_adder s2_c10_adder1(.A(pp[2][8]), .B(pp[3][7]), .cin(pp[4][6]), .sum(s2_c10_sum[1]), .cout(s2_c10_carry[1]));

//column 11
logic s2_c11_sum[3], s2_c11_carry[3];
half_adder s2_c11_adder0(.A(pp[0][11]), .B(pp[1][10]), .sum(s2_c11_sum[0]), .cout(s2_c11_carry[0]));
full_adder s2_c11_adder1(.A(pp[2][9]), .B(pp[3][8]), .cin(pp[4][7]), .sum(s2_c11_sum[1]), .cout(s2_c11_carry[1]));
full_adder s2_c11_adder2(.A(pp[5][6]), .B(pp[6][5]), .cin(pp[7][4]), .sum(s2_c11_sum[2]), .cout(s2_c11_carry[2]));

//column 12
logic s2_c12_sum[4], s2_c12_carry[4];
half_adder s2_c12_adder0(.A(pp[0][12]), .B(pp[1][11]), .sum(s2_c12_sum[0]), .cout(s2_c12_carry[0]));
full_adder s2_c12_adder1(.A(pp[2][10]), .B(pp[3][9]), .cin(pp[4][8]), .sum(s2_c12_sum[1]), .cout(s2_c12_carry[1]));
full_adder s2_c12_adder2(.A(pp[5][7]), .B(pp[6][6]), .cin(pp[7][5]), .sum(s2_c12_sum[2]), .cout(s2_c12_carry[2]));
full_adder s2_c12_adder3(.A(pp[8][4]), .B(pp[9][3]), .cin(pp[10][2]), .sum(s2_c12_sum[3]), .cout(s2_c12_carry[3]));

//column 13
logic s2_c13_sum[4], s2_c13_carry[4];
full_adder s2_c13_adder0(.A(s1_c13_sum), .B(pp[11][2]), .cin(pp[12][1]), .sum(s2_c13_sum[0]), .cout(s2_c13_carry[0]));
full_adder s2_c13_adder1(.A(pp[2][11]), .B(pp[3][10]), .cin(pp[4][9]), .sum(s2_c13_sum[1]), .cout(s2_c13_carry[1]));
full_adder s2_c13_adder2(.A(pp[5][8]), .B(pp[6][7]), .cin(pp[7][6]), .sum(s2_c13_sum[2]), .cout(s2_c13_carry[2]));
full_adder s2_c13_adder3(.A(pp[8][5]), .B(pp[9][4]), .cin(pp[10][3]), .sum(s2_c13_sum[3]), .cout(s2_c13_carry[3]));

//column 14
logic s2_c14_sum[4], s2_c14_carry[4];
full_adder s2_c14_adder0(.A(s1_c13_carry), .B(s1_c14_sum[0]), .cin(s1_c14_sum[1]), .sum(s2_c14_sum[0]), .cout(s2_c14_carry[0]));
full_adder s2_c14_adder1(.A(pp[5][9]), .B(pp[6][8]), .cin(pp[7][7]), .sum(s2_c14_sum[1]), .cout(s2_c14_carry[1]));
full_adder s2_c14_adder2(.A(pp[8][6]), .B(pp[9][5]), .cin(pp[10][4]), .sum(s2_c14_sum[2]), .cout(s2_c14_carry[2]));
full_adder s2_c14_adder3(.A(pp[11][3]), .B(pp[12][2]), .cin(pp[13][1]), .sum(s2_c14_sum[3]), .cout(s2_c14_carry[3]));

//column 15
logic s2_c15_sum[4], s2_c15_carry[4];
full_adder s2_c15_adder0(.A(s1_c14_carry[0]), .B(s1_c14_carry[1]), .cin(s1_c15_sum[0]), .sum(s2_c15_sum[0]), .cout(s2_c15_carry[0]));
full_adder s2_c15_adder1(.A(s1_c15_sum[1]), .B(s1_c15_sum[2]), .cin(pp[8][7]), .sum(s2_c15_sum[1]), .cout(s2_c15_carry[1]));
full_adder s2_c15_adder2(.A(pp[9][6]), .B(pp[10][5]), .cin(pp[11][4]), .sum(s2_c15_sum[2]), .cout(s2_c15_carry[2]));
full_adder s2_c15_adder3(.A(pp[12][3]), .B(pp[13][2]), .cin(pp[14][1]), .sum(s2_c15_sum[3]), .cout(s2_c15_carry[3]));

//column 16
logic s2_c16_sum[4], s2_c16_carry[4];
full_adder s2_c16_adder0(.A(s1_c15_carry[0]), .B(s1_c15_carry[1]), .cin(s1_c15_carry[2]), .sum(s2_c16_sum[0]), .cout(s2_c16_carry[0]));
full_adder s2_c16_adder1(.A(s1_c16_sum[0]), .B(s1_c16_sum[1]), .cin(s1_c16_sum[2]), .sum(s2_c16_sum[1]), .cout(s2_c16_carry[1]));
full_adder s2_c16_adder2(.A(s1_c16_sum[3]), .B(pp[11][5]), .cin(pp[12][4]), .sum(s2_c16_sum[2]), .cout(s2_c16_carry[2]));
full_adder s2_c16_adder3(.A(pp[13][3]), .B(pp[14][2]), .cin(pp[15][1]), .sum(s2_c16_sum[3]), .cout(s2_c16_carry[3]));

//column 17
logic s2_c17_sum[4], s2_c17_carry[4];
full_adder s2_c17_adder0(.A(s1_c16_carry[0]), .B(s1_c16_carry[1]), .cin(s1_c16_carry[2]), .sum(s2_c17_sum[0]), .cout(s2_c17_carry[0]));
full_adder s2_c17_adder1(.A(s1_c16_carry[3]), .B(s1_c17_sum[0]), .cin(s1_c17_sum[1]), .sum(s2_c17_sum[1]), .cout(s2_c17_carry[1]));
full_adder s2_c17_adder2(.A(s1_c17_sum[2]), .B(s1_c17_sum[3]), .cin(s1_c17_sum[4]), .sum(s2_c17_sum[2]), .cout(s2_c17_carry[2]));
full_adder s2_c17_adder3(.A(pp[14][3]), .B(pp[15][2]), .cin(pp[16][1]), .sum(s2_c17_sum[3]), .cout(s2_c17_carry[3]));

//column 18
logic s2_c18_sum[4], s2_c18_carry[4];
full_adder s2_c18_adder0(.A(s1_c17_carry[0]), .B(s1_c17_carry[1]), .cin(s1_c17_carry[2]), .sum(s2_c18_sum[0]), .cout(s2_c18_carry[0]));
full_adder s2_c18_adder1(.A(s1_c17_carry[3]), .B(s1_c17_carry[4]), .cin(s1_c18_sum[0]), .sum(s2_c18_sum[1]), .cout(s2_c18_carry[1]));
full_adder s2_c18_adder2(.A(s1_c18_sum[1]), .B(s1_c18_sum[2]), .cin(s1_c18_sum[3]), .sum(s2_c18_sum[2]), .cout(s2_c18_carry[2]));
full_adder s2_c18_adder3(.A(s1_c18_sum[4]), .B(s1_c18_sum[5]), .cin(pp[17][1]), .sum(s2_c18_sum[3]), .cout(s2_c18_carry[3]));

//column 19
logic s2_c19_sum[4], s2_c19_carry[4];
full_adder s2_c19_adder0(.A(s1_c18_carry[0]), .B(s1_c18_carry[1]), .cin(s1_c18_carry[2]), .sum(s2_c19_sum[0]), .cout(s2_c19_carry[0]));
full_adder s2_c19_adder1(.A(s1_c18_carry[3]), .B(s1_c18_carry[4]), .cin(s1_c18_carry[5]), .sum(s2_c19_sum[1]), .cout(s2_c19_carry[1]));
full_adder s2_c19_adder2(.A(s1_c19_sum[0]), .B(s1_c19_sum[1]), .cin(s1_c19_sum[2]), .sum(s2_c19_sum[2]), .cout(s2_c19_carry[2]));
full_adder s2_c19_adder3(.A(s1_c19_sum[3]), .B(s1_c19_sum[4]), .cin(s1_c19_sum[5]), .sum(s2_c19_sum[3]), .cout(s2_c19_carry[3]));

//column 20
logic s2_c20_sum[4], s2_c20_carry[4];
full_adder s2_c20_adder0(.A(s1_c19_carry[0]), .B(s1_c19_carry[1]), .cin(s1_c19_carry[2]), .sum(s2_c20_sum[0]), .cout(s2_c20_carry[0]));
full_adder s2_c20_adder1(.A(s1_c19_carry[3]), .B(s1_c19_carry[4]), .cin(s1_c19_carry[5]), .sum(s2_c20_sum[1]), .cout(s2_c20_carry[1]));
full_adder s2_c20_adder2(.A(s1_c20_sum[0]), .B(s1_c20_sum[1]), .cin(s1_c20_sum[2]), .sum(s2_c20_sum[2]), .cout(s2_c20_carry[2]));
full_adder s2_c20_adder3(.A(s1_c20_sum[3]), .B(s1_c20_sum[4]), .cin(s1_c20_sum[5]), .sum(s2_c20_sum[3]), .cout(s2_c20_carry[3]));

//column 21
logic s2_c21_sum[4], s2_c21_carry[4];
full_adder s2_c21_adder0(.A(s1_c20_carry[0]), .B(s1_c20_carry[1]), .cin(s1_c20_carry[2]), .sum(s2_c21_sum[0]), .cout(s2_c21_carry[0]));
full_adder s2_c21_adder1(.A(s1_c20_carry[3]), .B(s1_c20_carry[4]), .cin(s1_c20_carry[5]), .sum(s2_c21_sum[1]), .cout(s2_c21_carry[1]));
full_adder s2_c21_adder2(.A(s1_c21_sum[0]), .B(s1_c21_sum[1]), .cin(s1_c21_sum[2]), .sum(s2_c21_sum[2]), .cout(s2_c21_carry[2]));
full_adder s2_c21_adder3(.A(s1_c21_sum[3]), .B(s1_c21_sum[4]), .cin(s1_c21_sum[5]), .sum(s2_c21_sum[3]), .cout(s2_c21_carry[3]));

//column 22
logic s2_c22_sum[4], s2_c22_carry[4];
full_adder s2_c22_adder0(.A(s1_c21_carry[0]), .B(s1_c21_carry[1]), .cin(s1_c21_carry[2]), .sum(s2_c22_sum[0]), .cout(s2_c22_carry[0]));
full_adder s2_c22_adder1(.A(s1_c21_carry[3]), .B(s1_c21_carry[4]), .cin(s1_c21_carry[5]), .sum(s2_c22_sum[1]), .cout(s2_c22_carry[1]));
full_adder s2_c22_adder2(.A(s1_c22_sum[0]), .B(s1_c22_sum[1]), .cin(s1_c22_sum[2]), .sum(s2_c22_sum[2]), .cout(s2_c22_carry[2]));
full_adder s2_c22_adder3(.A(s1_c22_sum[3]), .B(s1_c22_sum[4]), .cin(s1_c22_sum[5]), .sum(s2_c22_sum[3]), .cout(s2_c22_carry[3]));

//column 23
logic s2_c23_sum[4], s2_c23_carry[4];
full_adder s2_c23_adder0(.A(s1_c22_carry[0]), .B(s1_c22_carry[1]), .cin(s1_c22_carry[2]), .sum(s2_c23_sum[0]), .cout(s2_c23_carry[0]));
full_adder s2_c23_adder1(.A(s1_c22_carry[3]), .B(s1_c22_carry[4]), .cin(s1_c22_carry[5]), .sum(s2_c23_sum[1]), .cout(s2_c23_carry[1]));
full_adder s2_c23_adder2(.A(s1_c23_sum[0]), .B(s1_c23_sum[1]), .cin(s1_c23_sum[2]), .sum(s2_c23_sum[2]), .cout(s2_c23_carry[2]));
full_adder s2_c23_adder3(.A(s1_c23_sum[3]), .B(s1_c23_sum[4]), .cin(s1_c23_sum[5]), .sum(s2_c23_sum[3]), .cout(s2_c23_carry[3]));

//column 24
logic s2_c24_sum[4], s2_c24_carry[4];
full_adder s2_c24_adder0(.A(s1_c23_carry[0]), .B(s1_c23_carry[1]), .cin(s1_c23_carry[2]), .sum(s2_c24_sum[0]), .cout(s2_c24_carry[0]));
full_adder s2_c24_adder1(.A(s1_c23_carry[3]), .B(s1_c23_carry[4]), .cin(s1_c23_carry[5]), .sum(s2_c24_sum[1]), .cout(s2_c24_carry[1]));
full_adder s2_c24_adder2(.A(s1_c24_sum[0]), .B(s1_c24_sum[1]), .cin(s1_c24_sum[2]), .sum(s2_c24_sum[2]), .cout(s2_c24_carry[2]));
full_adder s2_c24_adder3(.A(s1_c24_sum[3]), .B(s1_c24_sum[4]), .cin(s1_c24_sum[5]), .sum(s2_c24_sum[3]), .cout(s2_c24_carry[3]));

//column 25
logic s2_c25_sum[4], s2_c25_carry[4];
full_adder s2_c25_adder0(.A(s1_c24_carry[0]), .B(s1_c24_carry[1]), .cin(s1_c24_carry[2]), .sum(s2_c25_sum[0]), .cout(s2_c25_carry[0]));
full_adder s2_c25_adder1(.A(s1_c24_carry[3]), .B(s1_c24_carry[4]), .cin(s1_c24_carry[5]), .sum(s2_c25_sum[1]), .cout(s2_c25_carry[1]));
full_adder s2_c25_adder2(.A(s1_c25_sum[0]), .B(s1_c25_sum[1]), .cin(s1_c25_sum[2]), .sum(s2_c25_sum[2]), .cout(s2_c25_carry[2]));
full_adder s2_c25_adder3(.A(s1_c25_sum[3]), .B(s1_c25_sum[4]), .cin(s1_c25_sum[5]), .sum(s2_c25_sum[3]), .cout(s2_c25_carry[3]));

//column 26
logic s2_c26_sum[4], s2_c26_carry[4];
full_adder s2_c26_adder0(.A(s1_c25_carry[0]), .B(s1_c25_carry[1]), .cin(s1_c25_carry[2]), .sum(s2_c26_sum[0]), .cout(s2_c26_carry[0]));
full_adder s2_c26_adder1(.A(s1_c25_carry[3]), .B(s1_c25_carry[4]), .cin(s1_c25_carry[5]), .sum(s2_c26_sum[1]), .cout(s2_c26_carry[1]));
full_adder s2_c26_adder2(.A(s1_c26_sum[0]), .B(s1_c26_sum[1]), .cin(s1_c26_sum[2]), .sum(s2_c26_sum[2]), .cout(s2_c26_carry[2]));
full_adder s2_c26_adder3(.A(s1_c26_sum[3]), .B(s1_c26_sum[4]), .cin(s1_c26_sum[5]), .sum(s2_c26_sum[3]), .cout(s2_c26_carry[3]));

//column 27
logic s2_c27_sum[4], s2_c27_carry[4];
full_adder s2_c27_adder0(.A(s1_c26_carry[0]), .B(s1_c26_carry[1]), .cin(s1_c26_carry[2]), .sum(s2_c27_sum[0]), .cout(s2_c27_carry[0]));
full_adder s2_c27_adder1(.A(s1_c26_carry[3]), .B(s1_c26_carry[4]), .cin(s1_c26_carry[5]), .sum(s2_c27_sum[1]), .cout(s2_c27_carry[1]));
full_adder s2_c27_adder2(.A(s1_c27_sum[0]), .B(s1_c27_sum[1]), .cin(s1_c27_sum[2]), .sum(s2_c27_sum[2]), .cout(s2_c27_carry[2]));
full_adder s2_c27_adder3(.A(s1_c27_sum[3]), .B(s1_c27_sum[4]), .cin(s1_c27_sum[5]), .sum(s2_c27_sum[3]), .cout(s2_c27_carry[3]));

//column 28
logic s2_c28_sum[4], s2_c28_carry[4];
full_adder s2_c28_adder0(.A(s1_c27_carry[0]), .B(s1_c27_carry[1]), .cin(s1_c27_carry[2]), .sum(s2_c28_sum[0]), .cout(s2_c28_carry[0]));
full_adder s2_c28_adder1(.A(s1_c27_carry[3]), .B(s1_c27_carry[4]), .cin(s1_c27_carry[5]), .sum(s2_c28_sum[1]), .cout(s2_c28_carry[1]));
full_adder s2_c28_adder2(.A(s1_c28_sum[0]), .B(s1_c28_sum[1]), .cin(s1_c28_sum[2]), .sum(s2_c28_sum[2]), .cout(s2_c28_carry[2]));
full_adder s2_c28_adder3(.A(s1_c28_sum[3]), .B(s1_c28_sum[4]), .cin(s1_c28_sum[5]), .sum(s2_c28_sum[3]), .cout(s2_c28_carry[3]));

//column 29
logic s2_c29_sum[4], s2_c29_carry[4];
full_adder s2_c29_adder0(.A(s1_c28_carry[0]), .B(s1_c28_carry[1]), .cin(s1_c28_carry[2]), .sum(s2_c29_sum[0]), .cout(s2_c29_carry[0]));
full_adder s2_c29_adder1(.A(s1_c28_carry[3]), .B(s1_c28_carry[4]), .cin(s1_c28_carry[5]), .sum(s2_c29_sum[1]), .cout(s2_c29_carry[1]));
full_adder s2_c29_adder2(.A(s1_c29_sum[0]), .B(s1_c29_sum[1]), .cin(s1_c29_sum[2]), .sum(s2_c29_sum[2]), .cout(s2_c29_carry[2]));
full_adder s2_c29_adder3(.A(s1_c29_sum[3]), .B(s1_c29_sum[4]), .cin(s1_c29_sum[5]), .sum(s2_c29_sum[3]), .cout(s2_c29_carry[3]));

//column 30
logic s2_c30_sum[4], s2_c30_carry[4];
full_adder s2_c30_adder0(.A(s1_c29_carry[0]), .B(s1_c29_carry[1]), .cin(s1_c29_carry[2]), .sum(s2_c30_sum[0]), .cout(s2_c30_carry[0]));
full_adder s2_c30_adder1(.A(s1_c29_carry[3]), .B(s1_c29_carry[4]), .cin(s1_c29_carry[5]), .sum(s2_c30_sum[1]), .cout(s2_c30_carry[1]));
full_adder s2_c30_adder2(.A(s1_c30_sum[0]), .B(s1_c30_sum[1]), .cin(s1_c30_sum[2]), .sum(s2_c30_sum[2]), .cout(s2_c30_carry[2]));
full_adder s2_c30_adder3(.A(s1_c30_sum[3]), .B(s1_c30_sum[4]), .cin(pp[22][8]), .sum(s2_c30_sum[3]), .cout(s2_c30_carry[3]));

//column 31
logic s2_c31_sum[4], s2_c31_carry[4];
full_adder s2_c31_adder0(.A(s1_c30_carry[0]), .B(s1_c30_carry[1]), .cin(s1_c30_carry[2]), .sum(s2_c31_sum[0]), .cout(s2_c31_carry[0]));
full_adder s2_c31_adder1(.A(s1_c30_carry[3]), .B(s1_c30_carry[4]), .cin(s1_c31_sum[0]), .sum(s2_c31_sum[1]), .cout(s2_c31_carry[1]));
full_adder s2_c31_adder2(.A(s1_c31_sum[1]), .B(s1_c31_sum[2]), .cin(s1_c31_sum[3]), .sum(s2_c31_sum[2]), .cout(s2_c31_carry[2]));
full_adder s2_c31_adder3(.A(pp[20][11]), .B(pp[21][10]), .cin(pp[22][9]), .sum(s2_c31_sum[3]), .cout(s2_c31_carry[3]));

//column 32
logic s2_c32_sum[4], s2_c32_carry[4];
full_adder s2_c32_adder0(.A(s1_c31_carry[0]), .B(s1_c31_carry[1]), .cin(s1_c31_carry[2]), .sum(s2_c32_sum[0]), .cout(s2_c32_carry[0]));
full_adder s2_c32_adder1(.A(s1_c31_carry[3]), .B(s1_c32_sum[0]), .cin(s1_c32_sum[1]), .sum(s2_c32_sum[1]), .cout(s2_c32_carry[1]));
full_adder s2_c32_adder2(.A(s1_c32_sum[2]), .B(pp[18][14]), .cin(pp[19][13]), .sum(s2_c32_sum[2]), .cout(s2_c32_carry[2]));
full_adder s2_c32_adder3(.A(pp[20][12]), .B(pp[21][11]), .cin(pp[22][10]), .sum(s2_c32_sum[3]), .cout(s2_c32_carry[3]));

//column 33
logic s2_c33_sum[4], s2_c33_carry[4];
full_adder s2_c33_adder0(.A(s1_c32_carry[0]), .B(s1_c32_carry[1]), .cin(s1_c32_carry[2]), .sum(s2_c33_sum[0]), .cout(s2_c33_carry[0]));
full_adder s2_c33_adder1(.A(s1_c33_sum[0]), .B(s1_c33_sum[1]), .cin(pp[16][17]), .sum(s2_c33_sum[1]), .cout(s2_c33_carry[1]));
full_adder s2_c33_adder2(.A(pp[17][16]), .B(pp[18][15]), .cin(pp[19][14]), .sum(s2_c33_sum[2]), .cout(s2_c33_carry[2]));
full_adder s2_c33_adder3(.A(pp[20][13]), .B(pp[21][12]), .cin(pp[22][11]), .sum(s2_c33_sum[3]), .cout(s2_c33_carry[3]));

//column 34
logic s2_c34_sum[4], s2_c34_carry[4];
full_adder s2_c34_adder0(.A(s1_c33_carry[0]), .B(s1_c33_carry[1]), .cin(s1_c34_sum), .sum(s2_c34_sum[0]), .cout(s2_c34_carry[0]));
full_adder s2_c34_adder1(.A(pp[14][20]), .B(pp[15][19]), .cin(pp[16][18]), .sum(s2_c34_sum[1]), .cout(s2_c34_carry[1]));
full_adder s2_c34_adder2(.A(pp[17][17]), .B(pp[18][16]), .cin(pp[19][15]), .sum(s2_c34_sum[2]), .cout(s2_c34_carry[2]));
full_adder s2_c34_adder3(.A(pp[20][14]), .B(pp[21][13]), .cin(pp[22][12]), .sum(s2_c34_sum[3]), .cout(s2_c34_carry[3]));

//column 35
logic s2_c35_sum[4], s2_c35_carry[4];
full_adder s2_c35_adder0(.A(s1_c34_carry), .B(pp[12][23]), .cin(pp[13][22]), .sum(s2_c35_sum[0]), .cout(s2_c35_carry[0]));
full_adder s2_c35_adder1(.A(pp[14][21]), .B(pp[15][20]), .cin(pp[16][19]), .sum(s2_c35_sum[1]), .cout(s2_c35_carry[1]));
full_adder s2_c35_adder2(.A(pp[17][18]), .B(pp[18][17]), .cin(pp[19][16]), .sum(s2_c35_sum[2]), .cout(s2_c35_carry[2]));
full_adder s2_c35_adder3(.A(pp[20][15]), .B(pp[21][14]), .cin(pp[22][13]), .sum(s2_c35_sum[3]), .cout(s2_c35_carry[3]));

//column 36
logic s2_c36_sum[3], s2_c36_carry[3];
full_adder s2_c36_adder0(.A(pp[13][23]), .B(pp[14][22]), .cin(pp[15][21]), .sum(s2_c36_sum[0]), .cout(s2_c36_carry[0]));
full_adder s2_c36_adder1(.A(pp[16][20]), .B(pp[17][19]), .cin(pp[18][18]), .sum(s2_c36_sum[1]), .cout(s2_c36_carry[1]));
full_adder s2_c36_adder2(.A(pp[19][17]), .B(pp[20][16]), .cin(pp[21][15]), .sum(s2_c36_sum[2]), .cout(s2_c36_carry[2]));

//column 37
logic s2_c37_sum[2], s2_c37_carry[2];
full_adder s2_c37_adder0(.A(pp[14][23]), .B(pp[15][22]), .cin(pp[16][21]), .sum(s2_c37_sum[0]), .cout(s2_c37_carry[0]));
full_adder s2_c37_adder1(.A(pp[17][20]), .B(pp[18][19]), .cin(pp[19][18]), .sum(s2_c37_sum[1]), .cout(s2_c37_carry[1]));

//column 38
logic s2_c38_sum, s2_c38_carry;
full_adder s2_c38_adder0(.A(pp[15][23]), .B(pp[16][22]), .cin(pp[17][21]), .sum(s2_c38_sum), .cout(s2_c38_carry));

//stage 3 reduce height to 6

//column 6
logic s3_c6_sum, s3_c6_carry;
half_adder s3_c6_adder0(.A(pp[0][6]), .B(pp[1][5]), .sum(s3_c6_sum), .cout(s3_c6_carry));

//column 7
logic s3_c7_sum[2], s3_c7_carry[2];
half_adder s3_c7_adder0(.A(pp[0][7]), .B(pp[1][6]), .sum(s3_c7_sum[0]), .cout(s3_c7_carry[0]));
full_adder s3_c7_adder1(.A(pp[2][5]), .B(pp[3][4]), .cin(pp[4][3]), .sum(s3_c7_sum[1]), .cout(s3_c7_carry[1]));

//column 8
logic s3_c8_sum[3], s3_c8_carry[3];
half_adder s3_c8_adder0(.A(pp[0][8]), .B(pp[1][7]), .sum(s3_c8_sum[0]), .cout(s3_c8_carry[0]));
full_adder s3_c8_adder1(.A(pp[2][6]), .B(pp[3][5]), .cin(pp[4][4]), .sum(s3_c8_sum[1]), .cout(s3_c8_carry[1]));
full_adder s3_c8_adder2(.A(pp[5][3]), .B(pp[6][2]), .cin(pp[7][1]), .sum(s3_c8_sum[2]), .cout(s3_c8_carry[2]));

//column 9
logic s3_c9_sum[3], s3_c9_carry[3];
full_adder s3_c9_adder0(.A(s2_c9_sum), .B(pp[2][7]), .cin(pp[3][6]), .sum(s3_c9_sum[0]), .cout(s3_c9_carry[0]));
full_adder s3_c9_adder1(.A(pp[4][5]), .B(pp[5][4]), .cin(pp[6][3]), .sum(s3_c9_sum[1]), .cout(s3_c9_carry[1]));
full_adder s3_c9_adder2(.A(pp[7][2]), .B(pp[8][1]), .cin(pp[9][0]), .sum(s3_c9_sum[2]), .cout(s3_c9_carry[2]));

//column 10
logic s3_c10_sum[3], s3_c10_carry[3];
full_adder s3_c10_adder0(.A(s2_c9_carry), .B(s2_c10_sum[0]), .cin(s2_c10_sum[1]), .sum(s3_c10_sum[0]), .cout(s3_c10_carry[0]));
full_adder s3_c10_adder1(.A(pp[5][5]), .B(pp[6][4]), .cin(pp[7][3]), .sum(s3_c10_sum[1]), .cout(s3_c10_carry[1]));
full_adder s3_c10_adder2(.A(pp[8][2]), .B(pp[9][1]), .cin(pp[10][0]), .sum(s3_c10_sum[2]), .cout(s3_c10_carry[2]));

//column 11
logic s3_c11_sum[3], s3_c11_carry[3];
full_adder s3_c11_adder0(.A(s2_c10_carry[0]), .B(s2_c10_carry[1]), .cin(s2_c11_sum[0]), .sum(s3_c11_sum[0]), .cout(s3_c11_carry[0]));
full_adder s3_c11_adder1(.A(s2_c11_sum[1]), .B(s2_c11_sum[2]), .cin(pp[8][3]), .sum(s3_c11_sum[1]), .cout(s3_c11_carry[1]));
full_adder s3_c11_adder2(.A(pp[9][2]), .B(pp[10][1]), .cin(pp[11][0]), .sum(s3_c11_sum[2]), .cout(s3_c11_carry[2]));

//column 12
logic s3_c12_sum[3], s3_c12_carry[3];
full_adder s3_c12_adder0(.A(s2_c11_carry[0]), .B(s2_c11_carry[1]), .cin(s2_c11_carry[2]), .sum(s3_c12_sum[0]), .cout(s3_c12_carry[0]));
full_adder s3_c12_adder1(.A(s2_c12_sum[0]), .B(s2_c12_sum[1]), .cin(s2_c12_sum[2]), .sum(s3_c12_sum[1]), .cout(s3_c12_carry[1]));
full_adder s3_c12_adder2(.A(s2_c12_sum[3]), .B(pp[11][1]), .cin(pp[12][0]), .sum(s3_c12_sum[2]), .cout(s3_c12_carry[2]));

//column 13
logic s3_c13_sum[3], s3_c13_carry[3];
full_adder s3_c13_adder0(.A(s2_c12_carry[0]), .B(s2_c12_carry[1]), .cin(s2_c12_carry[2]), .sum(s3_c13_sum[0]), .cout(s3_c13_carry[0]));
full_adder s3_c13_adder1(.A(s2_c12_carry[3]), .B(s2_c13_sum[0]), .cin(s2_c13_sum[1]), .sum(s3_c13_sum[1]), .cout(s3_c13_carry[1]));
full_adder s3_c13_adder2(.A(s2_c13_sum[2]), .B(s2_c13_sum[3]), .cin(pp[13][0]), .sum(s3_c13_sum[2]), .cout(s3_c13_carry[2]));

//column 14
logic s3_c14_sum[3], s3_c14_carry[3];
full_adder s3_c14_adder0(.A(s2_c13_carry[0]), .B(s2_c13_carry[1]), .cin(s2_c13_carry[2]), .sum(s3_c14_sum[0]), .cout(s3_c14_carry[0]));
full_adder s3_c14_adder1(.A(s2_c13_carry[3]), .B(s2_c14_sum[0]), .cin(s2_c14_sum[1]), .sum(s3_c14_sum[1]), .cout(s3_c14_carry[1]));
full_adder s3_c14_adder2(.A(s2_c14_sum[2]), .B(s2_c14_sum[3]), .cin(pp[14][0]), .sum(s3_c14_sum[2]), .cout(s3_c14_carry[2]));

//column 15
logic s3_c15_sum[3], s3_c15_carry[3];
full_adder s3_c15_adder0(.A(s2_c14_carry[0]), .B(s2_c14_carry[1]), .cin(s2_c14_carry[2]), .sum(s3_c15_sum[0]), .cout(s3_c15_carry[0]));
full_adder s3_c15_adder1(.A(s2_c14_carry[3]), .B(s2_c15_sum[0]), .cin(s2_c15_sum[1]), .sum(s3_c15_sum[1]), .cout(s3_c15_carry[1]));
full_adder s3_c15_adder2(.A(s2_c15_sum[2]), .B(s2_c15_sum[3]), .cin(pp[15][0]), .sum(s3_c15_sum[2]), .cout(s3_c15_carry[2]));

//column 16
logic s3_c16_sum[3], s3_c16_carry[3];
full_adder s3_c16_adder0(.A(s2_c15_carry[0]), .B(s2_c15_carry[1]), .cin(s2_c15_carry[2]), .sum(s3_c16_sum[0]), .cout(s3_c16_carry[0]));
full_adder s3_c16_adder1(.A(s2_c15_carry[3]), .B(s2_c16_sum[0]), .cin(s2_c16_sum[1]), .sum(s3_c16_sum[1]), .cout(s3_c16_carry[1]));
full_adder s3_c16_adder2(.A(s2_c16_sum[2]), .B(s2_c16_sum[3]), .cin(pp[16][0]), .sum(s3_c16_sum[2]), .cout(s3_c16_carry[2]));

//column 17
logic s3_c17_sum[3], s3_c17_carry[3];
full_adder s3_c17_adder0(.A(s2_c16_carry[0]), .B(s2_c16_carry[1]), .cin(s2_c16_carry[2]), .sum(s3_c17_sum[0]), .cout(s3_c17_carry[0]));
full_adder s3_c17_adder1(.A(s2_c16_carry[3]), .B(s2_c17_sum[0]), .cin(s2_c17_sum[1]), .sum(s3_c17_sum[1]), .cout(s3_c17_carry[1]));
full_adder s3_c17_adder2(.A(s2_c17_sum[2]), .B(s2_c17_sum[3]), .cin(pp[17][0]), .sum(s3_c17_sum[2]), .cout(s3_c17_carry[2]));

//column 18
logic s3_c18_sum[3], s3_c18_carry[3];
full_adder s3_c18_adder0(.A(s2_c17_carry[0]), .B(s2_c17_carry[1]), .cin(s2_c17_carry[2]), .sum(s3_c18_sum[0]), .cout(s3_c18_carry[0]));
full_adder s3_c18_adder1(.A(s2_c17_carry[3]), .B(s2_c18_sum[0]), .cin(s2_c18_sum[1]), .sum(s3_c18_sum[1]), .cout(s3_c18_carry[1]));
full_adder s3_c18_adder2(.A(s2_c18_sum[2]), .B(s2_c18_sum[3]), .cin(pp[18][0]), .sum(s3_c18_sum[2]), .cout(s3_c18_carry[2]));

//column 19
logic s3_c19_sum[3], s3_c19_carry[3];
full_adder s3_c19_adder0(.A(s2_c18_carry[0]), .B(s2_c18_carry[1]), .cin(s2_c18_carry[2]), .sum(s3_c19_sum[0]), .cout(s3_c19_carry[0]));
full_adder s3_c19_adder1(.A(s2_c18_carry[3]), .B(s2_c19_sum[0]), .cin(s2_c19_sum[1]), .sum(s3_c19_sum[1]), .cout(s3_c19_carry[1]));
full_adder s3_c19_adder2(.A(s2_c19_sum[2]), .B(s2_c19_sum[3]), .cin(pp[19][0]), .sum(s3_c19_sum[2]), .cout(s3_c19_carry[2]));

//column 20
logic s3_c20_sum[3], s3_c20_carry[3];
full_adder s3_c20_adder0(.A(s2_c19_carry[0]), .B(s2_c19_carry[1]), .cin(s2_c19_carry[2]), .sum(s3_c20_sum[0]), .cout(s3_c20_carry[0]));
full_adder s3_c20_adder1(.A(s2_c19_carry[3]), .B(s2_c20_sum[0]), .cin(s2_c20_sum[1]), .sum(s3_c20_sum[1]), .cout(s3_c20_carry[1]));
full_adder s3_c20_adder2(.A(s2_c20_sum[2]), .B(s2_c20_sum[3]), .cin(pp[20][0]), .sum(s3_c20_sum[2]), .cout(s3_c20_carry[2]));

//column 21
logic s3_c21_sum[3], s3_c21_carry[3];
full_adder s3_c21_adder0(.A(s2_c20_carry[0]), .B(s2_c20_carry[1]), .cin(s2_c20_carry[2]), .sum(s3_c21_sum[0]), .cout(s3_c21_carry[0]));
full_adder s3_c21_adder1(.A(s2_c20_carry[3]), .B(s2_c21_sum[0]), .cin(s2_c21_sum[1]), .sum(s3_c21_sum[1]), .cout(s3_c21_carry[1]));
full_adder s3_c21_adder2(.A(s2_c21_sum[2]), .B(s2_c21_sum[3]), .cin(pp[21][0]), .sum(s3_c21_sum[2]), .cout(s3_c21_carry[2]));

//column 22
logic s3_c22_sum[3], s3_c22_carry[3];
full_adder s3_c22_adder0(.A(s2_c21_carry[0]), .B(s2_c21_carry[1]), .cin(s2_c21_carry[2]), .sum(s3_c22_sum[0]), .cout(s3_c22_carry[0]));
full_adder s3_c22_adder1(.A(s2_c21_carry[3]), .B(s2_c22_sum[0]), .cin(s2_c22_sum[1]), .sum(s3_c22_sum[1]), .cout(s3_c22_carry[1]));
full_adder s3_c22_adder2(.A(s2_c22_sum[2]), .B(s2_c22_sum[3]), .cin(pp[22][0]), .sum(s3_c22_sum[2]), .cout(s3_c22_carry[2]));

//column 23
logic s3_c23_sum[3], s3_c23_carry[3];
full_adder s3_c23_adder0(.A(s2_c22_carry[0]), .B(s2_c22_carry[1]), .cin(s2_c22_carry[2]), .sum(s3_c23_sum[0]), .cout(s3_c23_carry[0]));
full_adder s3_c23_adder1(.A(s2_c22_carry[3]), .B(s2_c23_sum[0]), .cin(s2_c23_sum[1]), .sum(s3_c23_sum[1]), .cout(s3_c23_carry[1]));
full_adder s3_c23_adder2(.A(s2_c23_sum[2]), .B(s2_c23_sum[3]), .cin(pp[23][0]), .sum(s3_c23_sum[2]), .cout(s3_c23_carry[2]));

//column 24
logic s3_c24_sum[3], s3_c24_carry[3];
full_adder s3_c24_adder0(.A(s2_c23_carry[0]), .B(s2_c23_carry[1]), .cin(s2_c23_carry[2]), .sum(s3_c24_sum[0]), .cout(s3_c24_carry[0]));
full_adder s3_c24_adder1(.A(s2_c23_carry[3]), .B(s2_c24_sum[0]), .cin(s2_c24_sum[1]), .sum(s3_c24_sum[1]), .cout(s3_c24_carry[1]));
full_adder s3_c24_adder2(.A(s2_c24_sum[2]), .B(s2_c24_sum[3]), .cin(pp[23][1]), .sum(s3_c24_sum[2]), .cout(s3_c24_carry[2]));

//column 25
logic s3_c25_sum[3], s3_c25_carry[3];
full_adder s3_c25_adder0(.A(s2_c24_carry[0]), .B(s2_c24_carry[1]), .cin(s2_c24_carry[2]), .sum(s3_c25_sum[0]), .cout(s3_c25_carry[0]));
full_adder s3_c25_adder1(.A(s2_c24_carry[3]), .B(s2_c25_sum[0]), .cin(s2_c25_sum[1]), .sum(s3_c25_sum[1]), .cout(s3_c25_carry[1]));
full_adder s3_c25_adder2(.A(s2_c25_sum[2]), .B(s2_c25_sum[3]), .cin(pp[23][2]), .sum(s3_c25_sum[2]), .cout(s3_c25_carry[2]));

//column 26
logic s3_c26_sum[3], s3_c26_carry[3];
full_adder s3_c26_adder0(.A(s2_c25_carry[0]), .B(s2_c25_carry[1]), .cin(s2_c25_carry[2]), .sum(s3_c26_sum[0]), .cout(s3_c26_carry[0]));
full_adder s3_c26_adder1(.A(s2_c25_carry[3]), .B(s2_c26_sum[0]), .cin(s2_c26_sum[1]), .sum(s3_c26_sum[1]), .cout(s3_c26_carry[1]));
full_adder s3_c26_adder2(.A(s2_c26_sum[2]), .B(s2_c26_sum[3]), .cin(pp[23][3]), .sum(s3_c26_sum[2]), .cout(s3_c26_carry[2]));

//column 27
logic s3_c27_sum[3], s3_c27_carry[3];
full_adder s3_c27_adder0(.A(s2_c26_carry[0]), .B(s2_c26_carry[1]), .cin(s2_c26_carry[2]), .sum(s3_c27_sum[0]), .cout(s3_c27_carry[0]));
full_adder s3_c27_adder1(.A(s2_c26_carry[3]), .B(s2_c27_sum[0]), .cin(s2_c27_sum[1]), .sum(s3_c27_sum[1]), .cout(s3_c27_carry[1]));
full_adder s3_c27_adder2(.A(s2_c27_sum[2]), .B(s2_c27_sum[3]), .cin(pp[23][4]), .sum(s3_c27_sum[2]), .cout(s3_c27_carry[2]));

//column 28
logic s3_c28_sum[3], s3_c28_carry[3];
full_adder s3_c28_adder0(.A(s2_c27_carry[0]), .B(s2_c27_carry[1]), .cin(s2_c27_carry[2]), .sum(s3_c28_sum[0]), .cout(s3_c28_carry[0]));
full_adder s3_c28_adder1(.A(s2_c27_carry[3]), .B(s2_c28_sum[0]), .cin(s2_c28_sum[1]), .sum(s3_c28_sum[1]), .cout(s3_c28_carry[1]));
full_adder s3_c28_adder2(.A(s2_c28_sum[2]), .B(s2_c28_sum[3]), .cin(pp[23][5]), .sum(s3_c28_sum[2]), .cout(s3_c28_carry[2]));

//column 29
logic s3_c29_sum[3], s3_c29_carry[3];
full_adder s3_c29_adder0(.A(s2_c28_carry[0]), .B(s2_c28_carry[1]), .cin(s2_c28_carry[2]), .sum(s3_c29_sum[0]), .cout(s3_c29_carry[0]));
full_adder s3_c29_adder1(.A(s2_c28_carry[3]), .B(s2_c29_sum[0]), .cin(s2_c29_sum[1]), .sum(s3_c29_sum[1]), .cout(s3_c29_carry[1]));
full_adder s3_c29_adder2(.A(s2_c29_sum[2]), .B(s2_c29_sum[3]), .cin(pp[23][6]), .sum(s3_c29_sum[2]), .cout(s3_c29_carry[2]));

//column 30
logic s3_c30_sum[3], s3_c30_carry[3];
full_adder s3_c30_adder0(.A(s2_c29_carry[0]), .B(s2_c29_carry[1]), .cin(s2_c29_carry[2]), .sum(s3_c30_sum[0]), .cout(s3_c30_carry[0]));
full_adder s3_c30_adder1(.A(s2_c29_carry[3]), .B(s2_c30_sum[0]), .cin(s2_c30_sum[1]), .sum(s3_c30_sum[1]), .cout(s3_c30_carry[1]));
full_adder s3_c30_adder2(.A(s2_c30_sum[2]), .B(s2_c30_sum[3]), .cin(pp[23][7]), .sum(s3_c30_sum[2]), .cout(s3_c30_carry[2]));

//column 31
logic s3_c31_sum[3], s3_c31_carry[3];
full_adder s3_c31_adder0(.A(s2_c30_carry[0]), .B(s2_c30_carry[1]), .cin(s2_c30_carry[2]), .sum(s3_c31_sum[0]), .cout(s3_c31_carry[0]));
full_adder s3_c31_adder1(.A(s2_c30_carry[3]), .B(s2_c31_sum[0]), .cin(s2_c31_sum[1]), .sum(s3_c31_sum[1]), .cout(s3_c31_carry[1]));
full_adder s3_c31_adder2(.A(s2_c31_sum[2]), .B(s2_c31_sum[3]), .cin(pp[23][8]), .sum(s3_c31_sum[2]), .cout(s3_c31_carry[2]));

//column 32
logic s3_c32_sum[3], s3_c32_carry[3];
full_adder s3_c32_adder0(.A(s2_c31_carry[0]), .B(s2_c31_carry[1]), .cin(s2_c31_carry[2]), .sum(s3_c32_sum[0]), .cout(s3_c32_carry[0]));
full_adder s3_c32_adder1(.A(s2_c31_carry[3]), .B(s2_c32_sum[0]), .cin(s2_c32_sum[1]), .sum(s3_c32_sum[1]), .cout(s3_c32_carry[1]));
full_adder s3_c32_adder2(.A(s2_c32_sum[2]), .B(s2_c32_sum[3]), .cin(pp[23][9]), .sum(s3_c32_sum[2]), .cout(s3_c32_carry[2]));

//column 33
logic s3_c33_sum[3], s3_c33_carry[3];
full_adder s3_c33_adder0(.A(s2_c32_carry[0]), .B(s2_c32_carry[1]), .cin(s2_c32_carry[2]), .sum(s3_c33_sum[0]), .cout(s3_c33_carry[0]));
full_adder s3_c33_adder1(.A(s2_c32_carry[3]), .B(s2_c33_sum[0]), .cin(s2_c33_sum[1]), .sum(s3_c33_sum[1]), .cout(s3_c33_carry[1]));
full_adder s3_c33_adder2(.A(s2_c33_sum[2]), .B(s2_c33_sum[3]), .cin(pp[23][10]), .sum(s3_c33_sum[2]), .cout(s3_c33_carry[2]));

//column 34
logic s3_c34_sum[3], s3_c34_carry[3];
full_adder s3_c34_adder0(.A(s2_c33_carry[0]), .B(s2_c33_carry[1]), .cin(s2_c33_carry[2]), .sum(s3_c34_sum[0]), .cout(s3_c34_carry[0]));
full_adder s3_c34_adder1(.A(s2_c33_carry[3]), .B(s2_c34_sum[0]), .cin(s2_c34_sum[1]), .sum(s3_c34_sum[1]), .cout(s3_c34_carry[1]));
full_adder s3_c34_adder2(.A(s2_c34_sum[2]), .B(s2_c34_sum[3]), .cin(pp[23][11]), .sum(s3_c34_sum[2]), .cout(s3_c34_carry[2]));

//column 35
logic s3_c35_sum[3], s3_c35_carry[3];
full_adder s3_c35_adder0(.A(s2_c34_carry[0]), .B(s2_c34_carry[1]), .cin(s2_c34_carry[2]), .sum(s3_c35_sum[0]), .cout(s3_c35_carry[0]));
full_adder s3_c35_adder1(.A(s2_c34_carry[3]), .B(s2_c35_sum[0]), .cin(s2_c35_sum[1]), .sum(s3_c35_sum[1]), .cout(s3_c35_carry[1]));
full_adder s3_c35_adder2(.A(s2_c35_sum[2]), .B(s2_c35_sum[3]), .cin(pp[23][12]), .sum(s3_c35_sum[2]), .cout(s3_c35_carry[2]));

//column 36
logic s3_c36_sum[3], s3_c36_carry[3];
full_adder s3_c36_adder0(.A(s2_c35_carry[0]), .B(s2_c35_carry[1]), .cin(s2_c35_carry[2]), .sum(s3_c36_sum[0]), .cout(s3_c36_carry[0]));
full_adder s3_c36_adder1(.A(s2_c35_carry[3]), .B(s2_c36_sum[0]), .cin(s2_c36_sum[1]), .sum(s3_c36_sum[1]), .cout(s3_c36_carry[1]));
full_adder s3_c36_adder2(.A(s2_c36_sum[2]), .B(pp[22][14]), .cin(pp[23][13]), .sum(s3_c36_sum[2]), .cout(s3_c36_carry[2]));

//column 37
logic s3_c37_sum[3], s3_c37_carry[3];
full_adder s3_c37_adder0(.A(s2_c36_carry[0]), .B(s2_c36_carry[1]), .cin(s2_c36_carry[2]), .sum(s3_c37_sum[0]), .cout(s3_c37_carry[0]));
full_adder s3_c37_adder1(.A(s2_c37_sum[0]), .B(s2_c37_sum[1]), .cin(pp[20][17]), .sum(s3_c37_sum[1]), .cout(s3_c37_carry[1]));
full_adder s3_c37_adder2(.A(pp[21][16]), .B(pp[22][15]), .cin(pp[23][14]), .sum(s3_c37_sum[2]), .cout(s3_c37_carry[2]));

//column 38
logic s3_c38_sum[3], s3_c38_carry[3];
full_adder s3_c38_adder0(.A(s2_c37_carry[0]), .B(s2_c37_carry[1]), .cin(s2_c38_sum), .sum(s3_c38_sum[0]), .cout(s3_c38_carry[0]));
full_adder s3_c38_adder1(.A(pp[18][20]), .B(pp[19][19]), .cin(pp[20][18]), .sum(s3_c38_sum[1]), .cout(s3_c38_carry[1]));
full_adder s3_c38_adder2(.A(pp[21][17]), .B(pp[22][16]), .cin(pp[23][15]), .sum(s3_c38_sum[2]), .cout(s3_c38_carry[2]));

//column 39
logic s3_c39_sum[3], s3_c39_carry[3];
full_adder s3_c39_adder0(.A(s2_c38_carry), .B(pp[16][23]), .cin(pp[17][22]), .sum(s3_c39_sum[0]), .cout(s3_c39_carry[0]));
full_adder s3_c39_adder1(.A(pp[18][21]), .B(pp[19][20]), .cin(pp[20][19]), .sum(s3_c39_sum[1]), .cout(s3_c39_carry[1]));
full_adder s3_c39_adder2(.A(pp[21][18]), .B(pp[22][17]), .cin(pp[23][16]), .sum(s3_c39_sum[2]), .cout(s3_c39_carry[2]));

//column 40
logic s3_c40_sum[2], s3_c40_carry[2];
full_adder s3_c40_adder0(.A(pp[17][23]), .B(pp[18][22]), .cin(pp[19][21]), .sum(s3_c40_sum[0]), .cout(s3_c40_carry[0]));
full_adder s3_c40_adder1(.A(pp[20][20]), .B(pp[21][19]), .cin(pp[22][18]), .sum(s3_c40_sum[1]), .cout(s3_c40_carry[1]));

//column 41
logic s3_c41_sum, s3_c41_carry;
full_adder s3_c41_adder0(.A(pp[18][23]), .B(pp[19][22]), .cin(pp[20][21]), .sum(s3_c41_sum), .cout(s3_c41_carry));


logic s3_c6_sum_r, s3_c6_carry_r;
logic s3_c7_sum_r[2], s3_c7_carry_r[2];
logic s3_c8_sum_r[3], s3_c8_carry_r[3];
logic s3_c9_sum_r[3], s3_c9_carry_r[3];
logic s3_c10_sum_r[3], s3_c10_carry_r[3];
logic s3_c11_sum_r[3], s3_c11_carry_r[3];
logic s3_c12_sum_r[3], s3_c12_carry_r[3];
logic s3_c13_sum_r[3], s3_c13_carry_r[3];
logic s3_c14_sum_r[3], s3_c14_carry_r[3];
logic s3_c15_sum_r[3], s3_c15_carry_r[3];
logic s3_c16_sum_r[3], s3_c16_carry_r[3];
logic s3_c17_sum_r[3], s3_c17_carry_r[3];
logic s3_c18_sum_r[3], s3_c18_carry_r[3];
logic s3_c19_sum_r[3], s3_c19_carry_r[3];
logic s3_c20_sum_r[3], s3_c20_carry_r[3];
logic s3_c21_sum_r[3], s3_c21_carry_r[3];
logic s3_c22_sum_r[3], s3_c22_carry_r[3];
logic s3_c23_sum_r[3], s3_c23_carry_r[3];
logic s3_c24_sum_r[3], s3_c24_carry_r[3];
logic s3_c25_sum_r[3], s3_c25_carry_r[3];
logic s3_c26_sum_r[3], s3_c26_carry_r[3];
logic s3_c27_sum_r[3], s3_c27_carry_r[3];
logic s3_c28_sum_r[3], s3_c28_carry_r[3];
logic s3_c29_sum_r[3], s3_c29_carry_r[3];
logic s3_c30_sum_r[3], s3_c30_carry_r[3];
logic s3_c31_sum_r[3], s3_c31_carry_r[3];
logic s3_c32_sum_r[3], s3_c32_carry_r[3];
logic s3_c33_sum_r[3], s3_c33_carry_r[3];
logic s3_c34_sum_r[3], s3_c34_carry_r[3];
logic s3_c35_sum_r[3], s3_c35_carry_r[3];
logic s3_c36_sum_r[3], s3_c36_carry_r[3];
logic s3_c37_sum_r[3], s3_c37_carry_r[3];
logic s3_c38_sum_r[3], s3_c38_carry_r[3];
logic s3_c39_sum_r[3], s3_c39_carry_r[3];
logic s3_c40_sum_r[2], s3_c40_carry_r[2];
logic s3_c41_sum_r, s3_c41_carry_r;

logic pp0_4_r, pp1_3_r, pp0_5_r, pp1_4_r, pp2_3_r, pp3_2_r, pp4_1_r;
logic pp2_4_r, pp3_3_r, pp4_2_r, pp5_1_r, pp6_0_r, pp5_2_r, pp6_1_r;
logic pp7_0_r, pp8_0_r, pp23_17_r, pp21_20_r, pp22_19_r, pp23_18_r;
logic pp19_23_r, pp20_22_r, pp21_21_r, pp22_20_r, pp23_19_r, pp20_23_r;
logic pp21_22_r, pp22_21_r, pp0_3_r, pp1_2_r, pp2_2_r, pp3_1_r, pp5_0_r;
logic pp23_20_r, pp21_23_r, pp22_22_r, pp0_2_r, pp1_1_r, pp2_1_r, pp3_0_r;
logic pp4_0_r, pp23_21_r, pp22_23_r, pp23_22_r, pp0_1_r, pp23_23_r, pp2_0_r; 
logic pp1_0_r, pp0_0_r;
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            s3_c6_sum_r <= 0;
            s3_c6_carry_r <= 0;
            s3_c7_sum_r[0] <= 0;
            s3_c7_carry_r[0] <= 0;
            s3_c7_sum_r[1] <= 0;
            s3_c7_carry_r[1] <= 0;
            for(int i = 0; i < 3; i++) begin
                s3_c8_sum_r[i] <= 0;
                s3_c8_carry_r[i] <= 0;
                s3_c9_sum_r[i] <= 0;
                s3_c9_carry_r[i] <=0;
                s3_c10_sum_r[i] <= 0;
                s3_c10_carry_r[i] <= 0;
                s3_c11_sum_r[i] <= 0;
                s3_c11_carry_r[i] <= 0;
                s3_c12_sum_r[i] <= 0;
                s3_c12_carry_r[i] <= 0;
                s3_c13_sum_r[i] <= 0;
                s3_c13_carry_r[i] <= 0;
                s3_c14_sum_r[i] <= 0;
                s3_c14_carry_r[i] <= 0;
                s3_c15_sum_r[i] <= 0;
                s3_c15_carry_r[i] <= 0;
                s3_c16_sum_r[i] <= 0;
                s3_c16_carry_r[i] <= 0;
                s3_c17_sum_r[i] <= 0;
                s3_c17_carry_r[i] <= 0;
                s3_c18_sum_r[i] <= 0;
                s3_c18_carry_r[i] <= 0;
                s3_c19_sum_r[i] <= 0;
                s3_c19_carry_r[i] <= 0;
                s3_c20_sum_r[i] <= 0;
                s3_c20_carry_r[i] <= 0;
                s3_c21_sum_r[i] <= 0;
                s3_c21_carry_r[i] <= 0;
                s3_c22_sum_r[i] <= 0;
                s3_c22_carry_r[i] <= 0;
                s3_c23_sum_r[i] <= 0;
                s3_c23_carry_r[i] <= 0;
                s3_c24_sum_r[i] <= 0;
                s3_c24_carry_r[i] <= 0;
                s3_c25_sum_r[i] <= 0;
                s3_c25_carry_r[i] <= 0;
                s3_c26_sum_r[i] <= 0;
                s3_c26_carry_r[i] <= 0;
                s3_c27_sum_r[i] <= 0;
                s3_c27_carry_r[i] <= 0;
                s3_c28_sum_r[i] <= 0;
                s3_c28_carry_r[i] <= 0;
                s3_c29_sum_r[i] <= 0;
                s3_c29_carry_r[i] <= 0;
                s3_c30_sum_r[i] <= 0;
                s3_c30_carry_r[i] <= 0;
                s3_c31_sum_r[i] <= 0;
                s3_c31_carry_r[i] <= 0;
                s3_c32_sum_r[i] <= 0;
                s3_c32_carry_r[i] <= 0;
                s3_c33_sum_r[i] <= 0;
                s3_c33_carry_r[i] <= 0;
                s3_c34_sum_r[i] <= 0;
                s3_c34_carry_r[i] <= 0;
                s3_c35_sum_r[i] <= 0;
                s3_c35_carry_r[i] <= 0;
                s3_c36_sum_r[i] <= 0;
                s3_c36_carry_r[i] <= 0;
                s3_c37_sum_r[i] <= 0;
                s3_c37_carry_r[i] <= 0;
                s3_c38_sum_r[i] <= 0;
                s3_c38_carry_r[i] <= 0;
                s3_c39_sum_r[i] <= 0;
                s3_c39_carry_r[i] <= 0;
            end
            s3_c40_sum_r[0] <= 0;
            s3_c40_carry_r[0] <= 0;
            s3_c40_sum_r[1] <= 0;
            s3_c40_carry_r[1] <= 0;
            s3_c41_sum_r <= 0;
            s3_c41_carry_r <= 0;


            pp0_4_r <= 0;
            pp1_3_r <= 0;
            pp0_5_r <= 0;
            pp1_4_r <= 0;
            pp2_3_r <= 0;
            pp3_2_r <= 0;
            pp4_1_r <= 0;
            pp2_4_r <= 0;
            pp3_3_r <= 0;
            pp4_2_r <= 0;
            pp5_1_r <= 0;
            pp6_0_r <= 0;
            pp5_2_r <= 0;
            pp6_1_r <= 0;
            pp7_0_r <= 0;
            pp8_0_r <= 0;
            pp23_17_r <= 0;
            pp21_20_r <= 0;
            pp22_19_r <= 0;
            pp23_18_r <= 0;
            pp19_23_r <= 0;
            pp20_22_r <= 0;
            pp21_21_r <= 0;
            pp22_20_r <= 0;
            pp23_19_r <= 0;
            pp20_23_r <= 0;
            pp21_22_r <= 0;
            pp22_21_r <= 0;
            pp0_3_r <= 0;
            pp1_2_r <= 0;
            pp2_2_r <= 0;
            pp3_1_r <= 0;
            pp5_0_r <= 0;
            pp23_20_r <= 0;
            pp21_23_r <= 0;
            pp22_22_r <= 0;
            pp0_2_r <= 0;
            pp1_1_r <= 0;
            pp2_1_r <= 0;
            pp3_0_r <= 0;
            pp4_0_r <= 0;
            pp23_21_r <= 0;
            pp22_23_r <= 0;
            pp23_22_r <= 0;
            pp0_1_r <= 0;
            pp23_23_r <= 0;
            pp2_0_r <= 0; 
            pp1_0_r <= 0;
            pp0_0_r <= 0;
        end else begin
            s3_c6_sum_r <= s3_c6_sum;
            s3_c6_carry_r <= s3_c6_carry;
            s3_c7_sum_r[0] <= s3_c7_sum[0];
            s3_c7_carry_r[0] <= s3_c7_carry[0];
            s3_c7_sum_r[1] <= s3_c7_sum[1];
            s3_c7_carry_r[1] <= s3_c7_carry[1];
            for(int i = 0; i < 3; i++) begin
                s3_c8_sum_r[i] <= s3_c8_sum[i];
                s3_c8_carry_r[i] <= s3_c8_carry[i];
                s3_c9_sum_r[i] <= s3_c9_sum[i];
                s3_c9_carry_r[i] <= s3_c9_carry[i];
                s3_c10_sum_r[i] <= s3_c10_sum[i];
                s3_c10_carry_r[i] <= s3_c10_carry[i];
                s3_c11_sum_r[i] <= s3_c11_sum[i];
                s3_c11_carry_r[i] <= s3_c11_carry[i];
                s3_c12_sum_r[i] <= s3_c12_sum[i];
                s3_c12_carry_r[i] <= s3_c12_carry[i];
                s3_c13_sum_r[i] <= s3_c13_sum[i];
                s3_c13_carry_r[i] <= s3_c13_carry[i];
                s3_c14_sum_r[i] <= s3_c14_sum[i];
                s3_c14_carry_r[i] <= s3_c14_carry[i];
                s3_c15_sum_r[i] <= s3_c15_sum[i];
                s3_c15_carry_r[i] <= s3_c15_carry[i];
                s3_c16_sum_r[i] <= s3_c16_sum[i];
                s3_c16_carry_r[i] <= s3_c16_carry[i];
                s3_c17_sum_r[i] <= s3_c17_sum[i];
                s3_c17_carry_r[i] <= s3_c17_carry[i];
                s3_c18_sum_r[i] <= s3_c18_sum[i];
                s3_c18_carry_r[i] <= s3_c18_carry[i];
                s3_c19_sum_r[i] <= s3_c19_sum[i];
                s3_c19_carry_r[i] <= s3_c19_carry[i];
                s3_c20_sum_r[i] <= s3_c20_sum[i];
                s3_c20_carry_r[i] <= s3_c20_carry[i];
                s3_c21_sum_r[i] <= s3_c21_sum[i];
                s3_c21_carry_r[i] <= s3_c21_carry[i];
                s3_c22_sum_r[i] <= s3_c22_sum[i];
                s3_c22_carry_r[i] <= s3_c22_carry[i];
                s3_c23_sum_r[i] <= s3_c23_sum[i];
                s3_c23_carry_r[i] <= s3_c23_carry[i];
                s3_c24_sum_r[i] <= s3_c24_sum[i];
                s3_c24_carry_r[i] <= s3_c24_carry[i];
                s3_c25_sum_r[i] <= s3_c25_sum[i];
                s3_c25_carry_r[i] <= s3_c25_carry[i];
                s3_c26_sum_r[i] <= s3_c26_sum[i];
                s3_c26_carry_r[i] <= s3_c26_carry[i];
                s3_c27_sum_r[i] <= s3_c27_sum[i];
                s3_c27_carry_r[i] <= s3_c27_carry[i];
                s3_c28_sum_r[i] <= s3_c28_sum[i];
                s3_c28_carry_r[i] <= s3_c28_carry[i];
                s3_c29_sum_r[i] <= s3_c29_sum[i];
                s3_c29_carry_r[i] <= s3_c29_carry[i];
                s3_c30_sum_r[i] <= s3_c30_sum[i];
                s3_c30_carry_r[i] <= s3_c30_carry[i];
                s3_c31_sum_r[i] <= s3_c31_sum[i];
                s3_c31_carry_r[i] <= s3_c31_carry[i]; 
                s3_c32_sum_r[i] <= s3_c32_sum[i];
                s3_c32_carry_r[i] <= s3_c32_carry[i];
                s3_c33_sum_r[i] <= s3_c33_sum[i];
                s3_c33_carry_r[i] <= s3_c33_carry[i];
                s3_c34_sum_r[i] <= s3_c34_sum[i];
                s3_c34_carry_r[i] <= s3_c34_carry[i];
                s3_c35_sum_r[i] <= s3_c35_sum[i];
                s3_c35_carry_r[i] <= s3_c35_carry[i];
                s3_c36_sum_r[i] <= s3_c36_sum[i];
                s3_c36_carry_r[i] <= s3_c36_carry[i];
                s3_c37_sum_r[i] <= s3_c37_sum[i];
                s3_c37_carry_r[i] <= s3_c37_carry[i];
                s3_c38_sum_r[i] <= s3_c38_sum[i];
                s3_c38_carry_r[i] <= s3_c38_carry[i];
                s3_c39_sum_r[i] <= s3_c39_sum[i];
                s3_c39_carry_r[i] <= s3_c39_carry[i];
            end
            s3_c40_sum_r[0] <= s3_c40_sum[0];
            s3_c40_carry_r[0] <= s3_c40_carry[0];
            s3_c40_sum_r[1] <= s3_c40_sum[1];
            s3_c40_carry_r[1] <= s3_c40_carry[1];
            s3_c41_sum_r <= s3_c41_sum;
            s3_c41_carry_r <= s3_c41_carry;


            pp0_4_r <= pp[0][4];  
            pp1_3_r <= pp[1][3];  
            pp0_5_r <= pp[0][5];  
            pp1_4_r <= pp[1][4];  
            pp2_3_r <= pp[2][3];  
            pp3_2_r <= pp[3][2];  
            pp4_1_r <= pp[4][1];  
            pp2_4_r <= pp[2][4];  
            pp3_3_r <= pp[3][3];  
            pp4_2_r <= pp[4][2];  
            pp5_1_r <= pp[5][1];  
            pp6_0_r <= pp[6][0];  
            pp5_2_r <= pp[5][2];  
            pp6_1_r <= pp[6][1];  
            pp7_0_r <= pp[7][0];  
            pp8_0_r <= pp[8][0];  
            pp23_17_r <= pp[23][17];  
            pp21_20_r <= pp[21][20];  
            pp22_19_r <= pp[22][19];  
            pp23_18_r <= pp[23][18];  
            pp19_23_r <= pp[19][23];  
            pp20_22_r <= pp[20][22];  
            pp21_21_r <= pp[21][21];  
            pp22_20_r <= pp[22][20];  
            pp23_19_r <= pp[23][19];  
            pp20_23_r <= pp[20][23];  
            pp21_22_r <= pp[21][22];  
            pp22_21_r <= pp[22][21];  
            pp0_3_r <= pp[0][3];  
            pp1_2_r <= pp[1][2];  
            pp2_2_r <= pp[2][2];  
            pp3_1_r <= pp[3][1];  
            pp5_0_r <= pp[5][0];  
            pp23_20_r <= pp[23][20];  
            pp21_23_r <= pp[21][23];  
            pp22_22_r <= pp[22][22];  
            pp0_2_r <= pp[0][2];  
            pp1_1_r <= pp[1][1];  
            pp2_1_r <= pp[2][1];  
            pp3_0_r <= pp[3][0];  
            pp4_0_r <= pp[4][0];  
            pp23_21_r <= pp[23][21];  
            pp22_23_r <= pp[22][23];  
            pp23_22_r <= pp[23][22];  
            pp0_1_r <= pp[0][1];  
            pp23_23_r <= pp[23][23];  
            pp2_0_r <= pp[2][0];  
            pp1_0_r <= pp[1][0];  
            pp0_0_r <= pp[0][0];  
        end
    end

//stage 4 reduce height to 4

//column 4
logic s4_c4_sum, s4_c4_carry;
half_adder s4_c4_adder0(.A(pp0_4_r), .B(pp1_3_r), .sum(s4_c4_sum), .cout(s4_c4_carry));

//column 5
logic s4_c5_sum[2], s4_c5_carry[2];
half_adder s4_c5_adder0(.A(pp0_5_r), .B(pp1_4_r), .sum(s4_c5_sum[0]), .cout(s4_c5_carry[0]));
full_adder s4_c5_adder1(.A(pp2_3_r), .B(pp3_2_r), .cin(pp4_1_r), .sum(s4_c5_sum[1]), .cout(s4_c5_carry[1]));

//column 6
logic s4_c6_sum[2], s4_c6_carry[2];
full_adder s4_c6_adder0(.A(s3_c6_sum_r), .B(pp2_4_r), .cin(pp3_3_r), .sum(s4_c6_sum[0]), .cout(s4_c6_carry[0]));
full_adder s4_c6_adder1(.A(pp4_2_r), .B(pp5_1_r), .cin(pp6_0_r), .sum(s4_c6_sum[1]), .cout(s4_c6_carry[1]));

//column 7
logic s4_c7_sum[2], s4_c7_carry[2];
full_adder s4_c7_adder0(.A(s3_c7_sum_r[0]), .B(s3_c7_sum_r[1]), .cin(s3_c6_carry_r), .sum(s4_c7_sum[0]), .cout(s4_c7_carry[0]));
full_adder s4_c7_adder1(.A(pp5_2_r), .B(pp6_1_r), .cin(pp7_0_r), .sum(s4_c7_sum[1]), .cout(s4_c7_carry[1]));

//column 8
logic s4_c8_sum[2], s4_c8_carry[2];
full_adder s4_c8_adder0(.A(s3_c8_sum_r[0]), .B(s3_c8_sum_r[1]), .cin(s3_c8_sum_r[2]), .sum(s4_c8_sum[0]), .cout(s4_c8_carry[0]));
full_adder s4_c8_adder1(.A(s3_c7_carry_r[0]), .B(s3_c7_carry_r[1]), .cin(pp8_0_r), .sum(s4_c8_sum[1]), .cout(s4_c8_carry[1]));

//column 9
logic s4_c9_sum[2], s4_c9_carry[2];
full_adder s4_c9_adder0(.A(s3_c8_carry_r[0]), .B(s3_c8_carry_r[1]), .cin(s3_c8_carry_r[2]), .sum(s4_c9_sum[0]), .cout(s4_c9_carry[0]));
full_adder s4_c9_adder1(.A(s3_c9_sum_r[0]), .B(s3_c9_sum_r[1]), .cin(s3_c9_sum_r[2]), .sum(s4_c9_sum[1]), .cout(s4_c9_carry[1]));

//column 10
logic s4_c10_sum[2], s4_c10_carry[2];
full_adder s4_c10_adder0(.A(s3_c9_carry_r[0]), .B(s3_c9_carry_r[1]), .cin(s3_c9_carry_r[2]), .sum(s4_c10_sum[0]), .cout(s4_c10_carry[0]));
full_adder s4_c10_adder1(.A(s3_c10_sum_r[0]), .B(s3_c10_sum_r[1]), .cin(s3_c10_sum_r[2]), .sum(s4_c10_sum[1]), .cout(s4_c10_carry[1]));

//column 11
logic s4_c11_sum[2], s4_c11_carry[2];
full_adder s4_c11_adder0(.A(s3_c10_carry_r[0]), .B(s3_c10_carry_r[1]), .cin(s3_c10_carry_r[2]), .sum(s4_c11_sum[0]), .cout(s4_c11_carry[0]));
full_adder s4_c11_adder1(.A(s3_c11_sum_r[0]), .B(s3_c11_sum_r[1]), .cin(s3_c11_sum_r[2]), .sum(s4_c11_sum[1]), .cout(s4_c11_carry[1]));

//column 12
logic s4_c12_sum[2], s4_c12_carry[2];
full_adder s4_c12_adder0(.A(s3_c11_carry_r[0]), .B(s3_c11_carry_r[1]), .cin(s3_c11_carry_r[2]), .sum(s4_c12_sum[0]), .cout(s4_c12_carry[0]));
full_adder s4_c12_adder1(.A(s3_c12_sum_r[0]), .B(s3_c12_sum_r[1]), .cin(s3_c12_sum_r[2]), .sum(s4_c12_sum[1]), .cout(s4_c12_carry[1]));

//column 13
logic s4_c13_sum[2], s4_c13_carry[2];
full_adder s4_c13_adder0(.A(s3_c12_carry_r[0]), .B(s3_c12_carry_r[1]), .cin(s3_c12_carry_r[2]), .sum(s4_c13_sum[0]), .cout(s4_c13_carry[0]));
full_adder s4_c13_adder1(.A(s3_c13_sum_r[0]), .B(s3_c13_sum_r[1]), .cin(s3_c13_sum_r[2]), .sum(s4_c13_sum[1]), .cout(s4_c13_carry[1]));

//column 14
logic s4_c14_sum[2], s4_c14_carry[2];
full_adder s4_c14_adder0(.A(s3_c13_carry_r[0]), .B(s3_c13_carry_r[1]), .cin(s3_c13_carry_r[2]), .sum(s4_c14_sum[0]), .cout(s4_c14_carry[0]));
full_adder s4_c14_adder1(.A(s3_c14_sum_r[0]), .B(s3_c14_sum_r[1]), .cin(s3_c14_sum_r[2]), .sum(s4_c14_sum[1]), .cout(s4_c14_carry[1]));

//column 15
logic s4_c15_sum[2], s4_c15_carry[2];
full_adder s4_c15_adder0(.A(s3_c14_carry_r[0]), .B(s3_c14_carry_r[1]), .cin(s3_c14_carry_r[2]), .sum(s4_c15_sum[0]), .cout(s4_c15_carry[0]));
full_adder s4_c15_adder1(.A(s3_c15_sum_r[0]), .B(s3_c15_sum_r[1]), .cin(s3_c15_sum_r[2]), .sum(s4_c15_sum[1]), .cout(s4_c15_carry[1]));

//column 16
logic s4_c16_sum[2], s4_c16_carry[2];
full_adder s4_c16_adder0(.A(s3_c15_carry_r[0]), .B(s3_c15_carry_r[1]), .cin(s3_c15_carry_r[2]), .sum(s4_c16_sum[0]), .cout(s4_c16_carry[0]));
full_adder s4_c16_adder1(.A(s3_c16_sum_r[0]), .B(s3_c16_sum_r[1]), .cin(s3_c16_sum_r[2]), .sum(s4_c16_sum[1]), .cout(s4_c16_carry[1]));

//column 17
logic s4_c17_sum[2], s4_c17_carry[2];
full_adder s4_c17_adder0(.A(s3_c16_carry_r[0]), .B(s3_c16_carry_r[1]), .cin(s3_c16_carry_r[2]), .sum(s4_c17_sum[0]), .cout(s4_c17_carry[0]));
full_adder s4_c17_adder1(.A(s3_c17_sum_r[0]), .B(s3_c17_sum_r[1]), .cin(s3_c17_sum_r[2]), .sum(s4_c17_sum[1]), .cout(s4_c17_carry[1]));

//column 18
logic s4_c18_sum[2], s4_c18_carry[2];
full_adder s4_c18_adder0(.A(s3_c17_carry_r[0]), .B(s3_c17_carry_r[1]), .cin(s3_c17_carry_r[2]), .sum(s4_c18_sum[0]), .cout(s4_c18_carry[0]));
full_adder s4_c18_adder1(.A(s3_c18_sum_r[0]), .B(s3_c18_sum_r[1]), .cin(s3_c18_sum_r[2]), .sum(s4_c18_sum[1]), .cout(s4_c18_carry[1]));

//column 19
logic s4_c19_sum[2], s4_c19_carry[2];
full_adder s4_c19_adder0(.A(s3_c18_carry_r[0]), .B(s3_c18_carry_r[1]), .cin(s3_c18_carry_r[2]), .sum(s4_c19_sum[0]), .cout(s4_c19_carry[0]));
full_adder s4_c19_adder1(.A(s3_c19_sum_r[0]), .B(s3_c19_sum_r[1]), .cin(s3_c19_sum_r[2]), .sum(s4_c19_sum[1]), .cout(s4_c19_carry[1]));

//column 20
logic s4_c20_sum[2], s4_c20_carry[2];
full_adder s4_c20_adder0(.A(s3_c19_carry_r[0]), .B(s3_c19_carry_r[1]), .cin(s3_c19_carry_r[2]), .sum(s4_c20_sum[0]), .cout(s4_c20_carry[0]));
full_adder s4_c20_adder1(.A(s3_c20_sum_r[0]), .B(s3_c20_sum_r[1]), .cin(s3_c20_sum_r[2]), .sum(s4_c20_sum[1]), .cout(s4_c20_carry[1]));

//column 21
logic s4_c21_sum[2], s4_c21_carry[2];
full_adder s4_c21_adder0(.A(s3_c20_carry_r[0]), .B(s3_c20_carry_r[1]), .cin(s3_c20_carry_r[2]), .sum(s4_c21_sum[0]), .cout(s4_c21_carry[0]));
full_adder s4_c21_adder1(.A(s3_c21_sum_r[0]), .B(s3_c21_sum_r[1]), .cin(s3_c21_sum_r[2]), .sum(s4_c21_sum[1]), .cout(s4_c21_carry[1]));

//column 22
logic s4_c22_sum[2], s4_c22_carry[2];
full_adder s4_c22_adder0(.A(s3_c21_carry_r[0]), .B(s3_c21_carry_r[1]), .cin(s3_c21_carry_r[2]), .sum(s4_c22_sum[0]), .cout(s4_c22_carry[0]));
full_adder s4_c22_adder1(.A(s3_c22_sum_r[0]), .B(s3_c22_sum_r[1]), .cin(s3_c22_sum_r[2]), .sum(s4_c22_sum[1]), .cout(s4_c22_carry[1]));

//column 23
logic s4_c23_sum[2], s4_c23_carry[2];
full_adder s4_c23_adder0(.A(s3_c22_carry_r[0]), .B(s3_c22_carry_r[1]), .cin(s3_c22_carry_r[2]), .sum(s4_c23_sum[0]), .cout(s4_c23_carry[0]));
full_adder s4_c23_adder1(.A(s3_c23_sum_r[0]), .B(s3_c23_sum_r[1]), .cin(s3_c23_sum_r[2]), .sum(s4_c23_sum[1]), .cout(s4_c23_carry[1]));

//column 24
logic s4_c24_sum[2], s4_c24_carry[2];
full_adder s4_c24_adder0(.A(s3_c23_carry_r[0]), .B(s3_c23_carry_r[1]), .cin(s3_c23_carry_r[2]), .sum(s4_c24_sum[0]), .cout(s4_c24_carry[0]));
full_adder s4_c24_adder1(.A(s3_c24_sum_r[0]), .B(s3_c24_sum_r[1]), .cin(s3_c24_sum_r[2]), .sum(s4_c24_sum[1]), .cout(s4_c24_carry[1]));

//column 25
logic s4_c25_sum[2], s4_c25_carry[2];
full_adder s4_c25_adder0(.A(s3_c24_carry_r[0]), .B(s3_c24_carry_r[1]), .cin(s3_c24_carry_r[2]), .sum(s4_c25_sum[0]), .cout(s4_c25_carry[0]));
full_adder s4_c25_adder1(.A(s3_c25_sum_r[0]), .B(s3_c25_sum_r[1]), .cin(s3_c25_sum_r[2]), .sum(s4_c25_sum[1]), .cout(s4_c25_carry[1]));

//column 26
logic s4_c26_sum[2], s4_c26_carry[2];
full_adder s4_c26_adder0(.A(s3_c25_carry_r[0]), .B(s3_c25_carry_r[1]), .cin(s3_c25_carry_r[2]), .sum(s4_c26_sum[0]), .cout(s4_c26_carry[0]));
full_adder s4_c26_adder1(.A(s3_c26_sum_r[0]), .B(s3_c26_sum_r[1]), .cin(s3_c26_sum_r[2]), .sum(s4_c26_sum[1]), .cout(s4_c26_carry[1]));

//column 27
logic s4_c27_sum[2], s4_c27_carry[2];
full_adder s4_c27_adder0(.A(s3_c26_carry_r[0]), .B(s3_c26_carry_r[1]), .cin(s3_c26_carry_r[2]), .sum(s4_c27_sum[0]), .cout(s4_c27_carry[0]));
full_adder s4_c27_adder1(.A(s3_c27_sum_r[0]), .B(s3_c27_sum_r[1]), .cin(s3_c27_sum_r[2]), .sum(s4_c27_sum[1]), .cout(s4_c27_carry[1]));

//column 28
logic s4_c28_sum[2], s4_c28_carry[2];
full_adder s4_c28_adder0(.A(s3_c27_carry_r[0]), .B(s3_c27_carry_r[1]), .cin(s3_c27_carry_r[2]), .sum(s4_c28_sum[0]), .cout(s4_c28_carry[0]));
full_adder s4_c28_adder1(.A(s3_c28_sum_r[0]), .B(s3_c28_sum_r[1]), .cin(s3_c28_sum_r[2]), .sum(s4_c28_sum[1]), .cout(s4_c28_carry[1]));

//column 29
logic s4_c29_sum[2], s4_c29_carry[2];
full_adder s4_c29_adder0(.A(s3_c28_carry_r[0]), .B(s3_c28_carry_r[1]), .cin(s3_c28_carry_r[2]), .sum(s4_c29_sum[0]), .cout(s4_c29_carry[0]));
full_adder s4_c29_adder1(.A(s3_c29_sum_r[0]), .B(s3_c29_sum_r[1]), .cin(s3_c29_sum_r[2]), .sum(s4_c29_sum[1]), .cout(s4_c29_carry[1]));

//column 30
logic s4_c30_sum[2], s4_c30_carry[2];
full_adder s4_c30_adder0(.A(s3_c29_carry_r[0]), .B(s3_c29_carry_r[1]), .cin(s3_c29_carry_r[2]), .sum(s4_c30_sum[0]), .cout(s4_c30_carry[0]));
full_adder s4_c30_adder1(.A(s3_c30_sum_r[0]), .B(s3_c30_sum_r[1]), .cin(s3_c30_sum_r[2]), .sum(s4_c30_sum[1]), .cout(s4_c30_carry[1]));

//column 31
logic s4_c31_sum[2], s4_c31_carry[2];
full_adder s4_c31_adder0(.A(s3_c30_carry_r[0]), .B(s3_c30_carry_r[1]), .cin(s3_c30_carry_r[2]), .sum(s4_c31_sum[0]), .cout(s4_c31_carry[0]));
full_adder s4_c31_adder1(.A(s3_c31_sum_r[0]), .B(s3_c31_sum_r[1]), .cin(s3_c31_sum_r[2]), .sum(s4_c31_sum[1]), .cout(s4_c31_carry[1]));

//column 32
logic s4_c32_sum[2], s4_c32_carry[2];
full_adder s4_c32_adder0(.A(s3_c31_carry_r[0]), .B(s3_c31_carry_r[1]), .cin(s3_c31_carry_r[2]), .sum(s4_c32_sum[0]), .cout(s4_c32_carry[0]));
full_adder s4_c32_adder1(.A(s3_c32_sum_r[0]), .B(s3_c32_sum_r[1]), .cin(s3_c32_sum_r[2]), .sum(s4_c32_sum[1]), .cout(s4_c32_carry[1]));

//column 33
logic s4_c33_sum[2], s4_c33_carry[2];
full_adder s4_c33_adder0(.A(s3_c32_carry_r[0]), .B(s3_c32_carry_r[1]), .cin(s3_c32_carry_r[2]), .sum(s4_c33_sum[0]), .cout(s4_c33_carry[0]));
full_adder s4_c33_adder1(.A(s3_c33_sum_r[0]), .B(s3_c33_sum_r[1]), .cin(s3_c33_sum_r[2]), .sum(s4_c33_sum[1]), .cout(s4_c33_carry[1]));

//column 34
logic s4_c34_sum[2], s4_c34_carry[2];
full_adder s4_c34_adder0(.A(s3_c33_carry_r[0]), .B(s3_c33_carry_r[1]), .cin(s3_c33_carry_r[2]), .sum(s4_c34_sum[0]), .cout(s4_c34_carry[0]));
full_adder s4_c34_adder1(.A(s3_c34_sum_r[0]), .B(s3_c34_sum_r[1]), .cin(s3_c34_sum_r[2]), .sum(s4_c34_sum[1]), .cout(s4_c34_carry[1]));

//column 35
logic s4_c35_sum[2], s4_c35_carry[2];
full_adder s4_c35_adder0(.A(s3_c34_carry_r[0]), .B(s3_c34_carry_r[1]), .cin(s3_c34_carry_r[2]), .sum(s4_c35_sum[0]), .cout(s4_c35_carry[0]));
full_adder s4_c35_adder1(.A(s3_c35_sum_r[0]), .B(s3_c35_sum_r[1]), .cin(s3_c35_sum_r[2]), .sum(s4_c35_sum[1]), .cout(s4_c35_carry[1]));

//column 36
logic s4_c36_sum[2], s4_c36_carry[2];
full_adder s4_c36_adder0(.A(s3_c35_carry_r[0]), .B(s3_c35_carry_r[1]), .cin(s3_c35_carry_r[2]), .sum(s4_c36_sum[0]), .cout(s4_c36_carry[0]));
full_adder s4_c36_adder1(.A(s3_c36_sum_r[0]), .B(s3_c36_sum_r[1]), .cin(s3_c36_sum_r[2]), .sum(s4_c36_sum[1]), .cout(s4_c36_carry[1]));

//column 37
logic s4_c37_sum[2], s4_c37_carry[2];
full_adder s4_c37_adder0(.A(s3_c36_carry_r[0]), .B(s3_c36_carry_r[1]), .cin(s3_c36_carry_r[2]), .sum(s4_c37_sum[0]), .cout(s4_c37_carry[0]));
full_adder s4_c37_adder1(.A(s3_c37_sum_r[0]), .B(s3_c37_sum_r[1]), .cin(s3_c37_sum_r[2]), .sum(s4_c37_sum[1]), .cout(s4_c37_carry[1]));

//column 38
logic s4_c38_sum[2], s4_c38_carry[2];
full_adder s4_c38_adder0(.A(s3_c37_carry_r[0]), .B(s3_c37_carry_r[1]), .cin(s3_c37_carry_r[2]), .sum(s4_c38_sum[0]), .cout(s4_c38_carry[0]));
full_adder s4_c38_adder1(.A(s3_c38_sum_r[0]), .B(s3_c38_sum_r[1]), .cin(s3_c38_sum_r[2]), .sum(s4_c38_sum[1]), .cout(s4_c38_carry[1]));

//column 39
logic s4_c39_sum[2], s4_c39_carry[2];
full_adder s4_c39_adder0(.A(s3_c38_carry_r[0]), .B(s3_c38_carry_r[1]), .cin(s3_c38_carry_r[2]), .sum(s4_c39_sum[0]), .cout(s4_c39_carry[0]));
full_adder s4_c39_adder1(.A(s3_c39_sum_r[0]), .B(s3_c39_sum_r[1]), .cin(s3_c39_sum_r[2]), .sum(s4_c39_sum[1]), .cout(s4_c39_carry[1]));

//column 40
logic s4_c40_sum[2], s4_c40_carry[2];
full_adder s4_c40_adder0(.A(s3_c39_carry_r[0]), .B(s3_c39_carry_r[1]), .cin(s3_c39_carry_r[2]), .sum(s4_c40_sum[0]), .cout(s4_c40_carry[0]));
full_adder s4_c40_adder1(.A(s3_c40_sum_r[0]), .B(s3_c40_sum_r[1]), .cin(pp23_17_r), .sum(s4_c40_sum[1]), .cout(s4_c40_carry[1]));

//column 41
logic s4_c41_sum[2], s4_c41_carry[2];
full_adder s4_c41_adder0(.A(s3_c40_carry_r[0]), .B(s3_c40_carry_r[1]), .cin(s3_c41_sum_r), .sum(s4_c41_sum[0]), .cout(s4_c41_carry[0]));
full_adder s4_c41_adder1(.A(pp21_20_r), .B(pp22_19_r), .cin(pp23_18_r), .sum(s4_c41_sum[1]), .cout(s4_c41_carry[1]));

//column 42
logic s4_c42_sum[2], s4_c42_carry[2];
full_adder s4_c42_adder0(.A(s3_c41_carry_r), .B(pp19_23_r), .cin(pp20_22_r), .sum(s4_c42_sum[0]), .cout(s4_c42_carry[0]));
full_adder s4_c42_adder1(.A(pp21_21_r), .B(pp22_20_r), .cin(pp23_19_r), .sum(s4_c42_sum[1]), .cout(s4_c42_carry[1]));

//column 43
logic s4_c43_sum, s4_c43_carry;
full_adder s4_c43_adder0(.A(pp20_23_r), .B(pp21_22_r), .cin(pp22_21_r), .sum(s4_c43_sum), .cout(s4_c43_carry));

//stage 5 reduce to 3

//column 3
logic s5_c3_sum, s5_c3_carry;
half_adder s5_c3_adder0(.A(pp0_3_r), .B(pp1_2_r), .sum(s5_c3_sum), .cout(s5_c3_carry));

//column 4
logic s5_c4_sum, s5_c4_carry;
full_adder s5_c4_adder0(.A(s4_c4_sum), .B(pp2_2_r), .cin(pp3_1_r), .sum(s5_c4_sum), .cout(s5_c4_carry));

//column 5
logic s5_c5_sum, s5_c5_carry;
full_adder s5_c5_adder0(.A(s4_c5_sum[0]), .B(s4_c5_sum[1]), .cin(pp5_0_r), .sum(s5_c5_sum), .cout(s5_c5_carry));

//column 6
logic s5_c6_sum, s5_c6_carry;
full_adder s5_c6_adder0(.A(s4_c6_sum[0]), .B(s4_c6_sum[1]), .cin(s4_c5_carry[0]), .sum(s5_c6_sum), .cout(s5_c6_carry));

//column 7
logic s5_c7_sum, s5_c7_carry;
full_adder s5_c7_adder0(.A(s4_c7_sum[0]), .B(s4_c7_sum[1]), .cin(s4_c6_carry[0]), .sum(s5_c7_sum), .cout(s5_c7_carry));

//column 8
logic s5_c8_sum, s5_c8_carry;
full_adder s5_c8_adder0(.A(s4_c8_sum[0]), .B(s4_c8_sum[1]), .cin(s4_c7_carry[0]), .sum(s5_c8_sum), .cout(s5_c8_carry));

//column 9
logic s5_c9_sum, s5_c9_carry;
full_adder s5_c9_adder0(.A(s4_c9_sum[0]), .B(s4_c9_sum[1]), .cin(s4_c8_carry[0]), .sum(s5_c9_sum), .cout(s5_c9_carry));

//column 10
logic s5_c10_sum, s5_c10_carry;
full_adder s5_c10_adder0(.A(s4_c10_sum[0]), .B(s4_c10_sum[1]), .cin(s4_c9_carry[0]), .sum(s5_c10_sum), .cout(s5_c10_carry));

//column 11
logic s5_c11_sum, s5_c11_carry;
full_adder s5_c11_adder0(.A(s4_c11_sum[0]), .B(s4_c11_sum[1]), .cin(s4_c10_carry[0]), .sum(s5_c11_sum), .cout(s5_c11_carry));

//column 12
logic s5_c12_sum, s5_c12_carry;
full_adder s5_c12_adder0(.A(s4_c12_sum[0]), .B(s4_c12_sum[1]), .cin(s4_c11_carry[0]), .sum(s5_c12_sum), .cout(s5_c12_carry));

//column 13
logic s5_c13_sum, s5_c13_carry;
full_adder s5_c13_adder0(.A(s4_c13_sum[0]), .B(s4_c13_sum[1]), .cin(s4_c12_carry[0]), .sum(s5_c13_sum), .cout(s5_c13_carry));

//column 14
logic s5_c14_sum, s5_c14_carry;
full_adder s5_c14_adder0(.A(s4_c14_sum[0]), .B(s4_c14_sum[1]), .cin(s4_c13_carry[0]), .sum(s5_c14_sum), .cout(s5_c14_carry));

//column 15
logic s5_c15_sum, s5_c15_carry;
full_adder s5_c15_adder0(.A(s4_c15_sum[0]), .B(s4_c15_sum[1]), .cin(s4_c14_carry[0]), .sum(s5_c15_sum), .cout(s5_c15_carry));

//column 16
logic s5_c16_sum, s5_c16_carry;
full_adder s5_c16_adder0(.A(s4_c16_sum[0]), .B(s4_c16_sum[1]), .cin(s4_c15_carry[0]), .sum(s5_c16_sum), .cout(s5_c16_carry));

//column 17
logic s5_c17_sum, s5_c17_carry;
full_adder s5_c17_adder0(.A(s4_c17_sum[0]), .B(s4_c17_sum[1]), .cin(s4_c16_carry[0]), .sum(s5_c17_sum), .cout(s5_c17_carry));

//column 18
logic s5_c18_sum, s5_c18_carry;
full_adder s5_c18_adder0(.A(s4_c18_sum[0]), .B(s4_c18_sum[1]), .cin(s4_c17_carry[0]), .sum(s5_c18_sum), .cout(s5_c18_carry));

//column 19
logic s5_c19_sum, s5_c19_carry;
full_adder s5_c19_adder0(.A(s4_c19_sum[0]), .B(s4_c19_sum[1]), .cin(s4_c18_carry[0]), .sum(s5_c19_sum), .cout(s5_c19_carry));

//column 20
logic s5_c20_sum, s5_c20_carry;
full_adder s5_c20_adder0(.A(s4_c20_sum[0]), .B(s4_c20_sum[1]), .cin(s4_c19_carry[0]), .sum(s5_c20_sum), .cout(s5_c20_carry));

//column 21
logic s5_c21_sum, s5_c21_carry;
full_adder s5_c21_adder0(.A(s4_c21_sum[0]), .B(s4_c21_sum[1]), .cin(s4_c20_carry[0]), .sum(s5_c21_sum), .cout(s5_c21_carry));

//column 22
logic s5_c22_sum, s5_c22_carry;
full_adder s5_c22_adder0(.A(s4_c22_sum[0]), .B(s4_c22_sum[1]), .cin(s4_c21_carry[0]), .sum(s5_c22_sum), .cout(s5_c22_carry));

//column 23
logic s5_c23_sum, s5_c23_carry;
full_adder s5_c23_adder0(.A(s4_c23_sum[0]), .B(s4_c23_sum[1]), .cin(s4_c22_carry[0]), .sum(s5_c23_sum), .cout(s5_c23_carry));

//column 24
logic s5_c24_sum, s5_c24_carry;
full_adder s5_c24_adder0(.A(s4_c24_sum[0]), .B(s4_c24_sum[1]), .cin(s4_c23_carry[0]), .sum(s5_c24_sum), .cout(s5_c24_carry));

//column 25
logic s5_c25_sum, s5_c25_carry;
full_adder s5_c25_adder0(.A(s4_c25_sum[0]), .B(s4_c25_sum[1]), .cin(s4_c24_carry[0]), .sum(s5_c25_sum), .cout(s5_c25_carry));

//column 26
logic s5_c26_sum, s5_c26_carry;
full_adder s5_c26_adder0(.A(s4_c26_sum[0]), .B(s4_c26_sum[1]), .cin(s4_c25_carry[0]), .sum(s5_c26_sum), .cout(s5_c26_carry));

//column 27
logic s5_c27_sum, s5_c27_carry;
full_adder s5_c27_adder0(.A(s4_c27_sum[0]), .B(s4_c27_sum[1]), .cin(s4_c26_carry[0]), .sum(s5_c27_sum), .cout(s5_c27_carry));

//column 28
logic s5_c28_sum, s5_c28_carry;
full_adder s5_c28_adder0(.A(s4_c28_sum[0]), .B(s4_c28_sum[1]), .cin(s4_c27_carry[0]), .sum(s5_c28_sum), .cout(s5_c28_carry));

//column 29
logic s5_c29_sum, s5_c29_carry;
full_adder s5_c29_adder0(.A(s4_c29_sum[0]), .B(s4_c29_sum[1]), .cin(s4_c28_carry[0]), .sum(s5_c29_sum), .cout(s5_c29_carry));

//column 30
logic s5_c30_sum, s5_c30_carry;
full_adder s5_c30_adder0(.A(s4_c30_sum[0]), .B(s4_c30_sum[1]), .cin(s4_c29_carry[0]), .sum(s5_c30_sum), .cout(s5_c30_carry));

//column 31
logic s5_c31_sum, s5_c31_carry;
full_adder s5_c31_adder0(.A(s4_c31_sum[0]), .B(s4_c31_sum[1]), .cin(s4_c30_carry[0]), .sum(s5_c31_sum), .cout(s5_c31_carry));

//column 32
logic s5_c32_sum, s5_c32_carry;
full_adder s5_c32_adder0(.A(s4_c32_sum[0]), .B(s4_c32_sum[1]), .cin(s4_c31_carry[0]), .sum(s5_c32_sum), .cout(s5_c32_carry));

//column 33
logic s5_c33_sum, s5_c33_carry;
full_adder s5_c33_adder0(.A(s4_c33_sum[0]), .B(s4_c33_sum[1]), .cin(s4_c32_carry[0]), .sum(s5_c33_sum), .cout(s5_c33_carry));

//column 34
logic s5_c34_sum, s5_c34_carry;
full_adder s5_c34_adder0(.A(s4_c34_sum[0]), .B(s4_c34_sum[1]), .cin(s4_c33_carry[0]), .sum(s5_c34_sum), .cout(s5_c34_carry));

//column 35
logic s5_c35_sum, s5_c35_carry;
full_adder s5_c35_adder0(.A(s4_c35_sum[0]), .B(s4_c35_sum[1]), .cin(s4_c34_carry[0]), .sum(s5_c35_sum), .cout(s5_c35_carry));

//column 36
logic s5_c36_sum, s5_c36_carry;
full_adder s5_c36_adder0(.A(s4_c36_sum[0]), .B(s4_c36_sum[1]), .cin(s4_c35_carry[0]), .sum(s5_c36_sum), .cout(s5_c36_carry));

//column 37
logic s5_c37_sum, s5_c37_carry;
full_adder s5_c37_adder0(.A(s4_c37_sum[0]), .B(s4_c37_sum[1]), .cin(s4_c36_carry[0]), .sum(s5_c37_sum), .cout(s5_c37_carry));

//column 38
logic s5_c38_sum, s5_c38_carry;
full_adder s5_c38_adder0(.A(s4_c38_sum[0]), .B(s4_c38_sum[1]), .cin(s4_c37_carry[0]), .sum(s5_c38_sum), .cout(s5_c38_carry));

//column 39
logic s5_c39_sum, s5_c39_carry;
full_adder s5_c39_adder0(.A(s4_c39_sum[0]), .B(s4_c39_sum[1]), .cin(s4_c38_carry[0]), .sum(s5_c39_sum), .cout(s5_c39_carry));

//column 40
logic s5_c40_sum, s5_c40_carry;
full_adder s5_c40_adder0(.A(s4_c40_sum[0]), .B(s4_c40_sum[1]), .cin(s4_c39_carry[0]), .sum(s5_c40_sum), .cout(s5_c40_carry));

//column 41
logic s5_c41_sum, s5_c41_carry;
full_adder s5_c41_adder0(.A(s4_c41_sum[0]), .B(s4_c41_sum[1]), .cin(s4_c40_carry[0]), .sum(s5_c41_sum), .cout(s5_c41_carry));

//column 42
logic s5_c42_sum, s5_c42_carry;
full_adder s5_c42_adder0(.A(s4_c42_sum[0]), .B(s4_c42_sum[1]), .cin(s4_c41_carry[0]), .sum(s5_c42_sum), .cout(s5_c42_carry));

//column 43
logic s5_c43_sum, s5_c43_carry;
full_adder s5_c43_adder0(.A(s4_c43_sum), .B(s4_c42_carry[0]), .cin(pp23_20_r), .sum(s5_c43_sum), .cout(s5_c43_carry));

//column 44
logic s5_c44_sum, s5_c44_carry;
full_adder s5_c44_adder0(.A(s4_c43_carry), .B(pp21_23_r), .cin(pp22_22_r), .sum(s5_c44_sum), .cout(s5_c44_carry));

//stage 6 reduce to 2

//column 2
logic s6_c2_sum, s6_c2_carry;
half_adder s6_c2_adder0(.A(pp0_2_r), .B(pp1_1_r), .sum(s6_c2_sum), .cout(s6_c2_carry));

//column 3
logic s6_c3_sum, s6_c3_carry;
full_adder s6_c3_adder0(.A(pp2_1_r), .B(pp3_0_r), .cin(s5_c3_sum), .sum(s6_c3_sum), .cout(s6_c3_carry));

//column 4
logic s6_c4_sum, s6_c4_carry;
full_adder s6_c4_adder0(.A(pp4_0_r), .B(s5_c3_carry), .cin(s5_c4_sum), .sum(s6_c4_sum), .cout(s6_c4_carry));

//column 5 
logic s6_c5_sum, s6_c5_carry;
full_adder s6_c5_adder0(.A(s5_c5_sum), .B(s5_c4_carry), .cin(s4_c4_carry), .sum(s6_c5_sum), .cout(s6_c5_carry));

//column 6
logic s6_c6_sum, s6_c6_carry;
full_adder s6_c6_adder0(.A(s5_c6_sum), .B(s5_c5_carry), .cin(s4_c5_carry[1]), .sum(s6_c6_sum), .cout(s6_c6_carry));

//column 7
logic s6_c7_sum, s6_c7_carry;
full_adder s6_c7_adder0(.A(s5_c7_sum), .B(s5_c6_carry), .cin(s4_c6_carry[1]), .sum(s6_c7_sum), .cout(s6_c7_carry));

//column 8
logic s6_c8_sum, s6_c8_carry;
full_adder s6_c8_adder0(.A(s5_c8_sum), .B(s5_c7_carry), .cin(s4_c7_carry[1]), .sum(s6_c8_sum), .cout(s6_c8_carry));

//column 9
logic s6_c9_sum, s6_c9_carry;
full_adder s6_c9_adder0(.A(s5_c9_sum), .B(s5_c8_carry), .cin(s4_c8_carry[1]), .sum(s6_c9_sum), .cout(s6_c9_carry));

//column 10
logic s6_c10_sum, s6_c10_carry;
full_adder s6_c10_adder0(.A(s5_c10_sum), .B(s5_c9_carry), .cin(s4_c9_carry[1]), .sum(s6_c10_sum), .cout(s6_c10_carry));

//column 11
logic s6_c11_sum, s6_c11_carry;
full_adder s6_c11_adder0(.A(s5_c11_sum), .B(s5_c10_carry), .cin(s4_c10_carry[1]), .sum(s6_c11_sum), .cout(s6_c11_carry));

//column 12
logic s6_c12_sum, s6_c12_carry;
full_adder s6_c12_adder0(.A(s5_c12_sum), .B(s5_c11_carry), .cin(s4_c11_carry[1]), .sum(s6_c12_sum), .cout(s6_c12_carry));

//column 13
logic s6_c13_sum, s6_c13_carry;
full_adder s6_c13_adder0(.A(s5_c13_sum), .B(s5_c12_carry), .cin(s4_c12_carry[1]), .sum(s6_c13_sum), .cout(s6_c13_carry));

//column 14
logic s6_c14_sum, s6_c14_carry;
full_adder s6_c14_adder0(.A(s5_c14_sum), .B(s5_c13_carry), .cin(s4_c13_carry[1]), .sum(s6_c14_sum), .cout(s6_c14_carry));

//column 15
logic s6_c15_sum, s6_c15_carry;
full_adder s6_c15_adder0(.A(s5_c15_sum), .B(s5_c14_carry), .cin(s4_c14_carry[1]), .sum(s6_c15_sum), .cout(s6_c15_carry));

//column 16
logic s6_c16_sum, s6_c16_carry;
full_adder s6_c16_adder0(.A(s5_c16_sum), .B(s5_c15_carry), .cin(s4_c15_carry[1]), .sum(s6_c16_sum), .cout(s6_c16_carry));

//column 17
logic s6_c17_sum, s6_c17_carry;
full_adder s6_c17_adder0(.A(s5_c17_sum), .B(s5_c16_carry), .cin(s4_c16_carry[1]), .sum(s6_c17_sum), .cout(s6_c17_carry));

//column 18
logic s6_c18_sum, s6_c18_carry;
full_adder s6_c18_adder0(.A(s5_c18_sum), .B(s5_c17_carry), .cin(s4_c17_carry[1]), .sum(s6_c18_sum), .cout(s6_c18_carry));

//column 19
logic s6_c19_sum, s6_c19_carry;
full_adder s6_c19_adder0(.A(s5_c19_sum), .B(s5_c18_carry), .cin(s4_c18_carry[1]), .sum(s6_c19_sum), .cout(s6_c19_carry));

//column 20
logic s6_c20_sum, s6_c20_carry;
full_adder s6_c20_adder0(.A(s5_c20_sum), .B(s5_c19_carry), .cin(s4_c19_carry[1]), .sum(s6_c20_sum), .cout(s6_c20_carry));

//column 21
logic s6_c21_sum, s6_c21_carry;
full_adder s6_c21_adder0(.A(s5_c21_sum), .B(s5_c20_carry), .cin(s4_c20_carry[1]), .sum(s6_c21_sum), .cout(s6_c21_carry));

//column 22
logic s6_c22_sum, s6_c22_carry;
full_adder s6_c22_adder0(.A(s5_c22_sum), .B(s5_c21_carry), .cin(s4_c21_carry[1]), .sum(s6_c22_sum), .cout(s6_c22_carry));

//column 23
logic s6_c23_sum, s6_c23_carry;
full_adder s6_c23_adder0(.A(s5_c23_sum), .B(s5_c22_carry), .cin(s4_c22_carry[1]), .sum(s6_c23_sum), .cout(s6_c23_carry));

//column 24
logic s6_c24_sum, s6_c24_carry;
full_adder s6_c24_adder0(.A(s5_c24_sum), .B(s5_c23_carry), .cin(s4_c23_carry[1]), .sum(s6_c24_sum), .cout(s6_c24_carry));

//column 25
logic s6_c25_sum, s6_c25_carry;
full_adder s6_c25_adder0(.A(s5_c25_sum), .B(s5_c24_carry), .cin(s4_c24_carry[1]), .sum(s6_c25_sum), .cout(s6_c25_carry));

//column 26
logic s6_c26_sum, s6_c26_carry;
full_adder s6_c26_adder0(.A(s5_c26_sum), .B(s5_c25_carry), .cin(s4_c25_carry[1]), .sum(s6_c26_sum), .cout(s6_c26_carry));

//column 27
logic s6_c27_sum, s6_c27_carry;
full_adder s6_c27_adder0(.A(s5_c27_sum), .B(s5_c26_carry), .cin(s4_c26_carry[1]), .sum(s6_c27_sum), .cout(s6_c27_carry));

//column 28
logic s6_c28_sum, s6_c28_carry;
full_adder s6_c28_adder0(.A(s5_c28_sum), .B(s5_c27_carry), .cin(s4_c27_carry[1]), .sum(s6_c28_sum), .cout(s6_c28_carry));

//column 29
logic s6_c29_sum, s6_c29_carry;
full_adder s6_c29_adder0(.A(s5_c29_sum), .B(s5_c28_carry), .cin(s4_c28_carry[1]), .sum(s6_c29_sum), .cout(s6_c29_carry));

//column 30
logic s6_c30_sum, s6_c30_carry;
full_adder s6_c30_adder0(.A(s5_c30_sum), .B(s5_c29_carry), .cin(s4_c29_carry[1]), .sum(s6_c30_sum), .cout(s6_c30_carry));

//column 31
logic s6_c31_sum, s6_c31_carry;
full_adder s6_c31_adder0(.A(s5_c31_sum), .B(s5_c30_carry), .cin(s4_c30_carry[1]), .sum(s6_c31_sum), .cout(s6_c31_carry));

//column 32
logic s6_c32_sum, s6_c32_carry;
full_adder s6_c32_adder0(.A(s5_c32_sum), .B(s5_c31_carry), .cin(s4_c31_carry[1]), .sum(s6_c32_sum), .cout(s6_c32_carry));

//column 33
logic s6_c33_sum, s6_c33_carry;
full_adder s6_c33_adder0(.A(s5_c33_sum), .B(s5_c32_carry), .cin(s4_c32_carry[1]), .sum(s6_c33_sum), .cout(s6_c33_carry));

//column 34
logic s6_c34_sum, s6_c34_carry;
full_adder s6_c34_adder0(.A(s5_c34_sum), .B(s5_c33_carry), .cin(s4_c33_carry[1]), .sum(s6_c34_sum), .cout(s6_c34_carry));

//column 35
logic s6_c35_sum, s6_c35_carry;
full_adder s6_c35_adder0(.A(s5_c35_sum), .B(s5_c34_carry), .cin(s4_c34_carry[1]), .sum(s6_c35_sum), .cout(s6_c35_carry));

//column 36
logic s6_c36_sum, s6_c36_carry;
full_adder s6_c36_adder0(.A(s5_c36_sum), .B(s5_c35_carry), .cin(s4_c35_carry[1]), .sum(s6_c36_sum), .cout(s6_c36_carry));

//column 37
logic s6_c37_sum, s6_c37_carry;
full_adder s6_c37_adder0(.A(s5_c37_sum), .B(s5_c36_carry), .cin(s4_c36_carry[1]), .sum(s6_c37_sum), .cout(s6_c37_carry));

//column 38
logic s6_c38_sum, s6_c38_carry;
full_adder s6_c38_adder0(.A(s5_c38_sum), .B(s5_c37_carry), .cin(s4_c37_carry[1]), .sum(s6_c38_sum), .cout(s6_c38_carry));

//column 39
logic s6_c39_sum, s6_c39_carry;
full_adder s6_c39_adder0(.A(s5_c39_sum), .B(s5_c38_carry), .cin(s4_c38_carry[1]), .sum(s6_c39_sum), .cout(s6_c39_carry));

//column 40
logic s6_c40_sum, s6_c40_carry;
full_adder s6_c40_adder0(.A(s5_c40_sum), .B(s5_c39_carry), .cin(s4_c39_carry[1]), .sum(s6_c40_sum), .cout(s6_c40_carry));

//column 41
logic s6_c41_sum, s6_c41_carry;
full_adder s6_c41_adder0(.A(s5_c41_sum), .B(s5_c40_carry), .cin(s4_c40_carry[1]), .sum(s6_c41_sum), .cout(s6_c41_carry));

//column 42
logic s6_c42_sum, s6_c42_carry;
full_adder s6_c42_adder0(.A(s5_c42_sum), .B(s5_c41_carry), .cin(s4_c41_carry[1]), .sum(s6_c42_sum), .cout(s6_c42_carry));

//column 43
logic s6_c43_sum, s6_c43_carry;
full_adder s6_c43_adder0(.A(s5_c43_sum), .B(s5_c42_carry), .cin(s4_c42_carry[1]), .sum(s6_c43_sum), .cout(s6_c43_carry));

//column 44
logic s6_c44_sum, s6_c44_carry;
full_adder s6_c44_adder0(.A(s5_c44_sum), .B(s5_c43_carry), .cin(pp23_21_r), .sum(s6_c44_sum), .cout(s6_c44_carry));

//column 45
logic s6_c45_sum, s6_c45_carry;
full_adder s6_c45_adder0(.A(pp22_23_r), .B(pp23_22_r), .cin(s5_c44_carry), .sum(s6_c45_sum), .cout(s6_c45_carry));

logic[45:0] adder_in1, adder_in2;

//stage 7, final addition

assign adder_in1 = {s6_c45_carry, s6_c44_carry, s6_c43_carry, s6_c42_carry, s6_c41_carry, s6_c40_carry,
s6_c39_carry, s6_c38_carry, s6_c37_carry, s6_c36_carry, s6_c35_carry, s6_c34_carry, s6_c33_carry, s6_c32_carry, s6_c31_carry, s6_c30_carry,
s6_c29_carry, s6_c28_carry, s6_c27_carry, s6_c26_carry, s6_c25_carry, s6_c24_carry, s6_c23_carry, s6_c22_carry, s6_c21_carry, s6_c20_carry,
s6_c19_carry, s6_c18_carry, s6_c17_carry, s6_c16_carry, s6_c15_carry, s6_c14_carry, s6_c13_carry, s6_c12_carry, s6_c11_carry, s6_c10_carry,
s6_c9_carry, s6_c8_carry, s6_c7_carry, s6_c6_carry, s6_c5_carry, s6_c4_carry, s6_c3_carry, s6_c2_carry, s6_c2_sum, pp0_1_r};


assign adder_in2 = {pp23_23_r, s6_c45_sum, s6_c44_sum, s6_c43_sum, s6_c42_sum, s6_c41_sum, s6_c40_sum,
s6_c39_sum, s6_c38_sum, s6_c37_sum, s6_c36_sum, s6_c35_sum, s6_c34_sum, s6_c33_sum, s6_c32_sum, s6_c31_sum, s6_c30_sum,
s6_c29_sum, s6_c28_sum, s6_c27_sum, s6_c26_sum, s6_c25_sum, s6_c24_sum, s6_c23_sum, s6_c22_sum, s6_c21_sum, s6_c20_sum,
s6_c19_sum, s6_c18_sum, s6_c17_sum, s6_c16_sum, s6_c15_sum, s6_c14_sum, s6_c13_sum, s6_c12_sum, s6_c11_sum, s6_c10_sum,
s6_c9_sum, s6_c8_sum, s6_c7_sum, s6_c6_sum, s6_c5_sum, s6_c4_sum, s6_c3_sum, pp2_0_r, pp1_0_r};


logic[45:0] adder_sum;
logic adder_carry;
KSA_nbits #(.WIDTH(46)) Adder (.in1(adder_in1), .in2(adder_in2), .out(adder_sum), .cout(adder_carry));
always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        out <= '0;
    end else begin
        out <= {adder_carry, adder_sum, pp0_0_r};
    end
end
endmodule

//make a 28 bit one
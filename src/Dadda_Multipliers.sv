//I apologize anyone who is reading this I really have no idea how i would parameterize this

module Dadda_Multiplier_8bit (
    input logic[7:0] in1, in2,
    output logic[15:0] out
);
//partial products
logic[7:0] pp[7:0];

genvar i,j;
generate
    for(i = 0; i < 8; i++) begin
        for(j = 0; j < 8; j++) begin
            assign pp[i][j] = in1[j] & in2[i]; 
        end
    end
endgenerate
//pp positions are known by the ordering of i incrementing and a given column
//is compromised by all pp where i + j = column position

//for example, column 4 (bit 3) contains pp[0][3] pp[1][2] pp[2][1] pp[3][0]


//reduction tree stages
//stage 0 (height of 8) reduce to height of 6

//column 6
logic s0_c6_adder0_sum, s0_c6_adder0_carry;
half_adder s0_c6_adder0(.A(pp[0][6]), .B(pp[1][5]), .sum(s0_c6_adder0_sum), .cout(s0_c6_adder0_carry));

//column 7
logic s0_c7_adder0_sum, s0_c7_adder0_carry;
full_adder s0_c7_adder0 (.A(pp[0][7]), .B(pp[1][6]), .cin(pp[2][5]) , .sum(s0_c7_adder0_sum), .cout(s0_c7_adder0_carry));

logic s0_c7_adder1_sum, s0_c7_adder1_carry;
half_adder s0_c7_adder1 (.A(pp[3][4]), .B(pp[4][3]), .sum(s0_c7_adder1_sum), .cout(s0_c7_adder1_carry));

//column 8
logic s0_c8_adder0_sum, s0_c8_adder0_carry;
full_adder s0_c8_adder0 (.A(pp[1][7]), .B(pp[2][6]), .cin(pp[3][5]) , .sum(s0_c8_adder0_sum), .cout(s0_c8_adder0_carry));

logic s0_c8_adder1_sum, s0_c8_adder1_carry;
half_adder s0_c8_adder1 (.A(pp[4][4]), .B(pp[5][3]), .sum(s0_c8_adder1_sum), .cout(s0_c8_adder1_carry));

//column 9
logic s0_c9_adder0_sum, s0_c9_adder0_carry;
full_adder s0_c9_adder0 (.A(pp[2][7]), .B(pp[3][6]), .cin(pp[4][5]) , .sum(s0_c9_adder0_sum), .cout(s0_c9_adder0_carry));

//stage 1 reduce height to 4

//column 4
logic s1_c4_adder0_sum, s1_c4_adder0_carry;
half_adder s1_c4_adder0(.A(pp[0][4]), .B(pp[1][3]), .sum(s1_c4_adder0_sum), .cout(s1_c4_adder0_carry));

//column 5
logic s1_c5_adder0_sum, s1_c5_adder0_carry;
full_adder s1_c5_adder0 (.A(pp[0][5]), .B(pp[1][4]), .cin(pp[2][3]) , .sum(s1_c5_adder0_sum), .cout(s1_c5_adder0_carry));

logic s1_c5_adder1_sum, s1_c5_adder1_carry;
half_adder s1_c5_adder1 (.A(pp[3][2]), .B(pp[4][1]), .sum(s1_c5_adder1_sum), .cout(s1_c5_adder1_carry));

//column 6
logic s1_c6_adder0_sum, s1_c6_adder0_carry;
full_adder s1_c6_adder0 (.A(s0_c6_adder0_sum), .B(pp[2][4]), .cin(pp[3][3]) , .sum(s1_c6_adder0_sum), .cout(s1_c6_adder0_carry));

logic s1_c6_adder1_sum, s1_c6_adder1_carry;
full_adder s1_c6_adder1 (.A(pp[4][2]), .B(pp[5][1]), .cin(pp[6][0]) , .sum(s1_c6_adder1_sum), .cout(s1_c6_adder1_carry));

//column 7
logic s1_c7_adder0_sum, s1_c7_adder0_carry;
full_adder s1_c7_adder0 (.A(s0_c6_adder0_carry), .B(s0_c7_adder0_sum), .cin(s0_c7_adder1_sum), .sum(s1_c7_adder0_sum), .cout(s1_c7_adder0_carry));

logic s1_c7_adder1_sum, s1_c7_adder1_carry;
full_adder s1_c7_adder1 (.A(pp[5][2]), .B(pp[6][1]), .cin(pp[7][0]), .sum(s1_c7_adder1_sum), .cout(s1_c7_adder1_carry));

//column 8
logic s1_c8_adder0_sum, s1_c8_adder0_carry;
full_adder s1_c8_adder0 (.A(s0_c7_adder0_carry), .B(s0_c7_adder1_carry), .cin(s0_c8_adder0_sum), .sum(s1_c8_adder0_sum), .cout(s1_c8_adder0_carry));

logic s1_c8_adder1_sum, s1_c8_adder1_carry;
full_adder s1_c8_adder1 (.A(s0_c8_adder1_sum), .B(pp[6][2]), .cin(pp[7][1]), .sum(s1_c8_adder1_sum), .cout(s1_c8_adder1_carry));

//column 9
logic s1_c9_adder0_sum, s1_c9_adder0_carry;
full_adder s1_c9_adder0 (.A(s0_c8_adder0_carry), .B(s0_c8_adder1_carry), .cin(s0_c9_adder0_sum), .sum(s1_c9_adder0_sum), .cout(s1_c9_adder0_carry));

logic s1_c9_adder1_sum, s1_c9_adder1_carry;
full_adder s1_c9_adder1 (.A(pp[5][4]), .B(pp[6][3]), .cin(pp[7][2]), .sum(s1_c9_adder1_sum), .cout(s1_c9_adder1_carry));

//column 10
logic s1_c10_adder0_sum, s1_c10_adder0_carry;
full_adder s1_c10_adder0 (.A(s0_c9_adder0_carry), .B(pp[3][7]), .cin(pp[4][6]), .sum(s1_c10_adder0_sum), .cout(s1_c10_adder0_carry));

logic s1_c10_adder1_sum, s1_c10_adder1_carry;
full_adder s1_c10_adder1 (.A(pp[5][5]), .B(pp[6][4]), .cin(pp[7][3]), .sum(s1_c10_adder1_sum), .cout(s1_c10_adder1_carry));

//column 11
logic s1_c11_adder0_sum, s1_c11_adder0_carry;
full_adder s1_c11_adder0 (.A(pp[4][7]), .B(pp[5][6]), .cin(pp[6][5]), .sum(s1_c11_adder0_sum), .cout(s1_c11_adder0_carry));

//stage 2 reduce height to 3

//column 3
logic s2_c3_adder0_sum, s2_c3_adder0_carry;
half_adder s2_c3_adder0(.A(pp[0][3]), .B(pp[1][2]), .sum(s2_c3_adder0_sum), .cout(s2_c3_adder0_carry));

//column 4
logic s2_c4_adder0_sum, s2_c4_adder0_carry;
full_adder s2_c4_adder0 (.A(s1_c4_adder0_sum), .B(pp[2][2]), .cin(pp[3][1]), .sum(s2_c4_adder0_sum), .cout(s2_c4_adder0_carry));

//column 5
logic s2_c5_adder0_sum, s2_c5_adder0_carry;
full_adder s2_c5_adder0 (.A(s1_c4_adder0_carry), .B(s1_c5_adder0_sum), .cin(s1_c5_adder1_sum), .sum(s2_c5_adder0_sum), .cout(s2_c5_adder0_carry));

//column 6
logic s2_c6_adder0_sum, s2_c6_adder0_carry;
full_adder s2_c6_adder0 (.A(s1_c5_adder0_carry), .B(s1_c5_adder1_carry), .cin(s1_c6_adder0_sum), .sum(s2_c6_adder0_sum), .cout(s2_c6_adder0_carry));

//column 7
logic s2_c7_adder0_sum, s2_c7_adder0_carry;
full_adder s2_c7_adder0 (.A(s1_c6_adder0_carry), .B(s1_c6_adder1_carry), .cin(s1_c7_adder0_sum), .sum(s2_c7_adder0_sum), .cout(s2_c7_adder0_carry));

//column 8
logic s2_c8_adder0_sum, s2_c8_adder0_carry;
full_adder s2_c8_adder0 (.A(s1_c7_adder0_carry), .B(s1_c7_adder1_carry), .cin(s1_c8_adder0_sum), .sum(s2_c8_adder0_sum), .cout(s2_c8_adder0_carry));

//column 9
logic s2_c9_adder0_sum, s2_c9_adder0_carry;
full_adder s2_c9_adder0 (.A(s1_c8_adder0_carry), .B(s1_c8_adder1_carry), .cin(s1_c9_adder0_sum), .sum(s2_c9_adder0_sum), .cout(s2_c9_adder0_carry));

//column 10
logic s2_c10_adder0_sum, s2_c10_adder0_carry;
full_adder s2_c10_adder0 (.A(s1_c9_adder0_carry), .B(s1_c9_adder1_carry), .cin(s1_c10_adder0_sum), .sum(s2_c10_adder0_sum), .cout(s2_c10_adder0_carry));

//column 11
logic s2_c11_adder0_sum, s2_c11_adder0_carry;
full_adder s2_c11_adder0 (.A(s1_c10_adder0_carry), .B(s1_c10_adder1_carry), .cin(s1_c11_adder0_sum), .sum(s2_c11_adder0_sum), .cout(s2_c11_adder0_carry));

//column 12
logic s2_c12_adder0_sum, s2_c12_adder0_carry;
full_adder s2_c12_adder0 (.A(s1_c11_adder0_carry), .B(pp[5][7]), .cin(pp[6][6]), .sum(s2_c12_adder0_sum), .cout(s2_c12_adder0_carry));


//stage 3 reduce height to 2


//column 2
logic s3_c2_adder0_sum, s2_c2_adder0_carry;
half_adder s3_c2_adder0(.A(pp[0][2]), .B(pp[1][1]), .sum(s3_c2_adder0_sum), .cout(s3_c2_adder0_carry));

//column 3
logic s3_c3_adder0_sum, s3_c3_adder0_carry;
full_adder s3_c3_adder0(.A(s2_c3_adder0_sum), .B(pp[2][1]), .cin(pp[3][0]), .sum(s3_c3_adder0_sum), .cout(s3_c3_adder0_carry));

//column 4
logic s3_c4_adder0_sum, s3_c4_adder0_carry;
full_adder s3_c4_adder0(.A(s2_c3_adder0_carry), .B(s2_c4_adder0_sum), .cin(pp[4][0]), .sum(s3_c4_adder0_sum), .cout(s3_c4_adder0_carry));

//column 5
logic s3_c5_adder0_sum, s3_c5_adder0_carry;
full_adder s3_c5_adder0(.A(s2_c4_adder0_carry), .B(s2_c5_adder0_sum), .cin(pp[5][0]), .sum(s3_c5_adder0_sum), .cout(s3_c5_adder0_carry));

//column 6
logic s3_c6_adder0_sum, s3_c6_adder0_carry;
full_adder s3_c6_adder0(.A(s2_c5_adder0_carry), .B(s2_c6_adder0_sum), .cin(s1_c6_adder1_sum), .sum(s3_c6_adder0_sum), .cout(s3_c6_adder0_carry));

//column 7
logic s3_c7_adder0_sum, s3_c7_adder0_carry;
full_adder s3_c7_adder0(.A(s2_c6_adder0_carry), .B(s2_c7_adder0_sum), .cin(s1_c7_adder1_sum), .sum(s3_c7_adder0_sum), .cout(s3_c7_adder0_carry));

//column 8
logic s3_c8_adder0_sum, s3_c8_adder0_carry;
full_adder s3_c8_adder0(.A(s2_c7_adder0_carry), .B(s2_c8_adder0_sum), .cin(s1_c8_adder1_sum), .sum(s3_c8_adder0_sum), .cout(s3_c8_adder0_carry));

//column 9
logic s3_c9_adder0_sum, s3_c9_adder0_carry;
full_adder s3_c9_adder0(.A(s2_c8_adder0_carry), .B(s2_c9_adder0_sum), .cin(s1_c9_adder1_sum), .sum(s3_c9_adder0_sum), .cout(s3_c9_adder0_carry));

//column 10
logic s3_c10_adder0_sum, s3_c10_adder0_carry;
full_adder s3_c10_adder0(.A(s2_c9_adder0_carry), .B(s2_c10_adder0_sum), .cin(s1_c10_adder1_sum), .sum(s3_c10_adder0_sum), .cout(s3_c10_adder0_carry));

//column 11
logic s3_c11_adder0_sum, s3_c11_adder0_carry;
full_adder s3_c11_adder0(.A(s2_c10_adder0_carry), .B(s2_c11_adder0_sum), .cin(pp[7][4]), .sum(s3_c11_adder0_sum), .cout(s3_c11_adder0_carry));

//column 12
logic s3_c12_adder0_sum, s3_c12_adder0_carry;
full_adder s3_c12_adder0(.A(s2_c11_adder0_carry), .B(s2_c12_adder0_sum), .cin(pp[7][5]), .sum(s3_c12_adder0_sum), .cout(s3_c12_adder0_carry));

//column 13
logic s3_c13_adder0_sum, s3_c13_adder0_carry;
full_adder s3_c13_adder0(.A(s2_c12_adder0_carry), .B(pp[6][7]), .cin(pp[7][6]), .sum(s3_c13_adder0_sum), .cout(s3_c13_adder0_carry));

logic[13:0] adder_in1, adder_in2;
assign adder_in1 = {s3_c13_adder0_carry, s3_c12_adder0_carry, s3_c11_adder0_carry, s3_c10_adder0_carry, s3_c9_adder0_carry, s3_c8_adder0_carry, s3_c7_adder0_carry, 
                    s3_c6_adder0_carry, s3_c5_adder0_carry, s3_c4_adder0_carry, s3_c3_adder0_carry, s3_c2_adder0_carry, s3_c2_adder0_sum, pp[0][1]};

assign adder_in2 = {pp[7][7], s3_c13_adder0_sum, s3_c12_adder0_sum, s3_c11_adder0_sum, s3_c10_adder0_sum, s3_c9_adder0_sum, s3_c8_adder0_sum, 
                    s3_c7_adder0_sum, s3_c6_adder0_sum, s3_c5_adder0_sum, s3_c4_adder0_sum, s3_c3_adder0_sum, pp[2][0], pp[1][0]};

logic[13:0] adder_sum;
logic adder_carry;
KSA_nbits #(.WIDTH(14)) Adder (.in1(adder_in1), .in2(adder_in2), .out(adder_sum), .cout(adder_carry));
assign out = {adder_carry, adder_sum, pp[0][0]};

endmodule

module Dadda_Multiplier_8bit (
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
full_adder s0_c23_adder3(.A(pp[11][12]), .B(pp[12][11]), .cin(pp[13][10]), .sum(s0_c23_sum[4]), .cout(s0_c23_carry[4]));

//column 24
logic s0_c24_sum[5], s0_c24_carry[5];
half_adder s0_c24_adder0(.A(pp[1][23]), .B(pp[2][22]), .sum(s0_c24_sum[0]), .cout(s0_c24_carry[0]));
full_adder s0_c24_adder1(.A(pp[3][21]), .B(pp[4][20]), .cin(pp[5][19]), .sum(s0_c24_sum[1]), .cout(s0_c24_carry[1]));
full_adder s0_c24_adder2(.A(pp[6][18]), .B(pp[7][17]), .cin(pp[8][16]), .sum(s0_c24_sum[2]), .cout(s0_c24_carry[2]));
full_adder s0_c24_adder3(.A(pp[9][15]), .B(pp[10][14]), .cin(pp[11][13]), .sum(s0_c24_sum[3]), .cout(s0_c24_carry[3]));
full_adder s0_c24_adder3(.A(pp[12][12]), .B(pp[13][11]), .cin(pp[14][10]), .sum(s0_c24_sum[4]), .cout(s0_c24_carry[4]));

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
full_adder s0_c27_adder0(.A(pp[5][23]), .B(pp[6][22]), .cin(pp[7][21]), .sum(s0_c28_sum), .cout(s0_c28_carry));

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

//column 25
logic s1_c25_sum[6], s1_c25_carry[6];

//column 26
logic s1_c26_sum[6], s1_c26_carry[6];

//column 27
logic s1_c27_sum[6], s1_c27_carry[6];

//column 28
logic s1_c28_sum[6], s1_c28_carry[6];

//column 29
logic s1_c29_sum[6], s1_c29_carry[6];

//column 30
logic s1_c30_sum[5], s1_c30_carry[5];

//column 31
logic s1_c31_sum[4], s1_c31_carry[4];

//column 32
logic s1_c32_sum[3], s1_c32_carry[3];

//column 33
logic s1_c33_sum[2], s1_c33_carry[2];

//column 34
logic s1_c34_sum, s1_c34_carry;

endmodule
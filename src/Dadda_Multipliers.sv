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
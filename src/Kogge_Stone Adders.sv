//This file contains various widths of Kogge-Stone Adders

module KSA_8bits(
input logic[7:0] in1, in2,
output logic[7:0] out,
output logic cout
);
logic[7:0] G, P;
assign G = in1 & in2; //generate bits
assign P = in1 ^ in2; //propagate bits

logic[7:0] G1, P1;//0, 0:1, 1:2, 2:3, 3:4, 4:5, 5:6, 6:7
assign G1[0] = G[0];
assign P1[0] = P[0];
for(genvar i = 1; i < 8; i++) begin
    assign P1[i] = P[i-1] & P[i];
    assign G1[i] = G[i] | (G[i-1] & P[i]);
end

logic[7:0] G2, P2;//0, 0:1, 0:2, 0:3, 1:4, 2:5, 3:6, 4:7
assign P2[0] = P1[0];
assign G2[0] = G1[0];
assign P2[1] = P1[1];
assign G2[1] = G1[1];
for(genvar i = 2; i < 8; i++) begin
    assign P2[i] = P1[i-2] & P1[i];
    assign G2[i] = G1[i] | (G1[i-2] & P1[i]);
end

logic [7:0] G3, P3;//0, 0:1, 0:2, 0:3, 0:4, 0:5, 0:6, 0:7
assign P3[0] = P2[0];
assign G3[0] = G2[0];
assign P3[1] = P2[1];
assign G3[1] = G2[1];
assign P3[2] = P2[2];
assign G3[2] = G2[2];
assign P3[3] = P2[3];
assign G3[3] = G2[3];
for(genvar i = 4; i < 8; i++) begin
    assign P3[i] = P2[i-4] & P2[i];
    assign G3[i] = G2[i] | (G2[i-4] & P2[i]);
end

logic[7:0] carries;
assign carries[0] = 1'b0;
assign carries[7:1] = G3[6:0];


assign cout = G3[7];
assign out = P ^ carries;
endmodule

module KSA_16bits(
input logic[15:0] in1, in2,
output logic[15:0] out,
output logic cout
);
logic[15:0] G, P;
assign G = in1 & in2; //generate bits
assign P = in1 ^ in2; //propagate bits

logic[15:0] G1, P1;//0, 0:1, 1:2, 2:3, 3:4, 4:5, 5:6, 6:7, 7:8, 8:9, 9:10, 10:11, 11:12, 12:13, 13:14, 14:15
assign G1[0] = G[0];
assign P1[0] = P[0];
for(genvar i = 1; i < 16; i++) begin
    assign P1[i] = P[i-1] & P[i];
    assign G1[i] = G[i] | (G[i-1] & P[i]);
end

logic[15:0] G2, P2;//0, 0:1, 0:2, 0:3, 1:4, 2:5, 3:6, 4:7, 5:8, 6:9, 7:10, 8:11, 9:12, 10:13, 11:14, 12:15
assign P2[0] = P1[0];
assign G2[0] = G1[0];
assign P2[1] = P1[1];
assign G2[1] = G1[1];
for(genvar i = 2; i < 16; i++) begin
    assign P2[i] = P1[i-2] & P1[i];
    assign G2[i] = G1[i] | (G1[i-2] & P1[i]);
end

logic [15:0] G3, P3;//0, 0:1, 0:2, 0:3, 0:4, 0:5, 0:6, 0:7, 1:8, 2:9, 3:10, 4:11, 5:12, 6:13, 7:14, 8:15
assign P3[0] = P2[0];
assign G3[0] = G2[0];
assign P3[1] = P2[1];
assign G3[1] = G2[1];
assign P3[2] = P2[2];
assign G3[2] = G2[2];
assign P3[3] = P2[3];
assign G3[3] = G2[3];
for(genvar i = 4; i < 16; i++) begin
    assign P3[i] = P2[i-4] & P2[i];
    assign G3[i] = G2[i] | (G2[i-4] & P2[i]);
end

logic [15:0] G4, P4;//0, 0:1, 0:2, 0:3, 0:4, 0:5, 0:6, 0:7, 0:8, 0:9, 0:10, 0:11, 0:12, 0:13, 0:14, 0:15
assign P4[0] = P3[0];
assign G4[0] = G3[0];
assign P4[1] = P3[1];
assign G4[1] = G3[1];
assign P4[2] = P3[2];
assign G4[2] = G3[2];
assign P4[3] = P3[3];
assign G4[3] = G3[3];
assign P4[4] = P3[4];
assign G4[4] = G3[4];
assign P4[5] = P3[5];
assign G4[5] = G3[5];
assign P4[6] = P3[6];
assign G4[6] = G3[6];
assign P4[7] = P3[7];
assign G4[7] = G3[7];

for(genvar i = 8; i < 16; i++) begin
    assign P4[i] = P3[i-8] & P3[i];
    assign G4[i] = G3[i] | (G3[i-8] & P3[i]);
end


logic[15:0] carries;
assign carries[0] = 1'b0;
assign carries[15:1] = G4[14:0];


assign cout = G4[15];
assign out = P ^ carries;
endmodule

module KSA_nbits#(
    parameter int WIDTH = 16
) (
input logic[WIDTH-1:0] in1, in2,
output logic[WIDTH-1:0] out,
output logic cout
);

initial begin
    if (WIDTH < 1) $fatal(1, "ERROR: Width must be larger than 1.");
end

logic[WIDTH-1:0] G[$clog2(WIDTH) + 1], P[$clog2(WIDTH) + 1];
assign G[0] = in1 & in2;
assign P[0] = in1 ^ in2;

for(genvar i = 1; i < $clog2(WIDTH) + 1; i++) begin : Main_loop
    for(genvar j = 0; j < (2 ** (i - 1)); j++) begin : Carry_Final_Gs
        assign G[i][j] = G[i-1][j];
        assign P[i][j] = P[i-1][j];
    end
    for(genvar j = (2 ** (i - 1)); j < WIDTH; j++) begin : Calculate_Next_P_Gs
        assign G[i][j] = G[i-1][j] | (G[i-1][j - (2 ** (i - 1))] & P[i-1][j]);
        assign P[i][j] = P[i-1][j] & P[i-1][j - (2 ** (i - 1))];
    end
end

logic[WIDTH-1:0] carries;
assign carries[0] = 1'b0;
if(WIDTH > 1) begin
    assign carries[WIDTH-1:1] = G[$clog2(WIDTH)][WIDTH-2:0];
end
assign cout = G[$clog2(WIDTH)][WIDTH-1:0];
assign out = P[0] ^ carries;
endmodule
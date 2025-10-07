//This file contains various widths of Kogge-Stone Adders

module KSA_8bits(
input logic[7:0] in1, in2,
output logic[7:0] out,
output logic cout
);
logic[7:0] G, P;
assign G = A & B; //generate bits
assign P = A ^ B; //propagate bits
logic[6:0] G1, P1;//0:1, 1:2, 2:3, 3:4, 4:5, 5:6, 6:7
for(int i = 0; i < 7; i++) begin
    assign P1[i] = P[i] & P[i+1];
    assign G1[i] = G[i+1] | (G[i] & P[i+1]);
end
logic[5:0] G2, P2;//0:2, 0:3, 1:4, 2:5, 3:6, 4:7
P2[0] = P[0] & P1[1];
G2[0] = G1[1] | (G[0] & P1[1]);
for(int i = 1; i < 6; i++) begin
    assign P2[i] = P1[i-1] & P1[i+1];
    assign G2[i] = G1[i+1] | (G1[i-1] & P1[i+1]);
end
logic [3:0] G3, P3;//0:4, 0:5, 0:6, 0:7
P3[0] = P[0] & P2[2];
G3[0] = G2[2] | (G[0] & P2[2]);
P3[1] = P1[0] & P2[3];
G3[1] = G2[3] | (G1[0] & P2[3]);
for(int i = 2; i < 4; i++) begin
    assign P3[i] = P2[i-2] & P2[i+2];
    assign G3[i] = G2[i+2] | (G2[i-2] & P2[i+2]);
end
logic[8:0] carries;
assign carries[0] = 1'b0;
for(int i = 5; i < 9; i++) begin
    assign carries[i] = G3[i-5] + P3[i-5];
end
for(int i = 3; i < 5; i++) begin
    assign carries[i] = G2[i-3] + P2[i-3];
end
assign carries[2] = G1[0] + P1[0];
assign carries[1] = G + P;
assign carries[0] = 1'b0;

assign cout = carries[8];
assign out = P ^ carries[0:7];
endmodule
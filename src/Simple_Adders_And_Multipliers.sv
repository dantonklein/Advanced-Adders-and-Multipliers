//simple adders and multiplier entities

module half_adder(
    input logic A,
    input logic B,
    output logic sum,
    output logic cout 
);
    assign sum = A ^ B;
    assign cout = A & B;
endmodule

module full_adder(
    input logic A,
    input logic B,
    input logic cin,
    output logic sum,
    output logic cout 
);
    assign sum = A ^ B ^ cin;
    assign cout = (A & B) | (B & cin) | (A & cin);
endmodule

module simple_adder #(
    parameter int WIDTH = 8
) (
    input logic[WIDTH-1:0] A,
    input logic[WIDTH-1:0] B,
    output logic[WIDTH-1:0] sum,
    output logic cout 
);
    assign {cout, sum} = A + B;
endmodule

module simple_multiplier #(
    parameter int WIDTH = 8
) (
    input logic[WIDTH-1:0] A,
    input logic[WIDTH-1:0] B,
    output logic[2*WIDTH-1:0] out
);
    assign out = A * B;
endmodule
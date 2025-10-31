//this will be temporarily used until the 28 bit dadda is made
module multiplier_delayed #(
    parameter int WIDTH = 27
    )(
    input logic clk, rst, 
    input logic[WIDTH-1:0] in1, in2,
    output logic[2*WIDTH-1:0] out
);
logic[2*WIDTH-1:0] s2_mult_out;
//fpga would optimize across 2 clock cycles
always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        s2_mult_out <= 0;
        out <= 0;
    end else begin
        s2_mult_out <= in1 * in2;
        out <= s2_mult_out;
    end
end
endmodule
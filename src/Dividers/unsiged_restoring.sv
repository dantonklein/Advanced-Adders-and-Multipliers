//unsigned restoring division algorithm
//2 process FSM
module unsigned_restoring #(
    parameter int WIDTH = 32
) (
    input logic go,
    input logic[WIDTH-1:0] divisor,
    input logic[WIDTH-1:0] dividend,
    input logic clk, rst,
    output logic done,
    output logic[WIDTH-1:0] quotient,
    output logic[WIDTH-1:0] remainder,
    output logic divide_by_zero
);

typedef enum logic [1:0] {
    WAIT,
    COMPUTE,
    DONE
} state_t;

state_t next_state, state_R;

logic[WIDTH-1:0] Q_R, next_Q, quotient_R, next_quotient, remainder_R, next_remainder;
logic[WIDTH:0] A_R, next_A, B_R, next_B, B_twos_comp_R, next_B_twos_comp;
logic[$clog2(WIDTH):0] Count_R, next_Count;
logic done_R, next_done;
logic divide_by_zero_R, next_divide_by_zero;

assign done = done_R;
assign divide_by_zero = divide_by_zero_R;
assign quotient = quotient_R;
assign remainder = remainder_R;
always_ff @(posedge clk or posedge rst) begin
    if(rst) begin
        state_R <= WAIT;
        Q_R <= '0;
        A_R <= '0;
        B_R <= '0;
        B_twos_comp_R <= '0;
        Count_R <= '0;
        quotient_R <= '0;
        remainder_R <= '0;
        done_R <= 1'b0;
        divide_by_zero_R <= 1'b0;
    end
    else begin
        state_R <= next_state;
        Q_R <= next_Q;
        A_R <= next_A;
        B_R <= next_B;
        B_twos_comp_R <= next_B_twos_comp;
        Count_R <= next_Count;
        quotient_R <= next_quotient;
        remainder_R <= next_remainder;
        done_R <= next_done;
        divide_by_zero_R <= next_divide_by_zero;
    end
end 

logic[WIDTH:0] A_temp;

always_comb begin
    logic[WIDTH:0] one;
    one = 1;
    next_Q = Q_R;
    next_A = A_R;
    next_B = B_R;
    next_B_twos_comp = B_twos_comp_R;
    next_Count = Count_R;
    next_remainder = remainder_R;
    next_quotient = quotient_R;
    next_state = state_R;
    next_divide_by_zero = divide_by_zero_R;
    next_done = done_R;
    case(state_R)
        WAIT: begin
            if (go) begin
                if(divisor == 0) begin
                    next_state = DONE;
                    next_done = 1'b1;
                    next_divide_by_zero = 1'b1;
                end
                else begin
                    next_A = '0;
                    next_B = {1'b0,divisor};
                    next_B_twos_comp = ~next_B + one;
                    next_Q = dividend;
                    next_Count = WIDTH;
                    next_state = COMPUTE;
                end
            end
        end
        COMPUTE: begin
            A_temp = {A_R[WIDTH-1:0], Q_R[WIDTH-1]} + B_twos_comp_R;
            if(A_temp[WIDTH]) begin
                next_A = A_temp + B_R;
            end else begin
                next_A = A_temp;
            end
            next_Q = {Q_R[WIDTH-2:0],~A_temp[WIDTH]};
            next_Count = Count_R - 1;
            if(next_Count == 0) begin 
                next_state = DONE;
                next_remainder = next_A[WIDTH-1:0];
                next_quotient = next_Q[WIDTH-1:0];
                next_done = 1;
            end
        end
        DONE: begin
            next_done = 0;
            next_divide_by_zero = 1'b0;
            next_state = WAIT;
        end
    endcase
end


endmodule


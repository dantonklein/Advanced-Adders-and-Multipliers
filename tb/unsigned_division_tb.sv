module unsigned_division_tb #(
    parameter int WIDTH = 8,
    parameter int NUM_TESTS = 1000
);
    logic clk;
    logic rst;

    logic go;
    logic done;

    logic divide_by_zero;

    logic[WIDTH-1:0] divisor, dividend;
    logic[WIDTH-1:0] quotient, remainder;
    logic[WIDTH-1:0] correct_quotient, correct_remainder;
    //unsigned_restoring #(
    unsigned_nonrestoring #(
        .WIDTH(WIDTH)
    ) DUT (
        .clk(clk),
        .rst(rst),
        .go(go),
        .done(done),
        .divisor(divisor),
        .dividend(dividend),
        .quotient(quotient),
        .remainder(remainder),
        .divide_by_zero(divide_by_zero)
    );

    //Clock generation block
    initial begin: generate_clk
        clk <= 1'b0;
        forever #5 clk <= ~clk;
    end

    int passed = 0;
    int failed = 0;

    initial begin
        rst <= 1'b1;
        go <= 1'b0;
        divisor <= '0;
        dividend <= '0;
        correct_quotient <= '0;
        correct_remainder <= '0;
        repeat(2) @(posedge clk);
        rst = 1'b0;
        @(posedge clk);
        for(int i = 0; i < NUM_TESTS; i++) begin
            go <= 1'b1;
            divisor = $urandom;
            dividend = $urandom;
            correct_quotient = dividend / divisor;
            correct_remainder = dividend % divisor; 
            @(posedge clk);
            go <= 1'b0;
            @(posedge done);
            //$display("Quotient: %u Expected Quotient: %u", quotient, correct_quotient);
            //$display("Remainder: %u Expected Remainder: %u", remainder, correct_remainder);
            if(divisor == 0 && divide_by_zero) passed++;
            else if(quotient == correct_quotient && remainder == correct_remainder) passed++;
            else begin 
                $display("Circuit failed when divisor: %d, dividend: %d", divisor, dividend);
                $display("Quotient: %d Expected Quotient: %d", quotient, correct_quotient);
                $display("Remainder: %d Expected Remainder: %d", remainder, correct_remainder);
                failed++;
            end
            @(posedge clk);
        end
        $display("Tests passed: %d Tests failed: %d", passed, failed);
        disable generate_clk;
    end
endmodule
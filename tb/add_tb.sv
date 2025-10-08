`timescale 1 ns / 10 ps

module add_tb #(
    parameter int NUM_TESTS = 10000,
    parameter int WIDTH = 16
);
    logic [WIDTH-1:0] in1, in2;
    logic [WIDTH-1:0] out;
    logic cout;
    //KSA_8bits DUT (.*);
    KSA_16bits DUT (.*);
    logic clk = 1'b0;
    initial begin : generate_clock
        forever #5 clk <= ~clk;
    end
    logic [WIDTH-1:0] correct_out;
    logic correct_cout;
    int passed, failed;

    initial begin
        passed = 0;
        failed = 0;
        $timeformat(-9, 0, " ns");

        for (int i = 0; i < NUM_TESTS; i++) begin
            in1 <= $urandom;
            in2 <= $urandom;
            @(posedge clk);
            {correct_cout, correct_out} = in1 + in2;
            if((correct_cout == cout) && (correct_out == out)) begin
                passed++;
            end else if((correct_cout == cout)) begin
                failed++;
                $display("ERROR (time %0t): out = %h instead of %h for inputs %h and %h", $realtime, out, correct_out, in1, in2);
            end else if((correct_out == out)) begin
                failed++;
                $display("ERROR (time %0t): cout = %h instead of %h for inputs %h and %h", $realtime, cout, correct_cout, in1, in2);
            end else begin
                failed++;
                $display("ERROR (time %0t): out = %h and cout = %h instead of %h and for inputs %h and %h", $realtime, out, cout, correct_out, correct_cout, in1, in2);
            end
        end
        $display("Tests completed. Passed: %d Failed: %d", passed, failed);
        disable generate_clock;
    end


endmodule
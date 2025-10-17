`timescale 1 ns / 10 ps

module mult_tb #(
    parameter int NUM_TESTS = 1000
    //parameter int WIDTH = 17
);
    //logic [7:0] in1, in2;
    logic [23:0] in1, in2;
    //logic [15:0] out;
    logic [47:0] out;
    //Dadda_Multiplier_8bit  DUT (.*);
    Dadda_Multiplier_24bit  DUT (.*);
    logic clk = 1'b0;
    initial begin : generate_clock
        forever #5 clk <= ~clk;
    end
    logic [47:0] correct_out;
    int passed, failed;

    initial begin
        passed = 0;
        failed = 0;
        $timeformat(-9, 0, " ns");

        for (int i = 0; i < NUM_TESTS; i++) begin
            in1 <= $urandom;
            in2 <= $urandom;
            @(posedge clk);
            correct_out = in1 * in2;
            if(correct_out == out) begin
                passed++;
            end else begin
                failed++;
                $display("ERROR (time %0t): out = %h  instead of %h for inputs %h and %h", $realtime, out, correct_out, in1, in2);
            end
        end
        $display("Tests completed. Passed: %d Failed: %d", passed, failed);
        disable generate_clock;
    end


endmodule

module mult_pipelined_tb #(
    parameter int NUM_TESTS = 1000
    //parameter int WIDTH = 17
);
    //logic [7:0] in1, in2;
    logic [23:0] in1, in2;
    //logic [15:0] out;
    logic [47:0] out;
    logic rst, valid_data_in;
    logic valid_data_out;
    logic clk = 1'b0;
    //Dadda_Multiplier_8bit  DUT (.*);
    Dadda_Multiplier_24bit_pipelined  DUT (.*);
    initial begin : generate_clock
        forever #5 clk <= ~clk;
    end
    int passed, failed;

    initial begin
        passed = 0;
        failed = 0;
        $timeformat(-9, 0, " ns");
        rst <= 1;
        valid_data_in <= 0;
        @(posedge clk);
        rst <= 0;
        @(posedge clk);

        for (int i = 0; i < NUM_TESTS; i++) begin
            @(posedge clk);
            in1 <= $urandom;
            in2 <= $urandom;
            valid_data_in <= 1;
            @(posedge clk);
            valid_data_in <= 0;
            @(posedge clk);
            @(posedge clk);
            if(out == (in1 * in2)) begin
                passed++;
            end else begin
                failed++;
                $display("ERROR (time %0t): out = %h  instead of %h for inputs %h and %h", $realtime, out, in1 * in2, in1, in2);
            end
        end
        $display("Tests completed. Passed: %d Failed: %d", passed, failed);
        disable generate_clock;
    end


endmodule
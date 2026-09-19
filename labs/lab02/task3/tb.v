module tb;

  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt, t_lt, t_eq;

  // Instantiate DUT
  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Testbench self-checking variables
  integer i, j;
  integer errors = 0;
  integer total_tests = 0;

  reg exp_gt, exp_lt, exp_eq;

  initial begin
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;

        #5; // Allow signals to settle

        // Compute gold-standard expected values
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);

        total_tests = total_tests + 1;

        // Compare using !==
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b | got GT=%b LT=%b EQ=%b | expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    // Final summary output
    $display("----------------------------------------");
    if (errors == 0) begin
      $display("ALL TESTS PASSED: %0d/%0d passed", total_tests, total_tests);
    end else begin
      $display("SUMMARY: %0d/%0d passed (%0d error(s) found)", 
               (total_tests - errors), total_tests, errors);
    end
    $display("----------------------------------------");
    $finish;
  end

endmodule
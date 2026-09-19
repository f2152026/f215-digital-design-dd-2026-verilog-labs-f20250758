module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  // Instantiate DUT
  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer i, j, k;
  integer errors = 0;
  integer total_tests = 0;
  reg [3:0] exp_result;

  initial begin
    // Test 1: Full sweep across all a, b, and op values
    for (k = 0; k < 2; k = k + 1) begin
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          t_a  = i;
          t_b  = j;
          t_op = k;

          #5; // Allow output to settle

          exp_result = (t_op == 0) ? (t_a + t_b) : (t_a - t_b);
          total_tests = total_tests + 1;

          if (t_result !== exp_result) begin
            $display("FAIL at time %0t: op=%b a=%0d b=%0d | got result=%0d | expected %0d",
                     $time, t_op, t_a, t_b, t_result, exp_result);
            errors = errors + 1;
          end
        end
      end
    end

    // Test 2: Explicitly test changing 'op' while holding 'a' and 'b' constant
    t_a  = 4'd10;
    t_b  = 4'd3;
    t_op = 1'b0; // Add
    #5;

    // Toggle op to 1 (Sub) without changing a or b
    t_op = 1'b1;
    #5;

    exp_result  = t_a - t_b; // Should be 7
    total_tests = total_tests + 1;

    if (t_result !== exp_result) begin
      $display("FAIL (op toggle test) at time %0t: op=%b a=%0d b=%0d | got result=%0d | expected %0d",
               $time, t_op, t_a, t_b, t_result, exp_result);
      errors = errors + 1;
    end

    // Summary output
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
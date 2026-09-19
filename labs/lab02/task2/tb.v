// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs

  // TODO: instantiate DUT here
  // Parameters for testing override (DEPTH = 8 requiring 3-bit sel)
  localparam TEST_WIDTH = 8;
  localparam TEST_DEPTH = 8;

  // Declare inputs and outputs matching parameterized widths
  reg  [$clog2(TEST_DEPTH)-1:0] t_sel;
  wire [TEST_WIDTH-1:0]         t_dout;

  // DUT instantiation with parameter override
  lut #(
    .WIDTH(TEST_WIDTH),
    .DEPTH(TEST_DEPTH)
  ) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );
  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

 integer k;
  initial begin
    for (k = 0; k < TEST_DEPTH; k = k + 1) begin
      t_sel = k;
      #5;
    end
    $finish;
  end

  initial
  $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout); // change as required

endmodule

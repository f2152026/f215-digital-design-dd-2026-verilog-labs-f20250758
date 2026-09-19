// 2-input AND gate with continuous assignment delay (dataflow style)

module and_df (
  input  a,
  input  b,
  output y
);

  // Continuous assignment delay (Change delay value #1, #2, or #3 as needed)
  assign #1 y = a & b;

endmodule
// 2-input AND gate with INTRA-ASSIGNMENT delay

module and_beh_intra (
  input      a,
  input      b,
  output reg y
);

  // Intra-assignment delay (Change delay value #1, #2, or #3 as needed)
  always @(*) begin
    y = #1 a & b;
  end

endmodule
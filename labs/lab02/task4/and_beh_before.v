// 2-input AND gate with delay placed BEFORE procedural assignment

module and_beh_before (
  input      a,
  input      b,
  output reg y
);

  // Delay placed before assignment (Change delay value #1, #2, or #3 as needed)
  always @(*) begin
    #1 y = a & b;
  end

endmodule
module sum4 (
  input[31:0] input_1,

  output reg[31:0] output_32
);

  always @(*) begin
    output_32 = input_1 + 32'h00000004;
  end
  
endmodule
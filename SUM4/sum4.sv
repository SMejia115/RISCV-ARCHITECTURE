module sum4 (
  input wire[31:0] input_1,
  output reg[31:0] output_32
);

  wire [31:0] suma;

  assign suma = input_1 + 4;
  always @(posedge input_1) begin
    output_32 <= suma;
  end
endmodule
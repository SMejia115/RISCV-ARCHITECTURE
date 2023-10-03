// MUX 3 to 1
module mux3to1(
  input[1:0] select,
  input[31:0] input_1,
  input[31:0] input_2,
  input[31:0] input_3,

  output[31:0] output_32 
);

  reg[31:0] output_32;

  always @(*)
  begin
    case(select)
      2'b00:
        output_32 = input_1;
      2'b01:
        output_32 = input_2;
      2'b10:
        output_32 = input_3;
      2'b11:
        output_32 = 32'bx;
    endcase
  end
endmodule

// MUX 2 to 1
module mux2to1(
  input select,
  input[31:0] input_1,
  input[31:0] input_2,

  output[31:0] output_32 
);

  reg[31:0] output_32;

  always @(*)
  begin
    case(select)
      1'b0:
        output_32 = input_1;
      1'b1:
        output_32 = input_2;
    endcase
  end
endmodule
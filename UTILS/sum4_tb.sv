module sum4_tb;
  reg[31:0] input_1;

  wire[31:0] output_32;

  sum4 dut(
    .input_1(input_1),
    .output_32(output_32)
  );

  initial begin
    $dumpfile("sum4_tb.vcd");
    $dumpvars(0, sum4_tb);

    input_1 = 0;
    #10 input_1 = 4;
    #10 input_1 = 8;
    #10 input_1 = 12;
  end
  
endmodule
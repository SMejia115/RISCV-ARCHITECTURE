module monocycle_tb;
  reg clk;
  reg reset;
  reg[31:0] initial_address;

  wire[31:0] instruction;

  monocycle dut (
    .clk(clk),
    .instruction(instruction),
    .reset(reset),
    .initial_address(initial_address)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("monocycle_tb.vcd");
    $dumpvars(0, monocycle_tb);
    #5;
    clk = 1;
    // forever #5 clk = ~clk;
    #5;
    clk = 0;
    reset = 1;
    initial_address = 0;

    #10 reset = 0;

    #40;

  //   $finish;
  // end


endmodule
module monocycle_tb;
  reg clk;
  wire[31:0] instruction;

  monocycle dut (
    .clk(clk),
    .instruction(instruction)
  );

  initial begin
    $dumpfile("monocycle.vcd");
    $dumpvars(0, monocycle_tb);
    #5;
    clk = 1;
    // forever #5 clk = ~clk;
    #5;
    clk = 0;
    #5;
    clk = 1;
    #5;
    clk = 0;
    // clk = 0;
  end

  // initial begin
  //   #20;

  //   $finish;
  // end


endmodule
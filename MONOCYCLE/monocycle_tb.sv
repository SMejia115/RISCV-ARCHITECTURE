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
    
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    #20;

    $finish;
  end


endmodule
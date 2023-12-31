module monocycle_tb;
  reg clk;
  reg reset;
  reg[31:0] initial_address;
  reg tr;

  monocycle dut (
    .clk(clk),
    .reset(reset),
    .initial_address(initial_address),
    .tr(tr)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("monocycle_tb.vcd");
    $dumpvars(0, monocycle_tb);

    clk = 0;
    reset = 1;
    initial_address = 0;

    #10; 
    reset = 0;

    #70 tr = 1;

    #6;

    $finish;
  end


endmodule
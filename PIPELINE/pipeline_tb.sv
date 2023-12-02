module pipeline_tb;
  reg clk;
  reg reset;
  reg[31:0] initial_address;
  reg tr;

  pipeline dut (
    .clk(clk),
    .reset(reset),
    .initial_address(initial_address),
    .tr(tr)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("pipeline_tb.vcd");
    $dumpvars(0, pipeline_tb);

    clk = 0;
    reset = 1;
    initial_address = 0;

    #10; 
    reset = 0;
    tr = 1;

    #140;

    #6;
 

    $finish;
  end


endmodule
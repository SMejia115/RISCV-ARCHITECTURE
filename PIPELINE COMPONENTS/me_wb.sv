module me_wb(
  input[31:0] incrementPCIn,
  input[31:0] ALUResIn,
  input[31:0] DMDataRdIn,
  input[4:0] rdIn,
  /*Control Unit Inputs*/
  input[1:0] ru_data_srcIn,
  input clk,

  output reg[31:0] incrementPCOut,
  output reg[31:0] ALUResOut,
  output reg[31:0] DMDataRdOut,
  output reg[4:0] rdOut,
  /*Control Unit Outputs*/
  output reg[1:0] ru_data_srcOut
);

always @(posedge clk) begin
  incrementPCOut = incrementPCIn;
  ALUResOut = ALUResIn;
  DMDataRdOut = DMDataRdIn;
  rdOut = rdIn;
  /*Control Unit*/
  ru_data_srcOut = ru_data_srcIn;
  
end
  
endmodule
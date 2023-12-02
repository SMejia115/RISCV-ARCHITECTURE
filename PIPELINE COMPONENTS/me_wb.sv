module me_wb(
  input[31:0] incrementPCIn,
  input[31:0] ALUResIn,
  input[31:0] DMDataRdIn,
  input[4:0] rdIn,
  /*Control Unit Inputs*/
  input[1:0] ru_data_srcIn,
  input ru_writeIn,
  input clk,

  output reg[31:0] incrementPCOut,
  output reg[31:0] ALUResOut,
  output reg[31:0] DMDataRdOut,
  output reg[4:0] rdOut,
  /*Control Unit Outputs*/
  output reg[1:0] ru_data_srcOut,
  output reg ru_writeOut
);

reg[31:0] incrementPCOut_reg;
reg[31:0] ALUResOut_reg;
reg[31:0] DMDataRdOut_reg;
reg[4:0] rdOut_reg;
reg[1:0] ru_data_srcOut_reg;
reg ru_writeOut_reg;

always @(negedge clk) begin
  incrementPCOut_reg = incrementPCIn;
  ALUResOut_reg = ALUResIn;
  DMDataRdOut_reg = DMDataRdIn;
  rdOut_reg = rdIn;
  /*Control Unit*/
  ru_data_srcOut_reg = ru_data_srcIn;
  ru_writeOut_reg = ru_writeIn;
end

always @(posedge clk) begin
  incrementPCOut = incrementPCOut_reg;
  ALUResOut = ALUResOut_reg;
  DMDataRdOut = DMDataRdOut_reg;
  rdOut = rdOut_reg;
  /*Control Unit*/
  ru_data_srcOut = ru_data_srcOut_reg;
  ru_writeOut = ru_writeOut_reg;
end
  
endmodule
module ex_me(
  input[31:0] incrementPCIn,
  input[31:0] ALUResIn,
  input[31:0] RS2In,
  input[4:0] rdIn,
  /*Control Unit Inputs*/
  input dm_writeIn,
  input[2:0] dm_ctrlIn,
  input[1:0] ru_data_srcIn,
  input ru_writeIn,
  input clk,

  output reg[31:0] incrementPCOut,
  output reg[31:0] ALUResOut,
  output reg[31:0] RS2Out,
  output reg[4:0] rdOut,
  /*Control Unit Outputs*/
  output reg dm_writeOut,
  output reg[2:0] dm_ctrlOut,
  output reg[1:0] ru_data_srcOut,
  output reg ru_writeOut

);

reg[31:0] incrementPCOut_reg;
reg[31:0] ALUResOut_reg;
reg[31:0] RS2Out_reg;
reg[4:0] rdOut_reg;
reg dm_writeOut_reg;
reg[2:0] dm_ctrlOut_reg;
reg[1:0] ru_data_srcOut_reg;
reg ru_writeOut_reg;

always @(negedge clk) begin
  incrementPCOut_reg = incrementPCIn;
  ALUResOut_reg = ALUResIn;
  RS2Out_reg = RS2In;
  rdOut_reg = rdIn;
  /*Control Unit*/
  dm_writeOut_reg = dm_writeIn;
  dm_ctrlOut_reg = dm_ctrlIn;
  ru_data_srcOut_reg = ru_data_srcIn;
  ru_writeOut_reg = ru_writeIn;
end

always @(posedge clk) begin
  incrementPCOut = incrementPCOut_reg;
  ALUResOut = ALUResOut_reg;
  RS2Out = RS2Out_reg;
  rdOut = rdOut_reg;
  /*Control Unit*/
  dm_writeOut = dm_writeOut_reg;
  dm_ctrlOut = dm_ctrlOut_reg;
  ru_data_srcOut = ru_data_srcOut_reg;
  ru_writeOut = ru_writeOut_reg;
end
  
endmodule
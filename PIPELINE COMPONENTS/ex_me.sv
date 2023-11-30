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

always @(negedge clk) begin
  // #10;
  incrementPCOut = incrementPCIn;
  ALUResOut = ALUResIn;
  RS2Out = RS2In;
  rdOut = rdIn;
  /*Control Unit*/
  dm_writeOut = dm_writeIn;
  dm_ctrlOut = dm_ctrlIn;
  ru_data_srcOut = ru_data_srcIn;
  ru_writeOut = ru_writeIn;
  
end
  
endmodule
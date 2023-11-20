
module ex_me(
  input[31:0] incrementPCIn,
  input[31:0] ALUResIn,
  input[31:0] RS2In,
  input[4:0] rdIn,
  /*Control Unit Inputs*/
  input dm_writeIn,
  input[2:0] dm_ctrlIn,
  input[1:0] ru_data_srcIn,
  input clk,

  output reg[31:0] incrementPCOut,
  output reg[31:0] ALUResOut,
  output reg[31:0] RS2Out,
  output reg[4:0] rdOut,
  /*Control Unit Outputs*/
  output reg dm_writeOut,
  output reg[2:0] dm_ctrlOut,
  output reg[1:0] ru_data_srcOut
);

always @(posedge clk) begin
  incrementPCOut = incrementPCIn;
  ALUResOut = ALUResIn;
  RS2Out = RS2In;
  rdOut = rdIn;
  /*Control Unit*/
  dm_writeOut = dm_writeIn;
  dm_ctrlOut = dm_ctrlIn;
  ru_data_srcOut = ru_data_srcIn;
  
end
  
endmodule
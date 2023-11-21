/*Decode instruction - Execute component*/
module de_ex(
  input[31:0] incrementPCIn,
  input[31:0] PCIn,
  input[31:0] RS1In,
  input[31:0] RS2In,
  input[31:0] immExtIn,
  input[4:0] rdIn,
  /*Control Unit Inputs*/
  input[3:0] alu_opIn,
  input[1:0] alu_a_srcIn,
  input alu_b_srcIn,
  input dm_writeIn,
  input[2:0] dm_ctrlIn,
  input[4:0] br_opIn,
  input[1:0] ru_data_srcIn,
  input ru_writeIn,
  input clk,

  output reg[31:0] incrementPCOut,
  output reg[31:0] PCOut,
  output reg[31:0] RS1Out,
  output reg[31:0] RS2Out,
  output reg[31:0] immExtOut,
  output reg[4:0] rdOut,
  /*Control Unit Outputs*/
  output reg[3:0] alu_opOut,
  output reg[1:0] alu_a_srcOut,
  output reg alu_b_srcOut,
  output reg dm_writeOut,
  output reg[2:0] dm_ctrlOut,
  output reg[4:0] br_opOut,
  output reg[1:0] ru_data_srcOut,
  output reg ru_writeOut
);

always @(posedge clk) begin
  incrementPCOut = incrementPCIn;
  PCOut = PCIn;
  RS1Out = RS1In;
  RS2Out = RS2In;
  immExtOut = immExtIn;
  rdOut = rdIn;
  /*Control Unit*/
  alu_opOut = alu_opIn;
  alu_a_srcOut = alu_a_srcIn;
  alu_b_srcOut = alu_b_srcIn;
  dm_writeOut = dm_writeIn;
  dm_ctrlOut = dm_ctrlIn;
  br_opOut = br_opIn;
  ru_data_srcOut = ru_data_srcIn;
  ru_writeOut = ru_writeIn;
  
end
  
endmodule
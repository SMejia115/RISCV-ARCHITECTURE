/*Decode instruction - Execute component*/
module if_de(
  input[31:0] incrementPCIn,
  input[31:0] PCIn,
  input[31:0] instructionIn,
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
  input clk,

  output reg[31:0] incrementPCOut,
  output reg[31:0] PCOut,
  output reg[31:0] instructionOut,
  output reg[31:0] RS1Out,
  output reg[31:0] RS2Out,
  output reg[31:0] immExtOut,
  output reg[4:0] rdOut,
  /*Control Unit Outputs*/
  output[3:0] alu_opOut,
  output[1:0] alu_a_srcOut,
  output alu_b_srcOut,
  output dm_writeOut,
  output[2:0] dm_ctrlOut,
  output[4:0] br_opOut,
  output[1:0] ru_data_srcOut
);

always @(posedge clk) begin
  incrementPCIn = incrementPCOut;
  PCIn = PCOut;
  instructionIn = instructionOut;
  RS1In = RS1Out;
  RS2In = RS2Out;
  immExtIn = immExtOut;
  rdIn = rdOut;
  /*Control Unit*/
  alu_opIn = alu_opOut;
  alu_a_srcIn = alu_a_srcOut;
  alu_b_srcIn = alu_b_srcOut;
  dm_writeIn = dm_writeOut;
  dm_ctrlIn = dm_ctrlOut;
  br_opIn = br_opOut;
  ru_data_srcIn = ru_data_srcOut;
  
end
  
endmodule
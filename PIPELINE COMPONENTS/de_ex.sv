/*Decode instruction - Execute component*/
module de_ex(
  input[31:0] incrementPCIn,
  input[31:0] PCIn,
  input[4:0] RS1In,
  input[4:0] RS2In,
  input[31:0] RS1DataIn,
  input[31:0] RS2DataIn,
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
  output reg[4:0] RS1Out,
  output reg[4:0] RS2Out,
  output reg[31:0] RS1DataOut,
  output reg[31:0] RS2DataOut,
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

reg[31:0] incrementPCOut_reg;
reg[31:0] PCOut_reg;
reg[4:0] RS1Out_reg;
reg[4:0] RS2Out_reg;
reg[31:0] RS1DataOut_reg;
reg[31:0] RS2DataOut_reg;
reg[31:0] immExtOut_reg;
reg[4:0] rdOut_reg;
reg[3:0] alu_opOut_reg;
reg[1:0] alu_a_srcOut_reg;
reg alu_b_srcOut_reg;
reg dm_writeOut_reg;
reg[2:0] dm_ctrlOut_reg;
reg[4:0] br_opOut_reg;
reg[1:0] ru_data_srcOut_reg;
reg ru_writeOut_reg;

always @(negedge clk) begin
  incrementPCOut_reg = incrementPCIn;
  PCOut_reg = PCIn;
  RS1Out_reg = RS1In;
  RS2Out_reg = RS2In;
  RS1DataOut_reg = RS1DataIn;
  RS2DataOut_reg = RS2DataIn;
  immExtOut_reg = immExtIn;
  rdOut_reg = rdIn;
  /*Control Unit*/
  alu_opOut_reg = alu_opIn;
  alu_a_srcOut_reg = alu_a_srcIn;
  alu_b_srcOut_reg = alu_b_srcIn;
  dm_writeOut_reg = dm_writeIn;
  dm_ctrlOut_reg = dm_ctrlIn;
  br_opOut_reg = br_opIn;
  ru_data_srcOut_reg = ru_data_srcIn;
  ru_writeOut_reg = ru_writeIn;
end

always @(posedge clk) begin
  incrementPCOut = incrementPCOut_reg;
  PCOut = PCOut_reg;
  RS1Out = RS1Out_reg;
  RS2Out = RS2Out_reg;
  RS1DataOut = RS1DataOut_reg;
  RS2DataOut = RS2DataOut_reg;
  immExtOut = immExtOut_reg;
  rdOut = rdOut_reg;
  /*Control Unit*/
  alu_opOut = alu_opOut_reg;
  alu_a_srcOut = alu_a_srcOut_reg;
  alu_b_srcOut = alu_b_srcOut_reg;
  dm_writeOut = dm_writeOut_reg;
  dm_ctrlOut = dm_ctrlOut_reg;
  br_opOut = br_opOut_reg;
  ru_data_srcOut = ru_data_srcOut_reg;
  ru_writeOut = ru_writeOut_reg;
end
  
endmodule
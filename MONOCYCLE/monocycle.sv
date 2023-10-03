`include "../PC/pc.sv"
`include "../INSTRUCTION MEMORY/instruction_memory.sv"
`include "../UTILS/sum4.sv"
`include "../UTILS/mux.sv"
`include "../REGISTER FILE/register_file.sv"
`include "../IMM UNIT/imm_unit.sv"
`include "../DATA MEMORY/data_memory.sv"
`include "../CONTROL UNIT/control_unit.sv"
`include "../ALU/alu.sv"
`include "../DECODER/decoder.sv"

module monocycle (
  input clk,
  input reset,
  input[31:0] initial_address
);

  wire[31:0] NEXT_ADDRESS_PC;
  wire[31:0] ADDRESS_PC;
  wire[31:0] INSTRUCTION;

  wire[6:0] OPCODE;
  wire[2:0] FUNCT3;
  wire[6:0] FUNCT7;
  wire[4:0] RS1;
  wire[4:0] RS2;
  wire[4:0] RD;
  wire[24:0] IMM_DATA;

  wire[31:0] REGISTER_DATA_1;
  wire[31:0] REGISTER_DATA_2;

  wire[31:0] IMM_EXT;

  wire RU_WRITE;
  wire[3:0] ALU_OP;
  wire[2:0] IMM_SRC;
  wire ALU_A_SRC;
  wire ALU_B_SRC;
  wire DM_WRITE;
  wire[2:0] DM_CTRL;
  wire[4:0] BR_OP;
  wire[1:0] RU_DATA_SRC;

  wire[31:0] DATA_WRITE_REGISTER;

  sum4 sum4(
    .input_1(ADDRESS_PC),
    .output_32(NEXT_ADDRESS_PC)
  );

  instruction_memory #(1024, 32) instruction_memory(
    .address(ADDRESS_PC),
    .instruction(INSTRUCTION)
  );

  pc program_counter(
    .clk(clk),
    .reset(reset),
    .initial_address(initial_address),
    .next_address(NEXT_ADDRESS_PC),
    .address(ADDRESS_PC)
  );

  decoder decoder(
    .instruction(INSTRUCTION),
    .opcode(OPCODE),
    .funct3(FUNCT3),
    .funct7(FUNCT7),
    .rs1(RS1),
    .rs2(RS2),
    .rd(RD),
    .immdata(IMM_DATA)
  );

  register_file register_file(
    .clk(clk),
    .rs1(RS1),
    .rs2(RS2),
    .rd(RD),
    .data(DATA_WRITE_REGISTER),
    .rs1Data(REGISTER_DATA_1),
    .rs2Data(REGISTER_DATA_2)
  );

  imm_unit imm_unit(
    .imm(IMM_DATA),
    .immsrc(IMM_SRC),
    .immext(IMM_EXT)
  );

  control_unit control_unit(
    .opcode(OPCODE),
    .funct3(FUNCT3),
    .funct7(FUNCT7),
    .ru_write(RU_WRITE),
    .alu_op(ALU_OP),
    .imm_src(IMM_SRC),
    .alu_a_src(ALU_A_SRC),
    .alu_b_src(ALU_B_SRC),
    .dm_write(DM_WRITE),
    .dm_ctrl(DM_CTRL),
    .br_op(BR_OP),
    .ru_data_src(RU_DATA_SRC)
  );

  

  
endmodule
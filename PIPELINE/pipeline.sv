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
`include "../BRANCH UNIT/branch_unit.sv"
`include "../PIPELINE COMPONENTS/if_de.sv"
`include "../PIPELINE COMPONENTS/de_ex.sv"
`include "../PIPELINE COMPONENTS/ex_me.sv"
`include "../PIPELINE COMPONENTS/me_wb.sv"


module pipeline (
  input clk,
  input reset,
  input[31:0] initial_address,
  input tr //Poner en 1 tr si se quieren ver los registros.
);

  wire[31:0] NEXT_ADDRESS_PC;
  wire[31:0] ADDRESS_PC;
  wire[31:0] INSTRUCTION;
  wire[31:0] PC_PLUS_4;

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
  wire[1:0] ALU_A_SRC;
  wire ALU_B_SRC;
  wire DM_WRITE;
  wire[2:0] DM_CTRL;
  wire[4:0] BR_OP;
  wire[1:0] RU_DATA_SRC;

  wire[31:0] DATA_WRITE_REGISTER;

  reg[31:0] ZERO_ALU_A_SRC = 0;
  wire[31:0] A_DATA_ALU;
  wire[31:0] B_DATA_ALU;
  wire[31:0] RESULT_ALU;

  wire NEXT_PC_SRC;

  wire[31:0] DATA_MEMORY_READ;

  /*Pipeline wires*/

  wire[31:0] ADDRESS_PC_DE;
  wire[31:0] INSTRUCTION_DE;
  wire[31:0] PC_PLUS_4_DE;


  wire[31:0] PC_PLUS_4_EX;
  wire[31:0] ADDRESS_PC_DE_EX;
  wire[31:0] REGISTER_DATA_1_EX;
  wire[31:0] REGISTER_DATA_2_EX;
  wire[31:0] IMM_EXT_EX;
  wire[4:0] RD_EX;
  wire[3:0] ALU_OP_EX;
  wire[1:0] ALU_A_SRC_EX;
  wire ALU_B_SRC_EX;
  wire DM_WRITE_EX;
  wire[2:0] DM_CTRL_EX;
  wire[4:0] BR_OP_EX;
  wire[1:0] RU_DATA_SRC_EX;
  wire RU_WRITE_EX;


  wire[31:0] PC_PLUS_4_ME;
  wire[31:0] RESULT_ALU_ME;
  wire[31:0] REGISTER_DATA_2_ME;
  wire[4:0] RD_ME;
  wire DM_WRITE_ME;
  wire[2:0] DM_CTRL_ME;
  wire[1:0] RU_DATA_SRC_ME;
  wire RU_WRITE_ME;

  wire[31:0] PC_PLUS_4_WB;
  wire[31:0] RESULT_ALU_WB;
  wire[31:0] DATA_MEMORY_READ_WB;
  wire[4:0] RD_WB;
  wire[1:0] RU_DATA_SRC_WB;
  wire RU_WRITE_WB;

  /*----------------------------------------------------------*/
  /*---------------------PIPELINE COMPONENTS-------------------*/

  if_de if_de(
    .incrementPCIn(PC_PLUS_4),
    .PCIn(ADDRESS_PC),
    .instructionIn(INSTRUCTION),
    .clk(clk),
    .PCOut(ADDRESS_PC_DE),
    .instructionOut(INSTRUCTION_DE),
    .incrementPCOut(PC_PLUS_4_DE)
  );

  de_ex de_ex(
    .incrementPCIn(PC_PLUS_4_DE),
    .PCIn(ADDRESS_PC_DE),
    .RS1In(REGISTER_DATA_1),
    .RS2In(REGISTER_DATA_2),
    .immExtIn(IMM_EXT),
    .rdIn(RD),
    .alu_opIn(ALU_OP),
    .alu_a_srcIn(ALU_A_SRC),
    .alu_b_srcIn(ALU_B_SRC),
    .dm_writeIn(DM_WRITE),
    .dm_ctrlIn(DM_CTRL),
    .br_opIn(BR_OP),
    .ru_data_srcIn(RU_DATA_SRC),
    .ru_writeIn(RU_WRITE),
    .clk(clk),

/*OUTPUT*/
    .incrementPCOut(PC_PLUS_4_EX),
    .PCOut(ADDRESS_PC_DE_EX),
    .RS1Out(REGISTER_DATA_1_EX),
    .RS2Out(REGISTER_DATA_2_EX),
    .immExtOut(IMM_EXT_EX),
    .rdOut(RD_EX),
    .alu_opOut(ALU_OP_EX),
    .alu_a_srcOut(ALU_A_SRC_EX),
    .alu_b_srcOut(ALU_B_SRC_EX),
    .dm_writeOut(DM_WRITE_EX),
    .dm_ctrlOut(DM_CTRL_EX),
    .br_opOut(BR_OP_EX),
    .ru_data_srcOut(RU_DATA_SRC_EX),
    .ru_writeOut(RU_WRITE_EX)
  );
  
  ex_me ex_me(
    .incrementPCIn(PC_PLUS_4_EX),
    .ALUResIn(RESULT_ALU),
    .RS2In(REGISTER_DATA_2),
    .rdIn(RD),
    .dm_writeIn(DM_WRITE),
    .dm_ctrlIn(DM_CTRL),
    .ru_data_srcIn(RU_DATA_SRC),
    .ru_writeIn(RU_WRITE_EX),
    .clk(clk),

    .incrementPCOut(PC_PLUS_4_ME),
    .ALUResOut(RESULT_ALU_ME),
    .RS2Out(REGISTER_DATA_2_ME),
    .rdOut(RD_ME),
    .dm_writeOut(DM_WRITE_ME),
    .dm_ctrlOut(DM_CTRL_ME),
    .ru_data_srcOut(RU_DATA_SRC_ME),
    .ru_writeOut(RU_WRITE_ME) 
    );

  me_wb me_wb(
    .incrementPCIn(PC_PLUS_4_ME),
    .ALUResIn(RESULT_ALU_ME),
    .DMDataRdIn(DATA_MEMORY_READ),
    .rdIn(RD_ME),
    .ru_data_srcIn(RU_DATA_SRC_ME),
    .ru_writeIn(RU_WRITE_ME),
    .clk(clk),

    .incrementPCOut(PC_PLUS_4_WB),
    .ALUResOut(RESULT_ALU_WB),
    .DMDataRdOut(DATA_MEMORY_READ_WB),
    .rdOut(RD_WB),
    .ru_data_srcOut(RU_DATA_SRC_WB),
    .ru_writeOut(RU_WRITE_WB)
  );



  /*----------------------------------------------------------*/
  sum4 sum4(
    .input_1(ADDRESS_PC),
    .output_32(PC_PLUS_4)
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
    .instruction(INSTRUCTION_DE),
    .opcode(OPCODE),
    .funct3(FUNCT3),
    .funct7(FUNCT7),
    .rs1(RS1),
    .rs2(RS2),
    .rd(RD),
    .immdata(IMM_DATA)
  );

  register_file register_file( //Poner en 1 tr si se quieren ver los registros.
    .clk(clk),
    .rs1(RS1),
    .rs2(RS2),
    .rd(RD_WB),
    .data(DATA_WRITE_REGISTER),
    .rs1Data(REGISTER_DATA_1),
    .rs2Data(REGISTER_DATA_2),
    .tr(tr),
    .writeEnable(RU_WRITE_WB)
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

  mux3to1 mux3to1_A(
    .input_1(REGISTER_DATA_1),
    .input_2(ADDRESS_PC),
    .input_3(ZERO_ALU_A_SRC),
    .select(ALU_A_SRC_EX),
    .output_32(A_DATA_ALU)
  );

  mux2to1 mux2to1_B(
    .input_1(REGISTER_DATA_2),
    .input_2(IMM_EXT),
    .select(ALU_B_SRC_EX),
    .output_32(B_DATA_ALU)
  );

  alu alu(
    .operand1(A_DATA_ALU),
    .operand2(B_DATA_ALU),
    .func3(ALU_OP_EX[2:0]),
    .subsra(ALU_OP_EX[3]),
    .result(RESULT_ALU)
  );

  branch_unit branch_unit(
    .rs1(REGISTER_DATA_1),
    .rs2(REGISTER_DATA_2),
    .br_op(BR_OP_EX),
    .jump(NEXT_PC_SRC)
  );

  mux2to1 mux2to1_PC(
    .input_1(PC_PLUS_4),
    .input_2(RESULT_ALU),
    .select(NEXT_PC_SRC),
    .output_32(NEXT_ADDRESS_PC)
  );

  data_memory data_memory(
    .address(RESULT_ALU),
    .datawr(REGISTER_DATA_2),
    .dmwr(DM_WRITE_ME),
    .dmctrl(DM_CTRL_ME),
    .datard(DATA_MEMORY_READ)
  );

  mux3to1 mux3to1(
    .input_1(RESULT_ALU_WB),
    .input_2(DATA_MEMORY_READ_WB),
    .input_3(PC_PLUS_4_WB),
    .select(RU_DATA_SRC_WB),
    .output_32(DATA_WRITE_REGISTER)
  );

  
endmodule
`timescale 1ns / 1ps

module control_unit_tb;
  reg[6:0] opcode;
  reg[2:0] funct3;
  reg[6:0] funct7;

  wire ru_write;
  wire[3:0] alu_op;
  wire[2:0] imm_src;
  wire alu_a_src;
  wire alu_b_src;
  wire dm_write;
  wire[2:0] dm_ctrl;
  wire[4:0] br_op;
  wire[1:0] ru_data_src;

  control_unit dut(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .ru_write(ru_write),
    .alu_op(alu_op),
    .imm_src(imm_src),
    .alu_a_src(alu_a_src),
    .alu_b_src(alu_b_src),
    .dm_write(dm_write),
    .dm_ctrl(dm_ctrl),
    .br_op(br_op),
    .ru_data_src(ru_data_src)
  );

  initial begin
    $dumpfile("control_unit_tb.vcd"); // Nombre del archivo VCD
    $dumpvars(0, control_unit_tb); // Guardar todas las señales

    opcode = 7'b0110111;

    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10

    funct3 = 3'b000;
    funct7 = 7'b0100000;
    #10

    funct3 = 3'b001;
    funct7 = 7'b0000000;
    #10

    funct3 = 3'b010;
    funct7 = 7'b0000000;
    #10

    funct3 = 3'b011;
    funct7 = 7'b0000000;
    #10

    funct3 = 3'b100;
    funct7 = 7'b0000000;
    #10

    funct3 = 3'b101;
    funct7 = 7'b0000000;
    #10

    funct3 = 3'b110;
    funct7 = 7'b0100000;
    #10

    funct3 = 3'b111;
    funct7 = 7'b0000000;
    #10

    $finish;
  end
endmodule
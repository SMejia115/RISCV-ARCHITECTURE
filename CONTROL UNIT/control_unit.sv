module control_unit (
  input[6:0] opcode,
  input[2:0] funct3,
  input[6:0] funct7,

  output ru_write,
  output[3:0] alu_op,
  output[2:0] imm_src,
  output alu_a_src,
  output alu_b_src,
  output dm_write,
  output[2:0] dm_ctrl,
  output[4:0] br_op,
  output[1:0] ru_data_src
);

  reg ru_write;
  reg[3:0] alu_op;
  reg[2:0] imm_src;
  reg alu_a_src;
  reg alu_b_src;
  reg dm_write;
  reg[2:0] dm_ctrl;
  reg[4:0] br_op;
  reg[1:0] ru_data_src;

  always @(*) begin
    case (opcode)
      7'b0110011: begin // Tipo R
        ru_write = 1'b1;
        alu_op = {funct7[5], funct3};
        imm_src = 3'bxxx;
        alu_a_src = 1'b0;
        alu_b_src = 1'b0;
        dm_write = 1'b0;
        dm_ctrl = 3'bxxx;
        br_op = 5'b00xxx;
        ru_data_src = 2'b00;
      end
      7'b0010011: begin // Tipo I
        ru_write = 1'b1;
        alu_op = {funct7[5], funct3};
        imm_src = 3'b000;
        alu_a_src = 1'b0;
        alu_b_src = 1'b1;
        dm_write = 1'b0;
        dm_ctrl = 3'bxxx;
        br_op = 5'b00xxx;
        ru_data_src = 2'b00;
      end
      7'b0000011: begin // Tipo I Carga
        ru_write = 1'b1;
        alu_op = 4'b0000;
        imm_src = 3'b000;
        alu_a_src = 1'b0;
        alu_b_src = 1'b1;
        dm_write = 1'b0;
        dm_ctrl = funct3;
        br_op = 5'b00xxx;
        ru_data_src = 2'b01;
      end
      7'b1100011: begin // Tipo B
        ru_write = 1'b0;
        alu_op = 4'b0000;
        imm_src = 3'b101;
        alu_a_src = 1'b1;
        alu_b_src = 1'b1;
        dm_write = 1'b0;
        dm_ctrl = 3'bxxx;
        br_op = {2'b01, funct3};
        ru_data_src = 2'bxx;
      end
      7'b1101111: begin // Tipo J
        ru_write = 1'b1;
        alu_op = 4'b0000;
        imm_src = 3'b110;
        alu_a_src = 1'b1;
        alu_b_src = 1'b1;
        dm_write = 1'b0;
        dm_ctrl = 3'bxxx;
        br_op = 5'b1xxxx;
        ru_data_src = 2'b10;
      end
      7'b0100011: begin // Tipo S
        ru_write = 1'b0;
        alu_op = 4'b0000;
        imm_src = 3'b001;
        alu_a_src = 1'b0;
        alu_b_src = 1'b1;
        dm_write = 1'b1;
        dm_ctrl = funct3;
        br_op = 5'b00xxx;
        ru_data_src = 2'bxx;
      end
      7'b1100111: begin // Tipo I Salto
        ru_write = 1'b1;
        alu_op = 4'b0000;
        imm_src = 3'b000;
        alu_a_src = 1'b0;
        alu_b_src = 1'b1;
        dm_write = 1'b0;
        dm_ctrl = 3'bxxx;
        br_op = 5'b1xxxx;
        ru_data_src = 2'b10;
      end
      7'b0110111: begin // Tipo U - lui
        ru_write = 1'b1;
        alu_op = 4'b0001;
        imm_src = 3'b010;
        alu_a_src = 1'bx;
        alu_b_src = 1'b1;
        dm_write = 1'b0;
        dm_ctrl = 3'bxxx;
        br_op = 5'b00xxx;
        ru_data_src = 2'b00;
      end 
      7'b0010111: begin // Tipo U - auipc
        ru_write = 1'b1;
        alu_op = 4'b0001;
        imm_src = 3'b010;
        alu_a_src = 1'bx;
        alu_b_src = 1'b1;
        dm_write = 1'b0;
        dm_ctrl = 3'bxxx;
        br_op = 5'b00xxx;
        ru_data_src = 2'b00;
      end
    endcase
  end
  
endmodule
// Program Counter
module pc (
  input[31:0] next_address,
  input clk,

  output[31:0] address
);

  reg[31:0] address_temp;

  always @(posedge clk) begin
    address_temp <= next_address;
  end

  assign address = address_temp;
endmodule

// Instruction Memory
module instruction_memory(
  //parameter size_memory = 1024, // Cantidad de palabras de memoria
  //parameter size_address = 10, // Número de bits de la dirección (2^10=1024)
  
  input [31:0] address, // Entrada de la dirección
  output reg [31:0] instruction // Salida para la instrucción según la dirección
);

  reg [31:0] memory [1023:0]; // Arreglo para almacenar las instrucciones

  initial begin
    $readmemb("instructions.txt", memory); // Carga las instrucciones desde el archivo
  end

  always @(*) begin
    instruction = memory[address >> 2]; // Asigna la instrucción según la dirección
  end

endmodule

// Register File
module register_file(
  input[4:0] rs1,
  input[4:0] rs2,
  input[4:0] rd, 
  input clk,
  input writeEnable,
  input[31:0] data,
  
  output[31:0] rs1Data,
  output[31:0] rs2Data
);
  
  reg [31:0] registers[31:0];
  
  always @(negedge clk)
    begin
      if(writeEnable && rd != 5'b00000)
        registers[rd] <= data;
    end

  assign rs1Data = registers[rs1];
  assign rs2Data = registers[rs2];
  
endmodule

// Control Unit
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
        br_op = funct3;
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
        ru_write = 1'b0;
        alu_op = 4'b0111;
        imm_src = 3'b010;
        alu_a_src = 1'bx;
        alu_b_src = 1'b1;
        dm_write = 1'b0;
        dm_ctrl = 3'bxxx;
        br_op = 5'b00xxx;
        ru_data_src = 2'b00;
      end 
      7'b0010111: begin // Tipo U - auipc
        ru_write = 1'b0;
        alu_op = 4'b0111;
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

// Immediate Unit
module imm_unit(
  input [24:0] imm,
  input [2:0] immsrc,
  output [31:0] immext
);

  reg [31:0] immext; // Se declara como reg aquí

  always @(*)
  begin
    case (immsrc)
      3'b000: // I - TYPE
        immext = {{20{imm[24]}}, imm[24:13]};
      3'b001: // S-TYPE
        immext = {{20{imm[24]}}, imm[24:18], imm[4:0]};
      3'b101: // B-TYPE
        immext = {{20{imm[24]}},imm[0], imm[23:18], imm[4:1], 1'b0};
      3'b010: // U-TYPE
        immext = {{12{imm[24]}}, imm[24:5]}; 
      3'b110: // J-TYPE
        immext = {{12{imm[24]}}, imm[12:5],imm[13],imm[23:14], 1'b0};
      default:
        immext = 32'b0; // Valor por defecto si no se cumple ningún caso
    endcase
  end
endmodule

// ALU
module alu(
  input[31:0] operand1, // 32 bits operand
  input[31:0] operand2, // 32 biss operand
  input[2:0] func3, 
  input subsra,
  
  output[31:0] result
);
  
  wire[31:0] operand1;
  wire[31:0] operand2;
  wire[2:0] func3;
  wire subsra;
  
  reg[31:0] result;
  
  // Temporal wires
  wire[31:0] sum_result;
  wire[31:0] diff_result;
  wire[31:0] and_result;
  wire[31:0] or_result;
  wire[31:0] xor_result;
  wire[31:0] lt_result;
  wire[31:0] shl_result;
  wire[31:0] shr_result;
  wire[31:0] shra_result;
  
  assign sum_result = operand1 + operand2;
  assign diff_result = operand1 - operand2;
  assign and_result = operand1 & operand2;
  assign or_result = operand1 | operand2;
  assign xor_result = operand1 ^ operand2;
  assign lt_result = operand1 < operand2;
  assign shl_result = operand1 << operand2;
  assign shr_result = operand1 >> operand2;
  assign shra_result = operand1 >>> operand2;
  
  always @*
    begin
      case(func3)
        3'b000:
          if (subsra)
            result = diff_result;// Resta
          else
            result = sum_result; // Suma
        3'b001: //Shift Left Logical
          result = shl_result;
        3'b010: //Set Less Than
          if (operand1[31] == 1 && operand2[31] == 0)
            result = 1;
          else if (operand1[31] == 0 && operand2[31] == 1)
            result = 0;
          else if (operand1[31] == operand2[31])
            result = lt_result;
          else
            result = 0;
        3'b011: //Set Less Than Unsigned
          result = lt_result;
        3'b100: //XOR
          result = xor_result;
        3'b101: 
          if (subsra) // Shift Right Arithmetic
            result = shra_result;
       	  else // Shift Right Logical
            result = shr_result;
        3'b110: // OR
          result = or_result;
        3'b111: // AND
          result = and_result;
      endcase
    end
  
endmodule

// Data Memory
module data_memory(
    input [31:0] address,
    input [31:0] datawr,
    input dmwr,
    input [2:0] dmctrl,
    output [31:0] datard
);
    reg [7:0] memory [0:4095];  // Memoria de datos 

    reg [31:0] datard;
    
    always @(*)
    begin
        case(dmctrl)
            3'b000: //Byte
                if (dmwr) // Write (sb)
                    memory[address] = {datawr[7:0]};  
                else // Read (lb)
                    datard = {{24{memory[address][7]}}, memory[address][7:0]};  //Se extiende el signo 
            3'b001: // Half
                if (dmwr) begin// Write (sh)
                    memory[address] = {datawr[7:0]};  
                    memory[address+1] = {datawr[15:8]}; 
                end 
                else// Read (lh)
                    datard = {{16{memory[address+1][7]}}, memory[address+1][7:0], memory[address][7:0]}; // Se extiende el signo  
            3'b010: // Word
                if (dmwr) begin // Write (sw)
                    memory[address] = datawr[7:0];
                    memory[address+1] = datawr[15:8];
                    memory[address+2] = datawr[23:16];
                    memory[address+3] = datawr[31:24];  
                end
                else// Read
                    datard = {memory[address+3], memory[address+2], memory[address+1], memory[address]};  // Leer palabra
            3'b100: // Unsigned Byte
                if (dmwr)// Write (sb)
                    memory[address] = datawr[7:0];  
                else// Read (lbu)
                    datard = {{24{1'b0}}, memory[address][7:0]};  // Se extiende con ceros
            3'b101: // Unsigned Half
                if (dmwr) begin // Write (sh)
                    memory[address] = {datawr[7:0]};  
                    memory[address+1] = {datawr[15:8]};
                end
                else  // Read
                    datard = {{16{1'b0}}, memory[address+1][7:0], memory[address][7:0]}; // Se extiende con ceros
            default: // Otros casos no definidos
                datard = 32'b0;  // Valor por defecto
        endcase
    end

endmodule

// MUX 3 to 1
module mux3to1(
  input[1:0] select,
  input[31:0] input_1,
  input[31:0] input_2,
  input[31:0] input_3,

  output[31:0] output_32 
);

  reg[31:0] output_32;

  always @(*)
  begin
    case(select)
      2'b00:
        output_32 = input_1;
      2'b01:
        output_32 = input_2;
      2'b10:
        output_32 = input_3;
      2'b11:
        output_32 = 32'bx;
    endcase
  end
endmodule

// MUX 2 to 1
module mux2to1(
  input select,
  input[31:0] input_1,
  input[31:0] input_2,

  output[31:0] output_32 
);

  reg[31:0] output_32;

  always @(*)
  begin
    case(select)
      1'b0:
        output_32 = input_1;
      1'b1:
        output_32 = input_2;
    endcase
  end
endmodule

// Sum4
module sum4 (
  input[31:0] input_1,

  output[31:0] output_32
);

  reg[31:0] output_32;

  assign output_32 = input_1 + 4;
  
endmodule


module monocycle (
  input clk,

  output[31:0] instruction
);

  wire[31:0] next_address;
  wire[31:0] address;

  pc program_counter(
    .clk(clk),
    .next_address(next_address),
    .address(address)
  );

  sum4 sum4(
    .input_1(address),
    .output_32(next_address)
  );

  reg[31:0] instruction;

  instruction_memory instruction_memory(
    .address(address),
    .instruction(instruction)
  );
  
endmodule
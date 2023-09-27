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
          result = lt_result;
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
          
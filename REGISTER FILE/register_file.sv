// Realizado por:
// Juan Pablo Garcia Montes
// Santiago Mejía Orejuela

module register_file (
  input[4:0] rs1,
  input[4:0] rs2,
  input[4:0] rd, 
  input clk,
  input writeEnable,
  input[31:0] data,
  input tr,
  
  output[31:0] rs1Data,
  output[31:0] rs2Data
);
  
  reg [31:0] registers[31:0];
  
  // assign registers[0] = 32'b00000000000000000000000000000000; // x0
  always @(negedge clk)
    begin
      if(writeEnable && rd != 5'b00000)
        registers[rd] <= data;
    end

  always @(posedge clk)
    begin
      registers[0] = 32'b00000000000000000000000000000000;
      if(tr == 1)
        for(int i = 0; i < 32; i = i + 1) // recorrer todos los registros
          $display("R[%d] = %d", i, registers[i]);
    end
    
  assign rs1Data = registers[rs1];
  assign rs2Data = registers[rs2];
  
endmodule
          
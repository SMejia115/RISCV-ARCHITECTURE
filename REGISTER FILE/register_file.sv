// Realizado por:
// Juan Pablo Garcia Montes
// Santiago Mejía Orejuela

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
          
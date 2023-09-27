//TestBench para register_file.sv

// Realizado por:
// Juan Pablo Garcia Montes
// Santiago Mejía Orejuela

`timescale 1ns / 1ps	// Escala de tiempo

module register_file_tb;
  reg[4:0] rs1;
  reg[4:0] rs2;
  reg[4:0] rd; 
  reg clk;
  reg writeEnable;
  reg[31:0] data;
  
  wire[31:0] rs1Data;
  wire[31:0] rs2Data;

  // Instancia del Register File
  register_file dut (
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd), 
    .clk(clk),
    .writeEnable(writeEnable),
    .data(data),
    .rs1Data(rs1Data),
    .rs2Data(rs2Data)
  );

  // Generación de señales de prueba
  initial begin
    $dumpfile("register_file_tb.vcd"); // Nombre del archivo VCD
    $dumpvars(0, register_file_tb); // Guardar todas las señales

    clk = 0;
    forever #5 clk = ~clk; // Generar señal de reloj
  end

  initial begin
    // Inicializar señales
    rs1 = 0;
    rs2 = 0;
    rd = 0;
    writeEnable = 0;
    data = 0;
    #10;

    // Escritura #1
    writeEnable = 1;
    rs1 = 1;
    rd = 1;
    data = 123;
    #10;

    // Escritura #2
    writeEnable = 1;
    rs2 = 2;
    rd = 2;
    data = 321;
    #10;
    
    // Lectura #1
    writeEnable = 0;
    rs1 = 1;
    rs2 = 2;
    rd = 1;
    data = 99;
    #20;

    // Escritura #3 - Registro x0
    writeEnable = 1;
    rs1 = 0;
    rd = 0;
    data = 2121;
    #10;

    // Lectura #2 - Registro x0 
    writeEnable = 0;
    rs1 = 1;
    rs2 = 0;
    rd = 1;
    data = 199;
    #20;

    $finish;
  end
endmodule


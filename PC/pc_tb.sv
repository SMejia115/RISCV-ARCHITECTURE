`timescale 1ns / 1ps

module pc_tb;
  reg[31:0] next_address;
  reg clk;
  reg reset;
  reg[31:0] initial_address;

  wire[31:0] address;

  // Instancia del PC
  pc dut(
    .next_address(next_address),
    .clk(clk),
    .reset(reset),
    .initial_address(initial_address),
    .address(address)
  );

  // Generación de señales de prueba
  initial begin
    $dumpfile("pc_tb.vcd"); // Nombre del archivo VCD
    $dumpvars(0, pc_tb); // Guardar todas las señales

    clk = 0;
    forever #5 clk = ~clk; // Generar señal de reloj
  end

  initial begin
    next_address = 0;
    #10 next_address = 32'h4;
    #10 next_address = 32'h8;
    #10 next_address = 32'hC;

    #10;
    next_address = 32'h10;
    reset = 1;
    initial_address = 32'h0;

    #10;
    reset = 0;
    next_address = address + 4;

    #10;

    $finish;
  end
endmodule

//TestBench para ALU.sv

module alu_tb;
  reg [31:0] operand1;
  reg [31:0] operand2;
  reg [2:0] func3;
  reg subsra;

  wire [31:0] result;

  // Instancia de la ALU
  alu dut (
    .operand1(operand1),
    .operand2(operand2),
    .func3(func3),
    .subsra(subsra),
    .result(result)
  );

  // Generación de señales de prueba
  initial begin
    $dumpfile("alu_tb.vcd"); // Nombre del archivo VCD
    $dumpvars(0, alu_tb); // Guardar todas las señales

    //Prueba #1 - Resta
    operand1 = 32;
    operand2 = 30;
    func3 = 3'b000;
    subsra = 1;

    #10; 

   //Prueba #2 - Suma
    operand1 = 32;
    operand2 = 30;
    func3 = 3'b000;
    subsra = 0;

    #10;

   //Prueba #3 - Shift Left Logical
    operand1 = 4'b0101;
    operand2 = 3;
    func3 = 3'b001;
    subsra = 0;

    #10;

    //Prueba #4 - Set Less Than
    operand1 = 32;
    operand2 = 30;
    func3 = 3'b010;
    subsra = 0;

    #10;

    //Prueba #5 - Set Less Than Unsigned
    operand1 = -32;
    operand2 = 30;
    func3 = 3'b011;
    subsra = 0;

    #10;

    //Prueba #6 - XOR
    operand1 = 32;
    operand2 = 30;
    func3 = 3'b100;
    subsra = 0;

    #10;

    //Prueba #7 - Shift Right Arithmetic
    operand1 = 32'b11000;
    operand2 = 2;
    func3 = 3'b101;
    subsra = 1;

    #10;

    //Prueba #8 - Shift Right Logical
    operand1 = 32'b11000;
    operand2 = 2;
    func3 = 3'b101;
    subsra = 0;

    #10;

    //Prueba #9 - OR
    operand1 = 1;
    operand2 = 0;
    func3 = 3'b110;
    subsra = 0;

    #10;

    //Prueba #10 - AND
    operand1 = 1;
    operand2 = 1;
    func3 = 3'b111;
    subsra = 0;

    #10;

    //Prueba #11 - Suma con overflow
    operand1 = 32'b1111_1111_1111_1111_1111_1111_1111_1111;
    operand2 = 32'b1111_1111_1111_1111_1111_1111_1111_1111;
    func3 = 3'b000;
    subsra = 0;

    #10;

    //Prueba #12 - XOR con numeros iguales
    operand1 = 745;
    operand2 = 745;
    func3 = 3'b100;
    subsra = 0;

    #10;

    //Prueba #13 - Resta con numero negativo
    operand1 = 14;
    operand2 = -6;
    func3 = 3'b000;
    subsra = 1;

    #10;

    //Prueba #14 - Shift Right Logical muy grande
    operand1 = 32'b10010;
    operand2 = 5;
    func3 = 3'b101;
    subsra = 1;
    


    // Verificación de resultados
    //$display("Suma Resultado: %b", result);

    $finish; // Finaliza la simulación
  end
endmodule


//TestBench para el módulo instruction_memory

// Realizado por:
// Santiago Mejía Orejuela
// Juan Pablo Garcia Montes

module instruction_memory_TB;
    // Señales para conectar al módulo de instrucción
    reg [9:0] address;               // Dirección de entrada
    wire [31:0] instruction;        // Instrucción leída desde la memoria de instrucciones

     // Instancia del módulo de instrucción
    instruction_memory dut (
        .address(address),
        .instruction(instruction)
    );

    // Inicialización de la simulación
    initial begin
        $dumpfile("instruction_memory.vcd"); // Generar archivo VCD
        $dumpvars(0, instruction_memory_TB); // Volcar señales

        // Prueba de lectura de diferentes direcciones
        address = 0;
        #10; // Retardo para que se actualice la dirección y se lea la instrucción
        $display("Dirección %d: Instrucción = %b", address, instruction);

        address = 4;
        #10;
        $display("Dirección %d: Instrucción = %b", address, instruction);

        address = 8;
        #10;
        $display("Dirección %d: Instrucción = %b", address, instruction);

        address = 12;
        #10;
        $display("Dirección %d: Instrucción = %b", address, instruction);

        address = 16;
        #10;
        $display("Dirección %d: Instrucción = %b", address, instruction);

        $finish; // Terminar la simulación
    end

endmodule



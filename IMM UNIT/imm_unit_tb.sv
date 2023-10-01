module imm_unit_tb;

    reg [24:0] imm;
    reg [2:0] immsrc;
    wire [31:0] immext;

    imm_unit dut(
        .imm(imm),
        .immsrc(immsrc),
        .immext(immext)
    );
    // Inicializar señales
    initial begin

    // Prueba 1: I-TYPE
        imm = 25'b0000000000000000000000010; // Ejemplo de valor de inmediato I-TYPE
        immsrc = 3'b000; // I-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 1 - immext: %h", immext);

        // Prueba 2: S-TYPE
        imm = 25'b0000000000000000010100000; // Ejemplo de valor de inmediato S-TYPE
        immsrc = 3'b001; // S-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 2 - immext: %h", immext);

        // Prueba 3: B-TYPE
        imm = 25'b0000000000000000010100000; // Ejemplo de valor de inmediato B-TYPE
        immsrc = 3'b010; // B-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 3 - immext: %h", immext);

        // Prueba 4: U-TYPE
        imm = 25'b0000000000000000000000001; // Ejemplo de valor de inmediato U-TYPE
        immsrc = 3'b011; // U-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 4 - immext: %h", immext);

        // Finalizar la simulación
        $finish;
    end
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
        imm = 25'b0001000000110000000000101; // Ejemplo de valor de inmediato I-TYPE
        immsrc = 3'b000; // I-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 1 I- immext: %b", immext);

        // Prueba 2: S-TYPE
        imm = 25'b1110111111010000000000101; // Ejemplo de valor de inmediato I-TYPE Negativo
        immsrc = 3'b000; // I-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 2 IN- immext: %b", immext);

        // Prueba 3: B-TYPE
        imm = 25'b0000011001010001001001001; // Ejemplo de valor de inmediato S-TYPE
        immsrc = 3'b001; // S-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 3 S- immext: %b", immext);

        // Prueba 4: B-TYPE
        imm = 25'b0000000000000010110110000; // Ejemplo de valor de inmediato B-TYPE
        immsrc = 3'b101; // B-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 4 B- immext: %b", immext);

        // Prueba 4: U-TYPE
        imm = 25'b0000000001011111010000101; // Ejemplo de valor de inmediato U-TYPE
        immsrc = 3'b010; // U-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 4 U - immext: %b", immext);

        // Prueba 4: J-TYPE
        imm = 25'b1111110111011111111100001; // Ejemplo de valor de inmediato J-TYPE
        immsrc = 3'b110; // J-TYPE
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 4 J - immext: %b", immext);

        // Finalizar la simulación
        $finish;
    end
endmodule 
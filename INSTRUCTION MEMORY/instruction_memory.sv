// Realizado por:
// Santiago Mejía Orejuela
// Juan Pablo Garcia Montes



module instruction_memory #(
    parameter size_memory = 1024, // Cantidad de palabras de memoria
    parameter size_address = 10 // Número de bits de la dirección (10^2=1024)
)(
    input [size_address-1:0] address, // Entrada de la dirección
    output reg [31:0] instruction // Salida para la instrucción según la dirección
);

    reg [31:0] memory [size_memory-1:0]; // Arreglo para almacenar las instrucciones

initial begin
    // $display("Se entra al instruction memory");
    $readmemb("instructions.txt", memory); // Carga las instrucciones desde el archivo
    // $display("Se leen las instrucciones");
    // $display("Instrucción 0: %b", memory[0]);
end

    always @(*) begin
        instruction = memory[address >> 2]; // Asigna la instrucción según la dirección
    end

endmodule

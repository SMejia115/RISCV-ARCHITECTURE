// Realizado por:
// Santiago Mejía Orejuela
// Juan Pablo Garcia Montes

module instruction_memory(
    //parameter size_memory = 1024, // Cantidad de palabras de memoria
    //parameter size_address = 10, // Número de bits de la dirección (10^2=1024)
    
    input [9:0] address, // Entrada de la dirección
    output reg [31:0] instruction // Salida para la instrucción según la dirección
);

reg [31:0] memory [1023:0]; // Arreglo para almacenar las instrucciones

initial begin
    $readmemb("instructions.txt", memory); // Carga las instrucciones desde el archivo
end

always @(*) begin
    instruction = memory[address]; // Asigna la instrucción según la dirección
end

endmodule

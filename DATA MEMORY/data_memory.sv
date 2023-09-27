module data_memory(
    input [31:0] address,
    input [31:0] datawr,
    input dmwr,
    input [2:0] dmctrl

    output [31:0] datard
    );

    reg [31:0] mem [1023:0];

    always @(*) 
        begin
        
            case(dmctrl)
                3'b000: // Carga o almacenamiento de byte
                    if (dmwr) // Write
                        memory[address] <= {24'b0, datawr[7:0]};  // Escribir byte
                    else // Read
                        datard = {24{memory[address][7]}, memory[address][7:0]};  // Leer byte
                3'b001: // Carga o almacenamiento de media palabra
                    if (dmwr) // Write
                        memory[address] <= {16'b0, datawr[15:0]};  // Escribir media palabra
                    else// Read
                        datard = {16{memory[address][15]}, memory[address][15:0]};  // Leer media palabra
                3'b010: // Carga o almacenamiento de palabra (word)
                    if (dmwr)// Write
                        memory[address] <= datawr;  // Escribir palabra
                    else// Read
                        datard = memory[address];  // Leer palabra
                3'b100: // Carga o almacenamiento de byte sin signo
                    if (dmwr)// Write
                        memory[address] <= {24'b0, datawr[7:0]};  // Escribir byte sin signo
                    else// Read
                        datard = {24{1'b0}, datawr[7:0]};  // Leer byte sin signo
                3'b101: // Carga o almacenamiento de media palabra sin signo
                    if (dmwr)// Write
                        memory[address] <= {16'b0, datawr[15:0]};  // Escribir media palabra sin signo
                    else  // Read
                        datard = {16{1'b0}, datawr[15:0]};  // Leer media palabra sin signo
                default: // Otros casos no definidos
                    datard = 32'b0;  // Valor por defecto
            endcase

        end

endmodule

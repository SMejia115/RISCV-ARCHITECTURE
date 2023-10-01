module data_memory(
    input [31:0] address,
    input [31:0] datawr,
    input dmwr,
    input [2:0] dmctrl,
    output [31:0] datard
);
    reg [7:0] memory [0:4095];  // Memoria de datos 

    reg [31:0] datard;
    
    always @(*)
    begin
        case(dmctrl)
            3'b000: //Byte
                if (dmwr) // Write (sb)
                    memory[address] = {datawr[7:0]};  
                else // Read (lb)
                    datard = {{24{memory[address][7]}}, memory[address][7:0]};  //Se extiende el signo 
            3'b001: // Half
                if (dmwr) begin// Write (sh)
                    memory[address] = {datawr[7:0]};  
                    memory[address+1] = {datawr[15:8]}; 
                end 
                else// Read (lh)
                    datard = {{16{memory[address+1][7]}}, memory[address+1][7:0], memory[address][7:0]}; // Se extiende el signo  
            3'b010: // Word
                if (dmwr) begin // Write (sw)
                    memory[address] = datawr[7:0];
                    memory[address+1] = datawr[15:8];
                    memory[address+2] = datawr[23:16];
                    memory[address+3] = datawr[31:24];  
                end
                else// Read
                    datard = {memory[address+3], memory[address+2], memory[address+1], memory[address]};  // Leer palabra
            3'b100: // Unsigned Byte
                if (dmwr)// Write (sb)
                    memory[address] = datawr[7:0];  
                else// Read (lbu)
                    datard = {{24{1'b0}}, memory[address][7:0]};  // Se extiende con ceros
            3'b101: // Unsigned Half
                if (dmwr) begin // Write (sh)
                    memory[address] = {datawr[7:0]};  
                    memory[address+1] = {datawr[15:8]};
                end
                else  // Read
                    datard = {{16{1'b0}}, memory[address+1][7:0], memory[address][7:0]}; // Se extiende con ceros
            default: // Otros casos no definidos
                datard = 32'b0;  // Valor por defecto
        endcase
    end

endmodule

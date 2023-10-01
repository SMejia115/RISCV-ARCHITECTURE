module tb_data_memory;

    // Definir los wires y regs necesarios
    reg [31:0] address;
    reg [31:0] datawr;
    reg dmwr;
    reg [2:0] dmctrl;
    wire [31:0] datard;

    // Instanciar el módulo a testear
    data_memory data_mem_inst (
        .address(address),
        .datawr(datawr),
        .dmwr(dmwr),
        .dmctrl(dmctrl),
        .datard(datard)
    );

    // Inicializar señales
    initial begin

        // Prueba 1
        address = 10;
        datawr = 16'b1010101010101010;
        dmwr = 1;
        dmctrl = 3'b001;
        #10;  // Esperar 10 unidades de tiempo
        $display("Prueba 1 - datawr: %b", datawr);
        $display("Prueba 1 - datard: %b", datard);

        // Prueba 2
        address = 10;
        //datawr = 8'b10101010;
        dmwr = 0;
        dmctrl = 3'b001;
        #10;
        $display("Prueba 2 - datawr: %b", datawr);  
        $display("Prueba 2 - datard: %b", datard);
        

        
        $finish;
    end

    

endmodule

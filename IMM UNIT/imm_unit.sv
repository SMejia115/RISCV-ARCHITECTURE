module imm_unit(
    input [24:0] imm,
    input [2:0] immsrc,
    output [31:0] immext
);

    reg [31:0] immext; // Se declara como reg aquí

    always @(*)
    begin
        case (immsrc)
            3'b000: // I - TYPE
                immext = {{20{imm[24]}}, imm[24:13]};
            3'b001: // S-TYPE
                immext = {{20{imm[24]}}, imm[24:18], imm[4:0]};
            3'b101: // B-TYPE
                immext = {{20{imm[24]}},imm[0], imm[23:18], imm[4:1], 1'b0};
            3'b010: // U-TYPE
                immext = {{12{imm[24]}}, imm[24:5]}; 
            3'b110: // J-TYPE
                immext = {{12{imm[24]}}, imm[12:5],imm[13],imm[23:14], 1'b0};
            default:
                immext = 32'b0; // Valor por defecto si no se cumple ningún caso
        endcase
    end

endmodule
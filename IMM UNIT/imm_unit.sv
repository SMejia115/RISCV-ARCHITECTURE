module imm_unit(
    input [24:0] imm,
    input [2:0] immsrc,
    output [31:0] immext
);

    reg [24:0] imm;
    reg  [2:0] immsrc;
    wire [31:0] immext;


    always @(*)
        begin
            case (imm)
                3'b000: // I - TYPE
                    immext = {{20{imm[24]}}, imm[24:13]};
                3'b001: // S-TYPE
                    immext = {{20{imm[24]}}, imm[24:18], imm[4:0]};
                3'b010: // B-TYPE
                    immext = {{20{imm[24]}}, imm[23:18], imm[4:1], {1'b0}};
                3'b011: // U-TYPE
                    immext = {{5{imm[24]}}, imm[24:5]}; 
                3'b110: // J-TYPE
                    immext = {{13{imm[24]}}, imm[12:5], imm[13], imm[23:14], {1'b0}};

            endcase
        end 

endmodule
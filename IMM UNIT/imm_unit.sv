
module imm_unit(
    input [24:0] imm
    input [2:0] immsrc

    output [31:0] immext
);

    always @(*)
        begin
            case (imm)
                3'b000:
                    



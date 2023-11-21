module branch_unit (
  input[31:0] rs1,
  input[31:0] rs2,
  input[4:0] br_op,

  output reg jump
);

  initial begin
    jump = 0;
  end 
  
  always @(*) begin
    if (br_op[4] == 1)
      jump = 1;
    else if (br_op[4:3] == 2'b00)
      jump = 0;
    else if (br_op[4:3] == 2'b01)
      case (br_op[2:0])
        3'b000: jump = (rs1 == rs2);
        3'b001: jump = (rs1 != rs2);
        3'b100:
          if (rs1[31] == 1 && rs2[31] == 0)
            jump = 1;
          else if (rs1[31] == 0 && rs2[31] == 1)
            jump = 0;
          else if (rs1[31] == rs2[31])
            jump = (rs1 < rs2);
          else
            jump = 0;
        3'b101:
          if (rs1[31] == 1 && rs2[31] == 0)
            jump = 0;
          else if (rs1[31] == 0 && rs2[31] == 1)
            jump = 1;
          else if (rs1[31] == rs2[31])
            jump = (rs1 >= rs2);
          else
            jump = 0;
        3'b110: jump = (rs1 < rs2);
        3'b111: jump = (rs1 >= rs2);
        default: 
          jump = 0;
      endcase
    else 
      jump = 0;
  end

endmodule
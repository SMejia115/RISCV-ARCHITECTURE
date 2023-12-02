module forwarding_unit(
  input[4:0] rs1_ex,
  input[4:0] rs2_ex,
  input[4:0] rd_me,
  input[4:0] rd_wb,
  input ru_write_me,
  input ru_write_wb,

  output reg[1:0] rs1_sel,
  output reg[1:0] rs2_sel
);

always @(*) begin
  if (ru_write_me == 1'b1 && rd_me != 5'b00000) begin
    if (rd_me == rs1_ex)
      rs1_sel = 2'b01;
    else if (rd_me == rs2_ex)
      rs2_sel = 2'b01;
  end
  if (ru_write_wb == 1'b1 && rd_wb != 5'b00000) begin
    if (rd_wb == rs1_ex)
      rs1_sel = 2'b10;
    else if (rd_wb == rs2_ex)
      rs2_sel = 2'b10;
  end
end

endmodule
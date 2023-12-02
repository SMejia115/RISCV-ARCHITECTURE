/*Intruction fetch - Decode instruction component*/
module if_de(
  input [31:0] incrementPCIn,
  input [31:0] PCIn,
  input [31:0] instructionIn,
  input clk,

  output reg[31:0] PCOut,
  output reg[31:0] instructionOut,
  output reg[31:0] incrementPCOut
);

reg[31:0] PCOut_reg;
reg[31:0] instructionOut_reg;
reg[31:0] incrementPCOut_reg;

always @(negedge clk) begin
  PCOut_reg = PCIn;
  instructionOut_reg = instructionIn;
  incrementPCOut_reg = incrementPCIn;
end

always @(posedge clk) begin
  PCOut = PCOut_reg;
  instructionOut = instructionOut_reg;
  incrementPCOut = incrementPCOut_reg;
end
  
endmodule
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

always @(negedge clk) begin
  // #10;
  PCOut = PCIn;
  instructionOut = instructionIn;
  incrementPCOut = incrementPCIn;
end
  
endmodule
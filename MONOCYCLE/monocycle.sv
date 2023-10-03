`include "../PC/pc.sv"
`include "../INSTRUCTION MEMORY/instruction_memory.sv"
`include "../UTILS/sum4.sv"

module monocycle (
  input clk,
  input reset,
  input[31:0] initial_address,

  output reg[31:0] instruction
);

  wire[31:0] next_address;
  wire[31:0] address;

  sum4 sum4(
    .input_1(address),
    .output_32(next_address)
  );

  instruction_memory #(1024, 32) instruction_memory(
    .address(address),
    .instruction(instruction)
  );

  pc program_counter(
    .clk(clk),
    .reset(reset),
    .initial_address(initial_address),
    .next_address(next_address),
    .address(address)
  );

  

  
endmodule
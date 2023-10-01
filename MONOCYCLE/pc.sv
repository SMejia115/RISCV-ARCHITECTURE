module pc (
  input[31:0] next_address,
  input clk,

  output[31:0] address
);

  reg[31:0] address_temp;

  always @(posedge clk) begin
    address_temp <= next_address;
  end

  assign address = address_temp;
  
endmodule
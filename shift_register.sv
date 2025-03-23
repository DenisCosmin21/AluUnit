module shift_register #(
  parameter w = 8
)(
  input [w - 1 : 0] in,
  input lshift,
  input rshift,
  input load,
  input rst,
  input en,
  input clk,
  output reg [w - 1 : 0] o,
);
  
  reg [w - 1 : 0] storage;
  
  always @(negedge clk or negedge rst) begin
    if(~rst)
      storage <= 0;
    else if(en) begin
      if(load)
        storage <= in;
      if(rshift)
        storage <= {1'b0, storage[7 : 1]};
      if(lshift)
        storage <= {storage[6 : 0], 1'b0};
    end
  end
  
  always @(*) begin
    o = storage;
  end
  
endmodule
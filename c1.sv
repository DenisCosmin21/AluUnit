module c1 #(
  parameter w = 8
)(
  input [w - 1 : 0] in,
  output reg [w - 1 : 0] out
);
  
  assign out = ~in;
 
endmodule
module c1 #(
  parameter w = 8
)(
  input [w - 1 : 0] in,
  input en,
  output reg [w - 1 : 0] out
);
  
  assign out = en ? ~in : in;
 
endmodule
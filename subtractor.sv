
module subtractor #(
  parameter w = 8
)(
  input [w - 1 : 0] x,
  input [w - 1 : 0] y,
  input bi,
  output reg [w - 1 : 0] o,
  output bo
);
  
  reg [w - 1 : 0] y_c1;
  
  c1 #(.w(w)) ComplementNr(.in(y), .out(y_c1));
  
  adder #(.w(w)) ParallelAdder(.x(x), .y(y_c1), .ci(bi ^ 1), .co(bo), .o(o));
  
endmodule
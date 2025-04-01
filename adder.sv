module adder #(
  parameter w = 8
)(
  input [w - 1 : 0] x,
  input [w - 1 : 0] y,
  input ci,
  output reg [w - 1 : 0] o,
);
  
  genvar i;
  
  wire [w - 1 : 0] cout;
  
  generate
    for(i = 0;i < w;i = i + 1) begin : FAC
      if(i == 0)
        fac Fac(.x(x[i]), .y(y[i]), .z(o[i]), .cin(ci), .co(cout[0]));
      else if(i == w - 1)
        fac Fac(.x(x[i]), .y(y[i]), .z(o[i]), .cin(cout[i - 1]), .co(cout[i]));
      else
        fac Fac(.x(x[i]), .y(y[i]), .z(o[i]), .cin(cout[i - 1]), .co(cout[i]));
    end
    
  endgenerate
  
endmodule

module fac (
  input x,
  input y,
  input cin,
  output co,
  output z
);
  
  assign z = (x ^ y) ^ cin;
  assign co = (x & y) | (x & cin) | (y & cin);
  
endmodule
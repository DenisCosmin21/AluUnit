module mux #(
  parameter w = 1,
  parameter in_cnt = 4
)(
  input [w - 1 : 0] in [0 : in_cnt - 1],
  input [in_cnt - 1 : 0] sel,
  output [w - 1 : 0] o,
  );
  
  assign o = in[sel];
  
endmodule
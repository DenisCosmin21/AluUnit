module dec #(
  parameter in_cnt = 2,
  parameter out_cnt = (1 << in_cnt)
)(
  input [in_cnt - 1 : 0] in,
  output [out_cnt - 1 : 0] o,
);
  
  assign o = 1 << in;
  
endmodule 
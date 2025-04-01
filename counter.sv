module counter #(
  parameter max = 7
)(
  input clk,
  input rst,
  input en,
  output [2 : 0] o
);
  
  wire [2 : 0] count;
  
  shift_register #(.w(3)) CountTotal(.clk(clk), .rst(rst), .parallelIn(count + 1), .serialIn(1'b0), .en(en), .rshift(1'b0), .lshift(1'b0), .load(en), .parallelOut(count));
  
  assign o = count;
  
endmodule
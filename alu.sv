module alu #(
  parameter w = 8
)(
  input [w - 1 : 0] in,
  input [1 : 0] op_codes,
  input valid,
  input clk,
  input clk2,
  input rst,
  output reg [w - 1 : 0] o,
  output reg ready
);
  
  wire [14 : 0] c;
  
  wire q_minus_one;
  
  wire [w - 1 : 0] q;
  wire [w - 1 : 0] m;
  wire [w - 1 : 0] a;
  wire [w - 1 : 0] outAdder;
  wire [w - 1 : 0] complementedM;
  wire [w - 1 : 0] multiplexedAdderInput;
  wire [w - 1 : 0] multiplexedQInput;
  wire [w - 1 : 0] multiplexedAInput;
  
  wire multiplexedQMinusOne;
  
  wire [2 : 0] cnt;
  wire aSerialOut;
  wire qSerialOut;
  wire multiuplexedASerialIn;
  wire multiplexedQSerialIn;
  wire selQ;
  
  ffd Q_minus_one_flip_flop(.clk(clk2), .d(multiplexedQMinusOne), .en(c[8] | c[9]), .rst(rst), .o(q_minus_one));
  
  shift_register Q(.parallelIn(multiplexedQInput), .serialIn(multiplexedQSerialIn), .clk(clk2), .rst(rst), .en( c[10] | c[4] | c[9] | c[12] | c[14]), .lshift(c[4]), .rshift(c[9]), .load(c[10] | c[12] | c[14]), .parallelOut(q), .serialOut(qSerialOut));
  
  shift_register M(.parallelIn(in), .serialIn(1'b0), .clk(clk2), .rst(rst), .en(c[1]), .lshift(1'b0), .rshift(1'b0), .load(c[1]), .parallelOut(m));
  
  shift_register A(.parallelIn(multiplexedAInput), .serialIn(multiplexedASerialIn), .clk(clk2), .rst(rst | c[13]), .en(c[2] | c[9] | c[4] | c[11]), .lshift(c[4]), .rshift(c[9]), .load(c[2] | c[11]), .parallelOut(a), .serialOut(aSerialOut));
  
  c1 ComplementM(.in(m), .en(c[3]), .out(complementedM));
  
  mux #(.w(w), .in_cnt(2)) MuxAdderIn(.in({q, a}), .sel({0, c[2]}), .o(multiplexedAdderInput));
  
  mux #(.w(w), .in_cnt(3)) MuxQ(.in({in, outAdder, {q[w - 1 : 1], 1'b1}}), .sel({6'b000000, c[14], c[10]}), .o(multiplexedQInput));
  
  mux #(.w(w), .in_cnt(2)) MuxA(.in({in, outAdder}), .sel({0, c[2]}), .o(multiplexedAInput));
  
  mux #(.in_cnt(2)) MuxQMinuOne(.in({1'b0, qSerialOut}), .sel({0, c[9]}), .o(multiplexedQMinusOne));
  
  mux #(.in_cnt(2)) MuxSerialInA(.in({a[7], qSerialOut}), .sel({0, c[4]}), .o(multiplexedASerialIn));
  
  mux #(.in_cnt(2)) MuxSerialInQ(.in({1'b0, aSerialOut}), .sel({0, c[9]}), .o(multiplexedQSerialIn));
  
  adder ParallelAdder(.x(multiplexedAdderInput), .y(complementedM), .ci(c[3]), .o(outAdder));
  
  counter Count(.clk(clk), .rst(rst | c[0]), .en(c[5]), .o(cnt));
  
  control_unit AluControlUnit(.clk( clk), .rst(rst), .start(valid), .q_minus_one(q_minus_one), .q_zero(q[0]), .a_seven(a[7]), .cnt_7(cnt[0] & cnt[1] & cnt[2]), .op_codes(op_codes), .c(c), .finish(ready));
  
  always @(*) begin
    if(c[6])
      o = a;
    if(c[7])
      o = q;
  end
  
endmodule
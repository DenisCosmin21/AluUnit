

module alu #(
  parameter w = 8
)(
  input [w - 1 : 0] in,
  input clk,
  input rst,
  input cin,
  input valid,
  output reg [w - 1 : 0] o,
  output reg ready,
  output reg overflow,
  output reg cout,
  output reg divizor_zero
);
  
  reg [2 : 0] load_signals;
  reg [w - 1] data_in [0 : 1];
  reg [1 : 0] op_codes;
  reg [3 : 0] en_operation;
  
  shift_register #() x(.in(in), .rst(rst), .clk(clk), .rshift(1'b0), .lshift(1'b0), .load(load_signals[0]), .en(valid), .o(data_in[0]));
  
  shift_register #() y(.in(in), .rst(rst), .clk(clk), .rshift(1'b0), .lshift(1'b0), .load(load_signals[1]), .en(valid), .o(data_in[1]));
  
  shift_register #(.w(2)) op(.in(in[1 : 0]), .rst(rst), .clk(clk), .rshift(1'b0), .lshift(1'b0), .load(load_signals[2]), .en(valid), .o(op_codes));
  
  dec #() DecOp(.in(in), .o(en_operation));
  
  always @(*) begin
    if(load_signals[2] & 1 & ~clk) begin
      load_signals = 1;
      ready = 0;
    end
    if(~clk & valid & ready) begin
      if(~(load_signals[2] & 1))
        load_signals = load_signals << 1;
    end
  end
  
  
  always @(posedge clk or negedge rst) begin
    if(~rst) begin
      divizor_zero <= 0;
      cout <= 0;
      overflow <= 0;
      ready <= 1;
      load_signals <= 1;
    end
  end
  
endmodule
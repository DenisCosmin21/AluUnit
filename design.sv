`include "adder.sv"
`include "subtractor.sv"
`include "fifo_controller.sv"
`include "dec.sv"
`include "mux.sv"
`include "alu.sv"
`include "shift_register.sv"
`include "c1.sv"

module control_path #(
  parameter w = 8
)(
  input [w - 1 : 0] in,
  input clk,
  input rst,
  input valid,
  output reg [w - 1 : 0] out
);
  
  reg valid_rd;
  
  reg ready_wr;
  
  reg [w - 1 : 0] fifo_out;
  reg [w - 1 : 0] alu_in;
  reg ready_alu;
  reg overflow;
  reg cout;
  reg divizor_zero;
  
  fifo_controller #() Fifo(.clk(clk), .rst(rst), .in(in), .valid_wr(valid & valid_rd & ready_wr), .valid_rd(valid_rd), .ready_wr(ready_wr), .ready_rd(valid_rd & ready_alu), .o(fifo_out));
  
  mux #(.in_cnt(2)) DataSelect(.in({in, fifo_out}), .sel({w-1'b0, valid_rd}), .o(alu_in));
  
  alu #() AluUnit(.in(alu_in), .clk(clk), .rst(rst), .cin(1'b0), .valid(valid_rd | valid), .o(o), .ready(ready_alu), .overflow(overflow), .cout(cout), .divizor_zero(divizor_zero));
  
  		
endmodule


    
`include "adder.sv"
`include "mux.sv"
`include "alu.sv"
`include "shift_register.sv"
`include "c1.sv"
`include "control_unit.sv"
`include "counter.sv"
`include "dec.sv"

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

  
  		
endmodule


    
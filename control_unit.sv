`include "modulo_n_sequence_counter.sv"

module control_unit(
  	input q_minus_one,
  	input q_zero,
  	input a_seven,
  	input cnt_7,
  	input clk,
  	input start,
  	input rst,
 	input [1 : 0] op_codes,
    output finish,
  output [14 : 0] c,
);
  
  wire [3 : 0] secv;
  wire [2 : 0] Q;
  
  modulo_n_sequence_counter #() NumaratorSecventa(.clk(clk), .rst(rst), .start(start), .finish(finish), .secv(secv));
  
  sr_ff Cycle1(.S(start), .R(Q[0] & secv[3]), .clk(clk),  .rst(rst), .Q(Q[0]));
  sr_ff Cycle2(.S(Q[0] & secv[3]), .R(reset_cycle_2), .clk(clk), .rst(rst), .Q(Q[1]));
  sr_ff Cycle3(.S(reset_cycle_2), .R(finish), .rst(rst), .clk(clk), .Q(Q[2]));
  
  wire reset_cycle_2;

  wire c0;
  wire c1;
  wire c2;
  wire c3;
  wire c4;
  wire c5;
  wire c6;
  wire c7;
  wire c8;
  wire c9;
  wire c10;
  wire c11;
  wire c12;
  wire c13;
  wire c14;
  
  mux MuxCycle2(.in({Q[1] & secv[3], Q[1] & secv[3], Q[1] & secv[3] & cnt_7, Q[1] & secv[3] & cnt_7}), .sel({0, op_codes}), .o(reset_cycle_2));
  
  assign finish = c7;
  
  assign c[0] = c0;
  assign c[1] = c1;
  assign c[2] = c2;
  assign c[3] = c3;
  assign c[4] = c4;
  assign c[5] = c5;
  assign c[6] = c6;
  assign c[7] = c7;
  assign c[8] = c8;
  assign c[9] = c9;
  assign c[10] = c10;
  assign c[11] = c11;
  assign c[12] = c12;
  assign c[13] = c13;
  assign c[14] = c14;
  
  mux MuxC0(.in({1'b0, 1'b0, Q[0] & secv[0], Q[0] & secv[0]}), .sel({0, op_codes}), .o(c0));
  
  mux MuxC1(.in({Q[0] & secv[1], Q[0] & secv[1], Q[0] & secv[1], Q[0] & secv[2]}), .sel({0, op_codes}), .o(c1));
  
  mux MuxC2(.in({1'b0, 1'b0, (Q[1] & secv[0]) & ((~q_zero & q_minus_one) | (q_zero & ~q_minus_one)), (secv[0] | (secv[1] & a_seven)) & Q[1]}), .sel({0, op_codes}), .o(c2));
  
  mux MuxC3(.in({1'b0, Q[1] & secv[0], secv[0] & Q[1] & q_zero & (~q_minus_one), Q[1] & secv[0]}), .sel({0, op_codes}), .o(c3));
  
  mux MuxC4(.in({1'b0, 1'b0, 1'b0, (secv[2] & Q[1] & ~cnt_7) | (secv[2] & Q[0])}), .sel({0, op_codes}), .o(c4));
  
  mux MuxC5(.in({1'b0, 1'b0, secv[1] & Q[1] & (~cnt_7), secv[3] & Q[1] & (~cnt_7)}), .sel({0, op_codes}), .o(c5));
  
  mux MuxC6(.in({1'b0, 1'b0, Q[2] & secv[0], Q[2] & secv[0]}), .sel({0, op_codes}), .o(c6));
  
  mux MuxC7(.in({secv[0] & Q[2], secv[0] & Q[2], secv[1] & Q[2], secv[1] & Q[2]}), .sel({0, op_codes}), .o(c7));
  
  mux MuxC8(.in({1'b0, 1'b0, secv[0] & Q[0], 0}), .sel({0, op_codes}), .o(c8));
  
  mux MuxC9(.in({1'b0, 1'b0, (secv[1] & ~cnt_7 & Q[1]) | (secv[0] & Q[2]), 0}), .sel({0, op_codes}), .o(c9));
  
  mux MuxC10(.in({secv[0] & Q[1], secv[0] & Q[1], 0, 0}), .sel({0, op_codes}), .o(c10));
  
  mux MuxC11(.in({1'b0, 1'b0, 1'b0, secv[0] & Q[0]}), .sel({0, op_codes}), .o(c11));
  
  mux MuxC12(.in({secv[0] & Q[0], secv[0] & Q[0], secv[0] & Q[0], secv[1] & Q[0]}), .sel({0, op_codes}), .o(c12));
  
  mux MuxC13(.in({Q[0] & secv[0], Q[0] & secv[0], Q[0] & secv[0], 1'b0}), .sel({0, op_codes}), .o(c13));
  
  mux MuxC14(.in({1'b0, 1'b0, 1'b0, Q[1] & secv[1] & ~a_seven}), .sel({0, op_codes}), .o(c14));
  
endmodule


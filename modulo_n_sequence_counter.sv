module modulo_n_sequence_counter #(
	parameter w = 4
)(
	input start,
  	input clk,
  	input rst,
  	input finish,
  	output [w - 1 : 0] secv
);
  
  wire serialOut;
  wire started;
  wire [1 : 0] encoded_secv;
  
  sr_latch Started(.S(start), .R(finish), .Q(started));
  
  counter #(.max(w - 1)) CounterForSecv(.clk(clk), .rst(rst), .en(started), .o(encoded_secv));
  
  dec #(.in_cnt(2), .out_cnt(4)) SecvDecodificator(.in(encoded_secv), .o(secv));
	
endmodule

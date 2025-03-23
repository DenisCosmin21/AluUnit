module testbench();
  
  reg [7 : 0] x;
  reg [7 : 0] y;
  wire [7 : 0] o;
  reg bi;
  wire bo;
  wire [2 : 0] sum;
  wire overflow;
  
  subtractor #() Subtractor(.x(x), .y(y), .o(o), .bi(bi), .bo(bo));
  
  adder #(.w(3)) Adder(.x(x), .y(y), .o(sum), .ci(bi), .co(bo), .overflow(overflow));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    x = 7;
    y = 4;
    bi = 0;
    #10;
  end
  
endmodule
  
  

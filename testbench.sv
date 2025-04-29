module testbench();
  
  reg clk, rst, start, q_zero,q_minus_one, a_seven, cnt_7, clk2;
  
  reg [1 : 0] op_codes;
  
  wire ready;
  
  reg valid;
  
  reg [7 : 0] in;
  
  wire [7 : 0] o;
  
  alu Alu(.in(in), .op_codes(op_codes), .valid(valid), .clk(clk), .clk2(clk2), .rst(rst), .o(o), .ready(ready));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    op_codes = 2'b01;
    #10; 
    valid = 1;
    in = 3;
    #10;
    #10;
    valid = 0;
    in = 2;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
  end
  
  initial begin
    integer i;
    clk = 0;
    rst = 0;
    #10;
    clk2 = 1;
    rst = 1;
    for(i = 0;i < 100;i = i + 1) begin
      clk = ~clk;
      clk2 = ~clk2;
      #10;
    end
  end
  
endmodule
  
  

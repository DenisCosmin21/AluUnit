module testbench();
  
  reg clk, rst, start, q_zero,q_minus_one, a_seven, cnt_7;
  
  reg [1 : 0] op_codes;
  
  wire ready;
  
  reg valid;
  
  reg [7 : 0] in;
  
  wire [7 : 0] o;
  
  alu Alu(.in(in), .op_codes(op_codes), .valid(valid), .clk(clk), .rst(rst), .o(o), .ready(ready));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    #10;
    op_codes = 2'b10;
    valid = 1;
    in = 10;
    #10;
    valid = 0;
    #10;
    in = 5;
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
    q_zero = 0;
    cnt_7 = 1;
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
    rst = 1;
    for(i = 0;i < 100;i = i + 1) begin
      clk = ~clk;
      #10;
    end
  end
  
endmodule
  
  

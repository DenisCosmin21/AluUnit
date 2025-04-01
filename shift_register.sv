module shift_register #(
  parameter w = 8
)(
  input [w - 1 : 0] parallelIn,
  input serialIn,
  input lshift,
  input rshift,
  input load,
  input rst,
  input en,
  input clk,
  output reg serialOut,
  output reg [w - 1 : 0] parallelOut,
);
  
  wire [w - 1 : 0] outFlipFlop;
  
  genvar i;
  
  generate
    
    for(i = 0;i < w;i = i + 1) begin : FlipFlop
      wire d = (load) ? parallelIn[i] : 
      (rshift & ~lshift) ? ((i == w - 1) ? serialIn : outFlipFlop[i + 1]) : //Rshift
      (lshift & ~rshift) ? ((i == 0) ? serialIn : outFlipFlop[i - 1]) : //Lshit	  
      outFlipFlop[i]; 
      //Preparing the values for shifting data from register
      
      ffd FFD(.clk(clk), .rst(rst), .en(en), .d(d), .o(outFlipFlop[i]));
      
    end
    
  endgenerate
  
  assign serialOut = (lshift) ? outFlipFlop[w - 1] : ((rshift) ? outFlipFlop[0] : 0);
  assign parallelOut = outFlipFlop;
  
endmodule

module ffd(
  input clk,
  input rst,
  input d,
  input en,
  output reg o
);
  
  reg data;
  
  always @(posedge clk or negedge rst) begin
    if(~rst) begin
      data <= 0;
    end
    else if(clk)
      if(en) 
        data <= d;
  end
  
  assign o = data;
  
endmodule

module sr_ff (
    input S,   // Set
    input R, 
  	input rst,
  	input clk,
    output reg Q,
  	output reg Q_bar
);
  
  always @(posedge clk or negedge rst) begin
    if(~rst) begin
      Q <= 0;
   	 	Q_bar <= 1;
    end
    else begin
       if (~S & R) begin
           Q <= 0;
         	Q_bar <= 1;
       end
       else if (S & ~R) begin
           Q <= 1;
         	Q_bar <= 0;
       end
    end
end
    
endmodule

module sr_latch (
    input S,   // Set
    input R, 
  	input rst,
    output reg Q,
  	output reg Q_bar
);
  
  always @(*) begin
    if(~rst) begin
      Q = 0;
   	 	Q_bar = 1;
    end
    else begin
       if (~S & R) begin
           Q = 0;
         	Q_bar = 1;
       end
       else if (S & ~R) begin
           Q = 1;
         	Q_bar = 0;
       end
    end
end
    
endmodule
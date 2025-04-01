module fifo #(
  parameter w = 8,
  parameter reg_cnt = 1024
)(
  input [w - 1 : 0] in,
  input en_rd,
  input en_wr,
  input rst,
  input clk,
  output reg fifo_full,
  output reg fifo_empty,
  output reg [w - 1 : 0] o
);
  
  //Declaring fifo signals
  wire [w - 1 : 0] fifo_out [0 : reg_cnt - 1];
  
  reg [reg_cnt - 1 : 0] load_signals;
  
  reg [9 : 0] wr_pointer;
  reg [9 : 0] rd_pointer;
  
  //Instantiating FIFO registers
  
  generate
    genvar i;
    
    for(i = 0;i < reg_cnt;i = i+1) begin : fifo_register
      shift_register #() Reg(.rst(rst), .clk(clk), .in(in), .en(en_wr), .lshift(1'b0), .rshift(1'b0), .load(load_signals[i]), .o(fifo_out[i]));
    end
  endgenerate
  
  always @(posedge en_wr or posedge en_rd) begin
    if(en_wr) begin
        fifo_empty = 0;
        wr_pointer = wr_pointer + 1;
        if(wr_pointer == reg_cnt)
          wr_pointer = 0;
      end
      //Read combinational logic for the pointers
      if(en_rd) begin
        fifo_full = 0;
        o = fifo_out[rd_pointer];
        rd_pointer = rd_pointer + 1;
        if(rd_pointer == reg_cnt)
          rd_pointer = 0;
      end
  end
  
  always @(*) begin
    load_signals = 1 << wr_pointer;
    //Write combinational logic for the pointers
      
    if(~clk) begin
      if(en_wr) begin
        if(wr_pointer == rd_pointer | wr_pointer == reg_cnt)
          fifo_full = 1;
        else
          fifo_full = 0;
      end
      if(en_rd) begin
        if(rd_pointer == wr_pointer | rd_pointer == reg_cnt)
          fifo_empty = 1;
        else
          fifo_empty = 0;
      end
    end
  end
  
  always @(negedge rst) begin
    if(~rst) begin
      fifo_full <= 0;
      fifo_empty <= 1;
      load_signals <= 0;
      rd_pointer <= 0;
      wr_pointer <= 0;
    end
  end
  
endmodule

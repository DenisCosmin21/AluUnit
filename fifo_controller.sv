`include "fifo.sv"

module fifo_controller #(
  parameter w = 8
)(
  input clk,
  input rst,
  input valid_wr,
  input ready_rd,
  input [w - 1 : 0] in,
  output reg [w - 1 : 0] o,
  output reg ready_wr,
  output reg valid_rd
);
  
  fifo #(.reg_cnt(2)) Fifo_storage(.in(in), .en_rd(en_rd), .en_wr(en_wr), .rst(rst), .clk(clk), .fifo_full(full), .fifo_empty(empty), .o(o));
  
  //Declaring states
  
  localparam WAIT_RD = 0;
  localparam READ = 1;
  localparam FIFO_EMPTY = 2;
  localparam WAIT_DATA = 0;
  localparam WRITE = 1;
  localparam FIFO_FULL = 2;
  
  reg [1 : 0] st_rd;
  reg [1 : 0] st_next_rd;
  
  reg [1 : 0] st_wr;
  reg [1 : 0] st_next_wr;
  
  reg empty;
  reg full;
  reg en_wr;
  reg en_rd;
  
  //Modeling read operation FSM
      
  always @(*) begin
    case(st_rd) 
      WAIT_RD : if(empty) st_next_rd = FIFO_EMPTY;
      else if(~empty & ready_rd) st_next_rd = READ;
      READ : if(empty) st_next_rd = FIFO_EMPTY;
      else if(~empty & ~ready_rd) st_next_rd = READ;
      FIFO_EMPTY : if(valid_wr & ~ready_rd) st_next_rd = WAIT_RD;
      else if(valid_wr & ready_rd) st_next_rd = READ;
    endcase
  end
  
  always @(*) begin
    case(st_rd)
      WAIT_RD : if(ready_rd & ~empty) en_rd = 1;
      READ : if(~ready_rd | empty) en_rd = 0;
      FIFO_EMPTY : if(ready_rd & ~empty) en_rd = 1;
    endcase
  end
  
  //Moddling write operation FSM
  
  always @(*) begin
    case(st_wr)
      WAIT_DATA : if(valid_wr) st_next_wr = WRITE;
      WRITE : if(full) st_next_wr = FIFO_FULL;
      else if(~full & ~valid_wr) st_next_wr = WAIT_DATA;
      FIFO_FULL : if(ready_rd & ~valid_rd) st_next_wr = WAIT_DATA;
      else if(ready_rd & valid_rd) st_next_wr = WRITE;
    endcase
  end
  
  always @(*) begin
    case(st_wr) 
      WAIT_DATA : if(valid_wr) en_wr = 1;
      WRITE : if(full | ~valid_wr) en_wr = 0;
      FIFO_FULL : if(ready_rd) en_wr = 1;
    endcase
  end
  
  always @(*) begin
    valid_rd = ~empty;
    ready_wr = ~full;
  end
  
  //Sequential logic
  always @(posedge clk or negedge rst) begin
    if(~rst) begin
      en_wr <= 0;
      en_rd <= 0;
      st_rd <= WAIT_RD;
      st_next_rd <= WAIT_RD;
      st_wr <= WAIT_DATA;
      st_next_wr <= WAIT_DATA;
      valid_rd <= 0;
      ready_wr <= 1;
    end
    else begin
      st_rd <= st_next_rd;
      st_wr <= st_next_wr;
    end
    
  end
  
endmodule
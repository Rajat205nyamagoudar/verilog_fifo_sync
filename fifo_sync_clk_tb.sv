`timescale 1ns/1ps

module syn_fifo_tb;

  reg [7:0] din;
  reg wr_en;
  reg rd_en;
  reg clk;
  reg rst;

  wire full;
  wire empty;
  wire [7:0] dout;

  // DUT
  syn_fifo uut (
    .din(din),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .clk(clk),
    .rst(rst),
    .full(full),
    .empty(empty),
    .dout(dout)
  );

  
  always #5 clk = ~clk;

  initial begin

    
    clk   = 0;
    rst   = 0;
    din   = 0;
    wr_en = 0;
    rd_en = 0;

    
    #10;
    rst = 1;
    @(posedge clk);
    wr_en = 1;
    din = 8'd10;

    @(posedge clk);
    din = 8'd20;

    @(posedge clk);
    din = 8'd30;

    @(posedge clk);
    din = 8'd40;

    @(posedge clk);
    wr_en = 0;

    
    @(posedge clk);
    rd_en = 1;

    @(posedge clk);

    @(posedge clk);

    @(posedge clk);

    @(posedge clk);
    rd_en = 0;

    
    @(posedge clk);
    wr_en = 1;
    din = 8'd50;

    @(posedge clk);
    din = 8'd60;

    @(posedge clk);
    wr_en = 0;

   
    @(posedge clk);
    rd_en = 1;

    @(posedge clk);
    @(posedge clk);

    rd_en = 0;

    #20;

    $finish;
  end

  
  initial begin
    $monitor(
      "Time=%0t | rst=%b | wr_en=%b | rd_en=%b | din=%0d | dout=%0d | wr_ptr=%0d | rd_ptr=%0d | full=%b | empty=%b",
      $time, rst, wr_en, rd_en, din, dout,
      uut.wr_ptr, uut.rd_ptr, full, empty
    );
  end

  
  initial begin
    $dumpfile("fifo.vcd");
    $dumpvars(0, syn_fifo_tb);
  end

endmodule

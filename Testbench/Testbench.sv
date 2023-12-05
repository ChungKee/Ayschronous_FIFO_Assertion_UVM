`include "AsynFIFO_SVA.sv"

module test;
    parameter DataSize = 8;
    parameter AddrSize = 3;

    bit Wclk    = 0;
    bit Rclk    = 0;
    bit Wresetn = 0;
    bit Rresetn = 0;
    bit Push    = 0;
    bit Pop    = 0;
    bit [DataSize - 1]DataIn  = 0;
    bit [DataSize - 1]DataOut;
    bit full,empty;

    AsynchronousFIFO #(DataSize,AddrSize) myAFIFO
    (
      .Wclk(Wclk), 
      .Rclk(Rclk), 
      .Wresetn(Wresetn), 
      .Rresetn(Rresetn), 
      .Push(Push), 
      .Pop(Pop), 
      .DataIn(DataIn), 
      
      .DataOut(DataOut), 
      .full(full), 
      .empty(empty)  
    );

    bind myAFIFO AFIFO_Property AFFP(
    .Wclk(Wclk),
    .Rclk(Rclk),
    .Wresetn(Wresetn),
    .Rresetn(Rresetn),
    .Push(Push),
    .Pop(Pop),
    .DataIn(DataIn),
    .DataOut(DataOut),
    .full(full),
    .empty(empty),
    .WritePtr(WritePtr),
    .ReadPtr(ReadPtr)
    );
  
    always #20 Rclk = ~Rclk;
    always #10 Wclk = ~Wclk;
    
    initial begin
        @(posedge Wclk);
        Wresetn = 1;
        Rresetn = 1;
        @(posedge Wclk);
        DataIn <= 10;
        Push   <= 1;
    end
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        #2000 $finish();
    end
  
endmodule
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "AsynFIFO_SVA.sv"
`include "AsynFIFO_interface.sv"
`include "AsynFIFO_sequence_item.sv"
`include "AsynFIFO_sequence.sv"
`include "AsynFIFO_WriteDriver.sv"
`inlcude "AsynFIFO_test.sv"

module test;
    parameter DataSize = 3;
    parameter AddrSize = 3;
    
    AsynchronouFIFO_interface #(DataSize) Afifo_if();
    
    AsynchronousFIFO #(DataSize,AddrSize) myAFIFO
    (
      .Wclk(Afifo_if.Wclk), 
      .Rclk(Afifo_if.Rclk), 
      .Wresetn(Afifo_if.Wresetn), 
      .Rresetn(Afifo_if.Rresetn), 
      .Push(Afifo_if.Push), 
      .Pop(Afifo_if.Pop), 
      .DataIn(Afifo_if.DataIn), 
      
      .DataOut(Afifo_if.DataOut), 
      .full(Afifo_if.full), 
      .empty(Afifo_if.empty)  
    );

    bind AsynchronousFIFO AFIFO_Property#(.DataSize(DataSize), .AddrSize(AddrSize))
    AFFP(
        .*
    );
  
    always #30 Afifo_if.Rclk = ~Afifo_if.Rclk;
    always #40 Afifo_if.Wclk = ~Afifo_if.Wclk;

    initial begin
        Afifo_if.Rclk = 0;
        @(posedge Afifo_if.Rclk)
        Afifo_if.Rresetn = 0;
        @(posedge Afifo_if.Rclk)
        Afifo_if.Rresetn = 1;
    end
    initial begin
        Afifo_if.Wclk = 0;
        @(posedge Afifo_if.Wclk)
        Afifo_if.Wresetn = 0;
        @(posedge Afifo_if.Wclk)
        Afifo_if.Wresetn = 1;
    end
   
    initial begin
        uvm_config_db#(virtual AsynchronouFIFO_interface)::set(null, "*", "Afifo_if", Afifo_if);
        run_test("AsynFIFO_test")
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
  
endmodule
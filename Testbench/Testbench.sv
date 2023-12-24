`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "AsynFIFO_Assertion.sv"
`include "AsynFIFO_interface.sv"
`include "AsynFIFO_sequence_item.sv"
`include "AsynFIFO_WriteSequence.sv"
`include "AsynFIFO_ReadSequence.sv"
`include "AsynFIFO_WriteDriver.sv"
`include "AsynFIFO_WriteMonitor.sv"
`include "AsynFIFO_WriteAgent.sv"
`include "AsynFIFO_ReadDriver.sv"
`include "AsynFIFO_ReadMonitor.sv"
`include "AsynFIFO_ReadAgent.sv"
`include "AsynFIFO_scoreboard.sv"
`include "AsynFIFO_env.sv"
`include "AsynFIFO_test.sv"

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
    initial begin
        Afifo_if.Rclk = 0;
        Afifo_if.Wclk = 0;
    end  
    always #30 Afifo_if.Rclk = ~Afifo_if.Rclk;
    always #40 Afifo_if.Wclk = ~Afifo_if.Wclk;
   
    initial begin
        uvm_config_db#(virtual AsynchronouFIFO_interface)::set(null, "*", "Afifo_if", Afifo_if);
        run_test("AsynFIFO_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
  
endmodule
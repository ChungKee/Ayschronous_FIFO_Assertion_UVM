module AFIFO_Property #
(
    parameter DataSize = 3,
    parameter AddrSize = 3
)

(
    Wclk,
    Rclk,
    Wresetn,
    Rresetn,
    Push,
    Pop,
    DataIn,
    DataOut,
    full,
    empty,
    WritePtr,
    ReadPtr
);
    parameter PtrWidth = $clog2(AddrSize);
    input Wclk;
    input Rclk;
    input Wresetn;
    input Rresetn;
    input Push;
    input Pop;
    input [DataSize - 1 : 0] DataIn;
    input [DataSize - 1 : 0] DataOut;
    input full;
    input empty;
    input [PtrWidth : 0] WritePtr;
    input [PtrWidth : 0] ReadPtr;

    property ResetEmpty;
        @(posedge Rclk) !Rresetn |-> empty;
    endproperty
    
    property ResetFull;
        @(posedge Wclk) !Wresetn |-> !full;
    endproperty

    property EmptyNoFull;
        @(posedge Rclk) disable iff (!Rresetn) 
        @(posedge Rclk) empty |=> @(posedge Wclk) ##1 (!full);
    endproperty

    property EmptyDontChangeReadPtr;
        @(posedge Rclk) disable iff (!Rresetn) empty |=> $stable(ReadPtr);
    endproperty

    property FullNoEmpty;
        @(posedge Wclk) disable iff (!Wresetn) 
        @(posedge Wclk) full |=> @(posedge Rclk) ##1 (!empty);
    endproperty

    property FullDontChangeWritePtr;
        @(posedge Wclk) disable iff (!Wresetn) full |=> $stable(WritePtr);
    endproperty


    AResetEmpty: assert property (ResetEmpty) 
    else   $display("Reset Empty must be 1");
    AResetFull: assert property (ResetFull) 
    else   $display("Reset Full must be 0");
    AEmptyNoFull: assert property (EmptyNoFull) 
    else   $display("Empty and full at the same time");
    AEmptyDontChangeReadPtr: assert property (EmptyDontChangeReadPtr) 
    else   $display("Empty and the ReadPtr change");
    AFullNoEmpty: assert property (FullNoEmpty) 
    else   $display("Full and empty at the same time");
    AFullDontChangeWritePtr: assert property (FullDontChangeWritePtr) 
    else   $display("Full and the WritePtr change");

endmodule
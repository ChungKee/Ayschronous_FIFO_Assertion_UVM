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
    
    AResetEmpty: assert property (ResetEmpty) 
    else   $display("Fail reset empty");


endmodule
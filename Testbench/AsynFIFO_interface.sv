interface AsynchronouFIFO_interface #(
    parameter DataSize = 3
);
    logic Wclk; 
    logic Rclk;
    logic Wresetn; 
    logic Rresetn;
    logic Push;
    logic Pop;
    logic [DataSize - 1 : 0] DataIn;
    logic [DataSize - 1 : 0] DataOut;
    logic full;
    logic empty;

endinterface //AsynchronouFIFO_interface
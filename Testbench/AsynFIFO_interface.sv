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

    clocking W_cbd @(posedge Wclk);
        output Wresetn;
        output Push;
        output DataIn;
    endclocking

    clocking W_cbm @(posedge Wclk);
        input Wresetn;
        input Push;
        input DataIn;
        input full;
    endclocking

    clocking R_cbd @(posedge Rclk);
        output Rresetn;
        output Pop;
    endclocking

    clocking R_cbm @(posedge Rclk);
        input Rresetn;
        input Pop;
        input DataOut;
        input empty;
    endclocking

    modport W_drv (clocking W_cbd);
    modport W_mon (clocking W_cbm);
    modport R_drv (clocking R_cbd);
    modport R_mon (clocking R_cbm);

endinterface //AsynchronouFIFO_interface
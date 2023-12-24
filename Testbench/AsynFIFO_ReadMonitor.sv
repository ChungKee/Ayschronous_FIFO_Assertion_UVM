class AsynFIFO_ReadMonitor extends uvm_monitor;
    `uvm_component_utils(AsynFIFO_ReadMonitor)
    uvm_analysis_port #(AsynFIFO_sequence_item) send;
    AsynFIFO_sequence_item tr;
    virtual AsynchronouFIFO_interface  Afifo_if;
      
    function new(input string inst = "AsynFIFO_ReadMonitor", uvm_component parent = null);
       super.new(inst,parent);
    endfunction
      
    virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
        tr = AsynFIFO_sequence_item::type_id::create("tr");
        send = new("send",this);
        if(!uvm_config_db#(virtual AsynchronouFIFO_interface)::get(this, "","Afifo_if", Afifo_if))
            `uvm_error("mon", "Unable to access interface");
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(Afifo_if.R_mon.R_cbm);
            tr.Rresetn = Afifo_if.R_mon.R_cbm.Rresetn;            
            tr.Pop     = Afifo_if.R_mon.R_cbm.Pop;
            tr.DataOut = Afifo_if.DataOut;
            `uvm_info("ReadMon", $sformatf("Rresetn = %d",tr.Rresetn),UVM_NONE);
            `uvm_info("ReadMon", $sformatf("Dataout = %d",tr.DataOut),UVM_NONE);
            send.write(tr);
        end
    endtask      
 
endclass : AsynFIFO_ReadMonitor
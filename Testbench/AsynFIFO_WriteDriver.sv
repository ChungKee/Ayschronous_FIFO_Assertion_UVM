class AsynFIFO_WriteDriver extends uvm_driver #(AsynFIFO_WriteDriver_transaction);
    `uvm_component_utils(AsynFIFO_WriteDriver)
    
    virtual  AsynchronouFIFO_interface  Afifo_if ;
    AsynFIFO_WriteDriver_transaction tr;
 
    
    function new(input string path = "AsynFIFO_WriteDriver", uvm_component parent = null);
        super.new(path,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = Asynchronous::type_id::create("tr");
        if(!uvm_config_db#(virtual AsynchronouFIFO_interface)::get(this, "","Afifo_if", ,Afifo_if))
            `uvm_error("drv", "Unable to access interface")
    endfunction
    
    virtual task run_phase(uvm_phase phase);

    
    endtask
  
endclass : AsynFIFO_WriteDriver
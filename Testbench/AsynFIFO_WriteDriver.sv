class AsynFIFO_WriteDriver extends uvm_driver #(AsynFIFO_sequence_item);
    `uvm_component_utils(AsynFIFO_WriteDriver)
    
    virtual AsynchronouFIFO_interface  Afifo_if;
    AsynFIFO_sequence_item tr;
 
    
    function new(input string path = "AsynFIFO_WriteDriver", uvm_component parent = null);
        super.new(path,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = AsynFIFO_sequence_item::type_id::create("tr");
        if(!uvm_config_db#(virtual AsynchronouFIFO_interface)::get(this, "","Afifo_if", Afifo_if))
            `uvm_error("drv", "Unable to access interface");
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(tr);
                Afifo_if.Wresetn = tr.Wresetn;
                Afifo_if.Push    = tr.Push;
                Afifo_if.DataIn  = tr.DataIn; 
                @(posedge Afifo_if.Wclk);  
            seq_item_port.item_done();
        end
    
    endtask
  
endclass : AsynFIFO_WriteDriver
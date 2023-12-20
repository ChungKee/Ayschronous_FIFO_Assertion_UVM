class AsynFIFO_WriteAgent_config extends uvm_object;
    `uvm_object_utils(AsynFIFO_WriteAgent_config)
    function new(string inst = "AsynFIFO_WriteAgent_config");
        super.new(inst);
    endfunction

    uvm_active_passive_enum is_active = UVM_ACTIVE;
endclass : AsynFIFO_WriteAgent_config

class AsynFIFO_WriteAgent extends uvm_agent;
    `uvm_component_utils(AsynFIFO_WriteAgent)

    //AsynFIFO_WriteMonitor WriteMonitor;
    AsynFIFO_WriteDriver WriteDriver;    
    AsynFIFO_WriteAgent_config cfg;
    uvm_sequencer#(AsynFIFO_sequence_item) seqr;
  
    function new(input string inst = "AsynFIFO_WriteAgent", uvm_component parent = null);
        super.new(inst,parent);
    endfunction
  
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //WriteMonitor = AsynFIFO_WriteMonitor::type_id::create("WriteMonitor",this);
        cfg = AsynFIFO_WriteAgent_config::type_id::create("cfg");
        if (cfg.is_active == UVM_ACTIVE) begin
            WriteDriver = AsynFIFO_WriteDriver::type_id::create("WriteDriver",this);
            seqr = uvm_sequencer#(AsynFIFO_sequence_item)::type_id::create("seqr",this);
        end
        
    endfunction
  
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (cfg.is_active == UVM_ACTIVE) begin
            WriteDriver.seq_item_port.connect(seqr.seq_item_export);
        end
    endfunction
 
endclass : AsynFIFO_WriteAgent
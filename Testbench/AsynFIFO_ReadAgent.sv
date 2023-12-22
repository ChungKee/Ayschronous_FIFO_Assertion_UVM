class AsynFIFO_ReadAgent_config extends uvm_object;
    `uvm_object_utils(AsynFIFO_ReadAgent_config)
    function new(string inst = "AsynFIFO_ReadAgent_config");
        super.new(inst);
    endfunction

    uvm_active_passive_enum is_active = UVM_ACTIVE;
endclass : AsynFIFO_ReadAgent_config

class AsynFIFO_ReadAgent extends uvm_agent;
    `uvm_component_utils(AsynFIFO_ReadAgent)

    AsynFIFO_ReadMonitor ReadMonitor;
    AsynFIFO_ReadDriver ReadDriver;    
    AsynFIFO_ReadAgent_config cfg;
    uvm_sequencer#(AsynFIFO_sequence_item) seqr;
  
    function new(input string inst = "AsynFIFO_ReadAgent", uvm_component parent = null);
        super.new(inst,parent);
    endfunction
  
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ReadMonitor = AsynFIFO_ReadMonitor::type_id::create("ReadMonitor",this);
        cfg = AsynFIFO_ReadAgent_config::type_id::create("cfg");
        if (cfg.is_active == UVM_ACTIVE) begin
            ReadDriver = AsynFIFO_ReadDriver::type_id::create("ReadDriver",this);
            seqr = uvm_sequencer#(AsynFIFO_sequence_item)::type_id::create("seqr",this);
        end
        
    endfunction
  
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (cfg.is_active == UVM_ACTIVE) begin
            ReadDriver.seq_item_port.connect(seqr.seq_item_export);
        end
        
    endfunction
 
endclass : AsynFIFO_ReadAgent
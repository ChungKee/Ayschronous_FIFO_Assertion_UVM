
class AsynFIFO_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(AsynFIFO_scoreboard)
    uvm_analysis_imp#(AsynFIFO_sequence_item, AsynFIFO_scoreboard) recv;

    function new(input string inst = "AsynFIFO_scoreboard", uvm_component parent);
        super.new(inst, parent);
    endfunction
  
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        recv = new("AsynFIFO_recv",this);
    endfunction
    
    virtual function void write(AsynFIFO_sequence_item tr);
        `uvm_info("AsynFIFO_sco",$sformatf("Wresetn = %d, Resetn = %d",tr.Wresetn,tr.Rresetn),UVM_NONE);
    endfunction
endclass : AsynFIFO_scoreboard

class AsynFIFO_WriteMonitor extends uvm_monitor;
    `uvm_component_utils(AsynFIFO_WriteMonitor)
    uvm_analysis_port #(AsynFIFO_sequence_item) send;
    AsynFIFO_sequence_item tr;
    virtual AsynchronouFIFO_interface  Afifo_if;
      
    function new(input string inst = "AsynFIFO_WriteMonitor", uvm_component parent = null);
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
            @(Afifo_if.W_mon.W_cbm);
            tr.Wresetn = Afifo_if.W_mon.W_cbm.Wresetn;            
            tr.Push    = Afifo_if.W_mon.W_cbm.Push;
            tr.DataIn  = Afifo_if.W_mon.W_cbm.DataIn;
            `uvm_info("WriteMon",$sformatf("Wresetn = %d",Afifo_if.W_mon.W_cbm.Wresetn),UVM_NONE);
            send.write(tr);
        end
    endtask
 
endclass : AsynFIFO_WriteMonitor
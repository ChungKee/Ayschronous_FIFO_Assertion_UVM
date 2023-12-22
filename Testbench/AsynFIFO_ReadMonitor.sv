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
            @(posedge Afifo_if.Rclk);
            tr.Rresetn = Afifo_if.Rresetn;            
            tr.Pop = Afifo_if.Pop;
            tr.DataOut = Afifo_if.DataOut;
            send.write(tr);
        end
    endtask      
 
endclass : AsynFIFO_ReadMonitor
class AsynFIFO_ReadDriver extends uvm_driver #(AsynFIFO_sequence_item);
    `uvm_component_utils(AsynFIFO_ReadDriver)
    
    virtual AsynchronouFIFO_interface Afifo_if;
    AsynFIFO_sequence_item tr;
 
    
    function new(input string path = "AsynFIFO_ReadDriver", uvm_component parent = null);
        super.new(path,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = AsynFIFO_sequence_item::type_id::create("tr");
        if(!uvm_config_db#(virtual AsynchronouFIFO_interface)::get(this, "","Afifo_if", Afifo_if))
            `uvm_error("read_drv", "Unable to access interface");
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(tr);
            //@(Afifo_if.R_drv.R_cbd);  
            //Afifo_if.R_drv.R_cbd.Rresetn <= tr.Rresetn;
            //Afifo_if.R_drv.R_cbd.Pop     <= tr.Pop;
            @(posedge Afifo_if.Rclk)
          	Afifo_if.Rresetn <= tr.Rresetn;
            if(Afifo_if.empty) Afifo_if.Pop = 0;
            else Afifo_if.Pop = tr.Pop;
            `uvm_info("ReadDriver", $sformatf("empty = %d pop = %d",Afifo_if.empty,Afifo_if.Pop),UVM_NONE);
            seq_item_port.item_done();
        end
    
    endtask
  
endclass : AsynFIFO_ReadDriver
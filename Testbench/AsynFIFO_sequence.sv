class AsynFIFO_sequence extends uvm_sequence#(AsynFIFO_sequence_item) ;
    `uvm_object_utils(AsynFIFO_sequence)
    
    AsynFIFO_sequence_item tr;  
  
    function new(string name = "AsynFIFO_sequence");
        super.new(name);
    endfunction
    
    virtual task body();
        tr = AsynFIFO_sequence_item::type_id::create("tr");
        start_item(tr);

        finish_item(tr);
    endtask
endclass : AsynFIFO_sequence
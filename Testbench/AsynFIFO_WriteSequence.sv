class AsynFIFO_WriteSequence extends uvm_sequence#(AsynFIFO_sequence_item);
    `uvm_object_utils(AsynFIFO_WriteSequence)
    
    AsynFIFO_sequence_item tr;  
  
    function new(string name = "AsynFIFO_WriteSequence");
        super.new(name);
    endfunction
    
    virtual task body();
        tr = AsynFIFO_sequence_item::type_id::create("tr");
        for(int i = 0; i < 30; i++)begin
            $display("[Write]i = %d",i);
            start_item(tr);
                if(!tr.randomize()) $display("Random fail")
                if(i < 2)begin
                    tr.Wresetn = 0;
                end
                else begin
                    tr.Wresetn = 1;
                end
            finish_item(tr);
        end
    endtask
endclass : AsynFIFO_WriteSequence
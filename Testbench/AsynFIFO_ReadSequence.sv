class AsynFIFO_ReadSequence extends uvm_sequence#(AsynFIFO_sequence_item);
    `uvm_object_utils(AsynFIFO_ReadSequence)
    
    AsynFIFO_sequence_item tr;  
  
    function new(string name = "AsynFIFO_ReadSequence");
        super.new(name);
    endfunction
    
    virtual task body();
        tr = AsynFIFO_sequence_item::type_id::create("tr");
        for(int i = 0; i < 30; i++)begin
            $display("[Read]i = %d",i);
            start_item(tr);
                if(!(tr.randomize())) $display("Random fail");
                if(i < 2)begin
                    tr.Rresetn = 0;
                end
                else begin
                    tr.Rresetn = 1;
                end
            finish_item(tr);
        end
    endtask
endclass : AsynFIFO_ReadSequence
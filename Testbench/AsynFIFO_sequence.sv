class AsynFIFO_sequence extends uvm_sequence#(AsynFIFO_sequence_item);
    `uvm_object_utils(AsynFIFO_sequence)
    
    AsynFIFO_sequence_item tr;  
  
    function new(string name = "AsynFIFO_sequence");
        super.new(name);
    endfunction
    
    virtual task body();
        tr = AsynFIFO_sequence_item::type_id::create("tr");
        for(int i = 0; i < 5; i++)begin
            $display("i = %d",i);
            start_item(tr);
                tr.Push = 0;
                tr.DataIn = 0;
                if(i == 0)begin
                    tr.Wresetn = 0;
                end
                else begin
                    tr.Wresetn = 1;
                    //tr.randomize();
                end
            finish_item(tr);
        end
    endtask
endclass : AsynFIFO_sequence
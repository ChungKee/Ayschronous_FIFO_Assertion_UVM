class AsynFIFO_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(AsynFIFO_sequence_item)
    bit Wresetn;
    bit Rresetn;
    rand bit Push;
    rand bit Pop;
    rand bit [3:0] DataIn;
    
    bit      [3:0] DataOut;
    bit full;
    bit empty;
    constraint c_Push{Push dist {0:=2, 1:=1};}
    constraint c_Pop{Pop dist {0:=2, 1:=1};}
    //constraint c_Werestn{Wresetn dist {0:=1, 1:=29};}
    //constraint c_Rresetn{Rresetn dist {0:=1, 1:=29};}

    function new(string name = "AsynFIFO_sequence_item");
        super.new(name);
    endfunction
 
endclass : AsynFIFO_sequence_item
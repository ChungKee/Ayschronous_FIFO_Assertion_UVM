class AsynFIFO_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(AsynFIFO_sequence_item)
    logic Wresetn;
    logic Rresetn;
    logic Push;
    logic Pop;
    rand logic [3:0] DataIn;
    logic      [3:0] DataOut;
    logic full;
    logic empty;
  
    function new(string name = "AsynFIFO_sequence_item");
        super.new(name);
    endfunction
 
endclass : AsynFIFO_sequence_item
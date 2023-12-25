
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
    
    bit [2:0] buffer[$:8];

    virtual function void write(AsynFIFO_sequence_item tr);
        
        if(!tr.Wresetn)begin
            while (buffer.size() != 0) begin
                buffer.pop_back();
            end
        end

        if(tr.Push && !tr.full && tr.Wresetn)begin
            buffer.push_back(tr.DataIn);
        end
        if(tr.Pop && !tr.empty && tr.Rresetn)begin
            bit [2:0] temp = buffer.pop_front();
            if(tr.DataOut == temp)begin
                `uvm_info("ScoreBoard",$sformatf("Success dataOut = %d, scoreboard= %d",tr.DataOut,temp),UVM_NONE);
            end
            else begin
                `uvm_error("ScoreBoard",$sformatf("FAIL dataOut = %d, scoreboard= %d",tr.DataOut,temp));
            end
        end
    endfunction
    


endclass : AsynFIFO_scoreboard
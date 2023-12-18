class AsynFIFO_test extends uvm_test;

    `uvm_component_utils(AsynFIFO_test)

    AsynFIFO_sequence sequence;
    AsynFIFO_env env;  
  
    function new(input string inst = "AsynFIFO_test", uvm_component parent);
        super.new(inst, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //sequence = AsynFIFO_sequence::type_id::create("sequence",this);
        sequence = AsynFIFO_sequence::type_id::create("sequence");
        env = AsynFIFO_env::type_id::create("env",this);

    endfunction
  
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for(int i = 0; i < 5; i++)begin
            sequence.start(env.WriteAgent.seqr)
            #500;
        end
        `uvm_info("ASYNFIFO_TEST","END",UVM_NONE)
        phase.drop_objection(this);
    endtask

endclass : AsynFIFO_test

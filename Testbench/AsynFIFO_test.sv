class AsynFIFO_test extends uvm_test;

    `uvm_component_utils(AsynFIFO_test)

    AsynFIFO_ReadSequence Rseqr;
    AsynFIFO_WriteSequence Wseqr;
    AsynFIFO_env env;  
  
    function new(input string inst = "AsynFIFO_test", uvm_component parent);
        super.new(inst, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        Wseqr = AsynFIFO_WriteSequence::type_id::create("WriteSeqr");
        Rseqr = AsynFIFO_ReadSequence::type_id::create("ReadSeqr");
        env = AsynFIFO_env::type_id::create("env",this);

    endfunction
  
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for(int i = 0; i < 5; i++)begin
            fork
            Wseqr.start(env.WriteAgent.seqr);
            Rseqr.start(env.ReadAgent.seqr);
            join
            #100;
        end
        `uvm_info("ASYNFIFO_TEST","END",UVM_NONE)
        phase.drop_objection(this);
    endtask

endclass : AsynFIFO_test

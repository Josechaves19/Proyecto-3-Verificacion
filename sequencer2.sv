class trans_bushandler_sequencer extends uvm_sequencer #(trans_bushandler);
    `uvm_object_utils(trans_bushandler_sequencer)
    
    function new(string name = "trans_bushandler_sequencer", uvm_component parent = null);
       super.new(name, parent);
    endfunction
 
    task run_phase(uvm_phase phase);
       trans_bushandler trans_seq_item;
       phase.raise_objection(this);
       
       // Ejecutar las secuencias aquí
       for (int i = 0; i < 10; i++) begin
          trans_seq_item = trans_bushandler::type_id::create("trans_seq_item", this);
          trans_seq_item.randomize();
          if (!trans_seq_item.randomize())
             `uvm_fatal("trans_bushandler_sequencer", "Randomization failed")
          start_item(trans_seq_item);
          finish_item(trans_seq_item);
       end
       
       phase.drop_objection(this);
    endtask
 endclass
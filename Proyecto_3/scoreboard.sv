class scoreboard extends uvm_scoreboard;
  
  uvm_analysis_imp #(string, scoreboard) conec;
  string internal_state;
  
  `uvm_component_utils(scoreboard)
  
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name,parent);
    conec=new("conec",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    
     phase.raise_objection(this);
    `uvm_warning("Se inicializó el scoreboard", get_type_name())
     phase.drop_objection(this);
    
  endtask
  
  function escribe (string pkt);
    $display("%s",pkt);
  endfunction
  
endclass
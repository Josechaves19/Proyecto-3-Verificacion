class ambiente extends uvm_env; 
    `uvm_component_utils(ambiente)
    agente agente_ambiente;

    //Meter scoreboard
    function new(string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agente_ambiente = agente::type_id::create("agente_ambiente",this);
        //Meter Scoreboard
    endfunction
endclass

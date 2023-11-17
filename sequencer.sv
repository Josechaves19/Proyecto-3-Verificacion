class my_sequencer extend uvm_sequencer;
    `uvm_component_utils (my_sequencer)
    function new(string name = "m_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction //new()
    
endclass //my_sequencer extend uvm_sequencer
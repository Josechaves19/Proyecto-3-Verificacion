class test_1 extends uvm_test; 
    `uvm_component_utils(test_1)
    parameter COLUMNS = 4 ;
    parameter ROWS = 4; 
    parameter pkg_size=40;
    function new(string name = "test_1", uvm_component parent = null);
        super.new(name, parent);
    endfunction


    ambiente ambiente_test;
    trans_sequence secuencia; 
    virtual bus_mesh_if vif;


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ambiente_test = ambiente::type_id::create("ambiente_test",this);

        if(!uvm_config_db#(virtual bus_mesh_if)::get(this,"","vif",vif))
            `uvm_fatal("Test","Could not get vif")
            uvm_config_db#(virtual bus_mesh_if)::set(this,"amb_inst.agent.*","bus_mesh_if",vif);
        secuencia = trans_sequence::type_id::create("secuencia");
        secuencia.randomize() ;
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for (int i=0; i<16 ; i++ ) begin
            automatic int a=i;
      secuencia.start(ambiente_test.agente_ambiente.agente_sequencer[a]);
    end
      phase.drop_objection(this);
  endtask    
endclass

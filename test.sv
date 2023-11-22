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

        //Verifica si se conecto correctamente al interface
        if(!uvm_config_db#(virtual bus_mesh_if)::get(this,"","bus_mesh_if",vif))
            `uvm_fatal("Test","Could not get vif")
            uvm_config_db#(virtual bus_mesh_if)::set(this,"amb_inst.agent.*","bus_mesh_if",vif);
        //Genera la secuencia 
        seq = trans_sequence::type_id::create("seq");
        seq.randomize() with {num_trans inside{[1:10]};};
      //amb_inst.agent_inst.set_report_verbosity_level( UVM_MEDIUM );
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for (int i=0; i<16 ; i++ ) begin
            automatic int a=i;
      seq.start(ambiente_test.agente_ambiente.agente_sequencer[a]);
    end
      phase.drop_objection(this);
  endtask    
endclass
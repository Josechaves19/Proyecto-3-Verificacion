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
            uvm_config_db#(virtual bus_mesh_if)::set(this,"ambiente_test.agente_ambiente.*","vif",vif);
        secuencia = trans_sequence::type_id::create("secuencia");
        secuencia.randomize() ;
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for (int i=0; i<16 ; i++ ) begin
            automatic int contador=i;
      secuencia.start(ambiente_test.agente_ambiente.agente_sequencer[contador]);
    end
      phase.drop_objection(this);
  endtask    
endclass

class test_2 extends uvm_test; //Todos a uno
    `uvm_component_utils(test_2)
    parameter COLUMNS = 4 ;
    parameter ROWS = 4; 
    parameter pkg_size=40;
    function new(string name = "test_2", uvm_component parent = null);
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
            uvm_config_db#(virtual bus_mesh_if)::set(this,"ambiente_test.agente_ambiente.*","vif",vif);
        secuencia = trans_sequence::type_id::create("secuencia");
        secuencia.randomize();
        secuencia.dispositivo_rx=$urandom_range(0,15);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for (int i=0; i<16 ; i++ ) begin
            automatic int contador=i;
      secuencia.start(ambiente_test.agente_ambiente.agente_sequencer[contador]);
      
    end
      phase.drop_objection(this);
  endtask    
endclass


class test_3 extends uvm_test; //Uno a todos
    `uvm_component_utils(test_3)
    parameter COLUMNS = 4 ;
    parameter ROWS = 4; 
    parameter pkg_size=40;
    function new(string name = "test_3", uvm_component parent = null);
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
            uvm_config_db#(virtual bus_mesh_if)::set(this,"ambiente_test.agente_ambiente.*","vif",vif);
        secuencia = trans_sequence::type_id::create("secuencia");
        secuencia.randomize();
        secuencia.dispositivo_tx=$urandom_range(0,15);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for (int i=0; i<16 ; i++ ) begin
            automatic int contador=i;
      secuencia.start(ambiente_test.agente_ambiente.agente_sequencer[contador]);
      
    end
      phase.drop_objection(this);
  endtask    
endclass

class test_4 extends uvm_test; //Misma repeticion 
    `uvm_component_utils(test_4)
    parameter COLUMNS = 4 ;
    parameter ROWS = 4; 
    parameter pkg_size=40;
    function new(string name = "test_4", uvm_component parent = null);
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
            uvm_config_db#(virtual bus_mesh_if)::set(this,"ambiente_test.agente_ambiente.*","vif",vif);
        secuencia = trans_sequence::type_id::create("secuencia");
        secuencia.randomize();
        secuencia.dispositivo_tx=$urandom_range(0,15);
        secuencia.dispositivo_rx=secuencia.dispositivo_tx; 
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for (int i=0; i<16 ; i++ ) begin
            automatic int contador=i;
      secuencia.start(ambiente_test.agente_ambiente.agente_sequencer[contador]);
      
    end
      phase.drop_objection(this);
  endtask    
endclass


class test_5 extends uvm_test; //Circular 
    `uvm_component_utils(test_5)
    parameter COLUMNS = 4 ;
    parameter ROWS = 4; 
    parameter pkg_size=40;
    function new(string name = "test_5", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    int a=$urandom_range(0,15); 

    ambiente ambiente_test;
    trans_sequence secuencia; 
    virtual bus_mesh_if vif;


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ambiente_test = ambiente::type_id::create("ambiente_test",this);

        if(!uvm_config_db#(virtual bus_mesh_if)::get(this,"","vif",vif))
            `uvm_fatal("Test","Could not get vif")
            uvm_config_db#(virtual bus_mesh_if)::set(this,"ambiente_test.agente_ambiente.*","vif",vif);
        secuencia = trans_sequence::type_id::create("secuencia");
        secuencia.randomize();
        $display("AAAAAAAAAAAAAA %0d", a);
        secuencia.dispositivo_tx=a;
        $display("BBBBBBBBBBBBB %0d", a); 
        secuencia.dispositivo_rx=a;
        $display("CCCCCCCCCCCCCCCC %0d", a); 
        endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for (int i=0; i<16 ; i++ ) begin
            automatic int contador=i;
      secuencia.start(ambiente_test.agente_ambiente.agente_sequencer[contador]);
      
    end
      phase.drop_objection(this);
  endtask    
endclass



class ambiente extends uvm_env;
    `uvm_component_utils(ambiente)

    function new(string name="ambiente", uvm_component parent=null); 
        super.new(name, parent);
    endfunction

  	agent agent_inst;
    //scoreboard scoreboard_inst;

	//////////////////////////////////////////////////////////////////
    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
      		agent_inst = agent::type_id::create($sformatf("agent"),this);
        //scoreboard_inst = scoreboard::type_id::create("scoreboard_inst", this);
    endfunction
    
    virtual function void connect_phase(uvm_phase phase); 
        super.connect_phase(phase);
		//agent_inst.scoreboard_inst.mon_analysis_port.connect(sb0.m_analysis_imp);
    endfunction
    

endclass
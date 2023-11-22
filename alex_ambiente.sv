class ambiente extends uvm_env; 
    `uvm_component_utils(ambiente)
    agente agente_ambiente;
    scoreboard scoreboard_ambiente;

    //Meter scoreboard
    function new(string name, uvm_component parent=null);
        super.new(name, parent);
    endfunction    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agente_ambiente = agente::type_id::create("agente_ambiente",this);
        //Meter Scoreboard
        scoreboard_ambiente = scoreboard::type_id::create("scoreboard_ambiente",this);
    endfunction
   function void connect_phase(uvm_phase phase);
    // connect agent and scoreboard using TLM interface    
    // Ex. agt.mon.item_collect_port.connect(sb.item_collect_export);
     super.connect_phase(phase);
     agente.agente_monitor.port_monitor.connect(Scoreboard.port_monitor_sb)
     agente.agente_driver.port_driver.connect(Scoreboard.port_driver_sb)
  endfunction

  function write (item trans);
        `uvm_info"write", $sformatf("Se recibe del driver:%h", m_analysis.imp), UVM_HIGH)
        m_analysis_imp[{transaccion_entrante.target_fila, transaccion_entrante.target_columna,transaccion_entrante. payload}] = m_analysis_imp.dato;
  endfunction

endclass

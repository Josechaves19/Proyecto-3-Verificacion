class agente extends uvm_agent;
    parameter int ROWS=4;
    parameter int COLUMNS=4;
    parameter int pkg_size=40;

    driver agente_driver[15:0]; 
    monitor agente_monitor[15:0];
    trans_bushandler_sequencer agente_sequencer[15:0]; //Creo los monitores drivers y secuenciadores

    `uvm_component_utils(agente) //Registro en la fabrica
    function new (string name ="agente", uvm_component parent=null);
       super.new(name, parent);
    endfunction //Constructor

    function void build_phase (uvm_phase phase); 
        super.build_phase(phase);

        for (int i=0; i<16; i++) begin

            automatic int contador=i; 
            agente_driver[contador]=driver::type_id::create($sformatf("agente_driver_%0d", contador),this); 
            agente_monitor[contador]=monitor::type_id::create($sformatf("agente_monitor_%0d", contador),this); 
            agente_sequencer[contador]=trans_bushandler_sequencer::type_id::create($sformatf("agente_sequencer_%0d", contador), this);
            agente_driver[contador].id=contador;
            agente_monitor[contador].id_mntr=contador; 
       end //Instancio los drivers, secuenciadores y monitores, ademas le doy a los drivers y monitores su id 

   endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        for (int i=0; i<16; i++) begin
            automatic int contador=i;
            agente_driver[contador].seq_item_port.connect(agente_sequencer[contador].seq_item_export);
        end ///Conecto el secuenciador con el driver respectivo 
    endfunction

endclass



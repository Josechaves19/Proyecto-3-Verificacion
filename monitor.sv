`include "uvm_macros.svh"

class monitor extends uvm_monitor;
   `uvm_component_utils(monitor);
   parameter pkg_size = 40;
   int id_mntr;
   int count=0;
   virtual bus_mesh_if  vif; //revisar esto
   uvm_analysis_port #(trans_bushandler) port_monitor; // Este puerto va hacia el scoreboard
   trans_bushandler trans;  
   function new(string name = "monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction
  
   virtual function void build_phase(uvm_phase  phase);
     super.build_phase(phase);
     if (!uvm_config_db #(virtual bus_mesh_if)::get(this,"","vif",vif))
     `uvm_fatal("Monitor","No pudo conectarse a vif")
    
     port_monitor = new("mntr_analysis_port",this);
   endfunction
   virtual task run_phase(uvm_phase phase);
          
      super.run_phase(phase);
      `uvm_info("Monitor", $sformatf("Inicializando Monitor"), UVM_LOW)
      vif.pop[id_mntr]=0;
      phase.raise_objection(this);
      begin
        forever begin
            trans= trans_bushandler::type_id::create("trans");
            vif.pop[id_mntr]=0;
            if (vif.pndng[id_mntr]==1) begin
                  trans.pkg = vif.data_out[id_mntr];
                  `uvm_info("Monitor", $sformatf("%0d Recibe Transaccion %40b", id_mntr,  trans.pkg[trans.pkg_size-9:trans.pkg_size-40]), UVM_LOW) 
                  vif.pop[id_mntr]=1;
            end
            @(posedge vif.clk);
            @(posedge vif.clk);
            port_monitor.write(trans);
        end
     end
   endtask
endclass

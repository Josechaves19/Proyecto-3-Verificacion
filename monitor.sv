`include "uvm_macros.svh"

class monitor extends uvm_monitor;
   `uvm_component_utils(monitor);
   parameter pkg_size = 40;
   int id_mntr;
   int count=0;
   virtual bus_mesh_if  vif; //revisar esto
   uvm_analysis_port #(item) mntr_analysis_port; // NO SE SI UVM TIENE UNO DEFINIDO YA

   function new(string name = "monitor", uvm_component parent = null);
      super.new(name, parent);
   endfunction
  
   virtual function void build_phase(uvm_phase  phase);
     super.build_phase(phase);
     if (!uvm_config_db #(virtual bus_mesh_if)::get(this,"","bus_mesh_if",vif))
     `uvm_fatal("Monitor","No pudo conectarse a vif")
     mntr_analysis_port = new("mntr_analysis_port",this);
   endfunction
   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);
      vif.pop[id_mntr]=0;
      phase.raise_objection(this);
      begin
        `uvm_warning("Monitor inicializado"), get_type_name())
        forever begin
            item s_item= item::type_id::create("s_item");
            vif.pop[id_mntr]=0;
            if (vif.pndng[id_mntr]==1) begin
                  s_item.out = vif.data_out[id_mntr];
                  $display("El monitor %0d recibe el mensaje: %b en modo [%d] ", id_mntr, vif.data_out[id_mntr], vif.data_out[id_mntr][pkg_size-17]);
                  vif.pop[id_mntr]=1;
            end
            @(posedge vif.clk);
            if (count > 150) begin
                break;
            end
            count++;
            @(posedge vif.clk);
            mntr_analysis_port.write(s_item);
        end
     end
   endtask
endclass


class monitor extends uvm_monitor;
	`uvm_component_utils(monitor); // Registro en la fabrica

	function new(string name = "monitor", uvm_component parent=null); // Constructor
		super.new(name,parent);
	endfunction
  
  int id_monitor;
  int count = 0;
  virtual bus_mesh_if vif;
	
	uvm_analysis_port #(item) mon_analysis_port; // Puntero para el analisis de puerto para el item en el monitor

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
	virtual function void build_phase(uvm_phase phase); // Fase de construcción
		super.build_phase(phase);
		if (!uvm_config_db #(virtual bus_mesh_if)::get(this,"","bus_mesh_if",vif))
			`uvm_fatal("Monitor","Could not get vif")
		mon_analysis_port = new("mon_analysis_port",this); // Crea el puerto con el puntero
	endfunction

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
      vif.pop[id_monitor]=0;
      phase.raise_objection(this);//esto para ejecutar
      begin 
        `uvm_warning("Se inicializó el monitor", get_type_name())
        
        forever begin
      		vif.pop[id_monitor]=0;
          if (vif.pndng[id_monitor]==1) begin
            //`uvm_info("Monitor",$sformatf("Item %s",item_mon.print_salida()),UVM_HIGH);
            $display("El monitor %d recibe el mensaje: %b ", id_monitor, vif.data_out[id_monitor]);
            vif.pop[id_monitor]=1;
          end
          @(posedge vif.clk);
          if (count > 150) begin
            break;
          end
          count++;
      	  @(posedge vif.clk);
        end
      end
	endtask
endclass


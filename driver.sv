`include "uvm_macros.svh"
//`include "Fifo_ema.sv" //creo que mas bien debería agregar las acciones de
//la fifo directamente

class driver extends uvm_driver #(trans_bushandler);
   `uvm_component_utils(driver)
    uvm_analysis_port #(trans_bushandler) port_driver; 
   int id_drvr; // terminal
   bit[3:0] src;
   bit [3:0] id;

   virtual bus_mesh_if  vif;

   function new(string name = "driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
port_driver=new("analysis_port", this); 
        if(!uvm_config_db#(virtual bus_mesh_if)::get(this,"","vif",vif))
            `uvm_fatal("Driver","No se pudo obtener vif")
            uvm_config_db#(virtual bus_mesh_if)::set(this,"amb_inst.agent.*","vif",vif);
    endfunction

  virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        vif.reset = 1;
        `uvm_info("Driver", $sformatf("Inicializando Driver"), UVM_LOW)
        vif.data_out_i_in[id_drvr] = 0;
        vif.pndng_i_in[id_drvr] = 0; 

        @(posedge vif.clk);
        #1;
        vif.reset = 0;
        
        forever begin
          
          trans_bushandler trans;//items del sequencer i guess
          trans_bushandler trans_scoreboard; 
          seq_item_port.get_next_item(trans);
          `uvm_info("Driver", $sformatf("Transaccion recibida"), UVM_LOW)

          trans_scoreboard=trans_bushandler::type_id::create("trans_scoreboard"); 
          trans_scoreboard.copy(trans);
          port_driver.write(trans_scoreboard); 
          @(posedge vif.clk);
            vif.data_out_i_in[id_drvr] = 0;
            vif.pndng_i_in[id_drvr] = 0;
          @(posedge vif.clk);
            vif.data_out_i_in[id_drvr] = {trans.pkg};
            vif.pndng_i_in[id_drvr] = 1;
          @(posedge vif.clk);
            wait (vif.popin[id_drvr]);
            vif.pndng_i_in[id_drvr] = 0;
            
           `uvm_info("Driver", $sformatf("Envia Transaccion %0b", trans.pkg), UVM_LOW) 
            seq_item_port.item_done();
        end
            //`uvm_info("DRV", $sformatf("Transaccion %s", item, print_transaccion()), UVM_HIGH);
      endtask 

endclass


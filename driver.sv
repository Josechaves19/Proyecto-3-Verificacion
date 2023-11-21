`include "uvm_macros.svh"
//`include "Fifo_ema.sv" //creo que mas bien debería agregar las acciones de
//la fifo directamente

class driver extends uvm_driver #(item);
   `uvm_component_utils(driver)

   int id_drvr; // terminal
   bit[3:0] src;
   bit [3:0] id;

   virtual bus_mesh_if  vif;

   function new(string name = "driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if (!uvm_config_db #(virtual bus_mesh_if)::get(this,"","bus_mesh_if",vif)) 
            `uvm_fatal("Interfaz virtual", "No se pudo conectar vif")
    endfunction

  virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        vif.reset = 1;

        vif.data_out_i_in[id_drvr] = 0;
        vif.pndng_i_in[id_drvr] = 0; 

        @(posedge vif.clk);
        #1;
        vif.reset = 0;
        
        forever begin
          
          item trans;//items del sequencer i guess
          seq_item_port.get_next_item(trans);
          @(posedge vif.clk);
            vif.data_out_i_in[id_drvr] = 0;
            vif.pndng_i_in[id_drvr] = 0;
          @(posedge vif.clk);
          @(posedge vif.clk);
          vif.data_out_i_in[id_drvr] = {trans.pkg};
          vif.pndng_i_in[id_drvr] = 1;
          @(posedge vif.clk);
            wait (vif.popin[id_drvr]);
            vif.pndng_i_in[id_drvr] = 0;
            seq_item_port.item_done();
          //`uvm_info("DRV", $sformatf("Transaccion %s", item, print_transaccion()), UVM_HIGH);
          $display("El driver #%0d envia el mensaje: %b en modo [%d] ", id_drvr, vif.data_out_i_in[id_drvr], trans.modo );        end   
    endtask 

endclass


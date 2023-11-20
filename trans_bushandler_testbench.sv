// trans_bushandler_testbench.sv
`include "uvm_macros.svh"
import uvm_pkg::*;

class trans_bushandler_testbench extends uvm_test;
   `uvm_component_utils(trans_bushandler_testbench)

   trans_bushandler_sequencer sequencer;
   // Agrega aquí otros componentes como el driver, monitor, agent, etc., según sea necesario

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sequencer = trans_bushandler_sequencer::type_id::create("sequencer", this);
      // Agrega aquí configuraciones e inicializaciones adicionales
   endfunction



   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      sequencer.start(sequencer.default_sequence, sequencer);
      phase.drop_objection(this);
   endtask

 
endclass

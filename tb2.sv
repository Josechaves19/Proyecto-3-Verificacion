`include "uvm_macros.svh"
import uvm_pkg::*;
`include "sequence_item.sv"
`include "sequencer.sv"
`include "sequence.sv"
module tb;

   // Declaraciones de la secuencia y el seqencer
   trans_sequence secuencia;
   trans_bushandler_sequencer seqr;

   // Función para configurar y ejecutar la simulación
   initial begin
      // Cargar la librería de UVM
      `uvm_info("TB", "Iniciando simulación", UVM_NONE)

      // Crear una instancia de la secuencia y asignar el sequencer
      secuencia = trans_sequence::type_id::create("secuencia");
      secuencia.set_sequencer(seqr);

      // Configurar y ejecutar la simulación
      run_test();
   end

endmodule


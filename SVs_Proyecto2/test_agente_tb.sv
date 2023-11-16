`timescale 1ns/1ps
`include "transacciones_interface.sv"
`include "agente.sv"
`include "test.sv"

bus_mesh_if #(rows, columns, fifo_depth, pkg_size) _if (.clk(clk));
module tb;
    reg clk;
    test test_tb;
    comando_test_agente_mbx test_agente_mb;
    trans_bushandler_mbx agente_driver_mb[16];
  	agente #(50) agente_tb;
    trans_bushandler#(50) trans;
    instrucciones_agente instrucciones;
    initial begin
        agente_tb=new();
        test_tb=new();
      	test_agente_mb=new();
        test_tb.test_agente_mbx=test_agente_mb;
      	agente_tb.test_agente_mbx=test_agente_mb;
        for (int i=0; i<16; i=i+1) begin
          
          agente_driver_mb[i]=new();
          agente_tb.agente_driver_mbx[i]=agente_driver_mb[i];
   
    
  		  end
       	test_tb.run();
        $display("Imprimiendo items en el mailbox");
      $display("Numero de transacciones, %g", test_agente_mb.num());
      
 
      agente_tb.InitandRun();
          for (int i = 0; i < 16; i++) begin
      $display("Contenido del mailbox %0d:", i);
      
            while (agente_driver_mb[i].try_get(trans))
              $display("  Elemento: %b", trans.pkg);
   		 	end
         end
   
  endmodule

    
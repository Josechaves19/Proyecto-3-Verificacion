
`timescale 1ns/1ps
`include "transacciones_interface.sv"
`include "agente.sv"
`include "test.sv"
`include "driver.sv"


module tb;
    parameter rows=4;
    parameter columns=4;
    parameter fifo_depth = 8;
    parameter pkg_size=50;
    bit clk=0;
  	bus_mesh_if #(rows, columns, fifo_depth, pkg_size) _if(.clk(clk)) ;
    test test_tb;
    comando_test_agente_mbx test_agente_mb;
    trans_bushandler_mbx agente_driver_mb[16];
  	agente #(50) agente_tb;
  driver #(.pkg_size(50)) driver_tb[16];
  	trans_bushandler#(50) trans;
    instrucciones_agente instrucciones;
always begin
   #5 clk = ~clk;
end
 
    initial begin
      
        agente_tb=new();
        test_tb=new();
      	test_agente_mb=new();

      	test_tb.test_agente_mbx=test_agente_mb;
      	agente_tb.test_agente_mbx=test_agente_mb;
        for (int i=0; i<16; i=i+1) begin
          driver_tb[i]=new();
          driver_tb[i].id=i;
          driver_tb[i].vif=_if;
          agente_driver_mb[i]=new();
          agente_tb.agente_driver_mbx[i]=agente_driver_mb[i];
          driver_tb[i].agente_driver_mbx=agente_driver_mb[i];
   
    
  		  end
       	test_tb.run();
        $display("Imprimiendo items en el mailbox");
      $display("Numero de transacciones, %g", test_agente_mb.num());

 
      agente_tb.InitandRun();
           fork
             for (int i = 0; i < 16; i=i+1) begin
        // Run instance i in parallel
               driver_tb[i].run();
      		end
           join_none
    end
  endmodule

 
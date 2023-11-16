`timescale 1ns/1ps
`include "transacciones_interface.sv"
`include "agente.sv"
`include "test.sv"
`include "driver.sv"
`include "Router_library.sv"
`include "monitorAlex.sv"  
`include "scoreboard.sv"
`include "monitorswitches.sv"
`include "checker.sv"

module tb;
  parameter rows = 4;
  parameter columns = 4;
  parameter fifo_depth = 8;
  parameter pkg_size = 40;

  reg clk = 0;

  bus_mesh_if #(rows, columns, fifo_depth, pkg_size) _if (.clk(clk));
  trans_trayectoria_mbx trans_trayectoria_mb;
  trans_trayectoria#(40) trans_trayectoria;
  test test_tb;
  comando_test_agente_mbx test_agente_mb;
  trans_bushandler_mbx agente_driver_mb[16];
  agente #(40) agente_tb;
  monitor #(.pkg_size(40)) monitor_tb[16];
  driver #(.pkg_size(40)) driver_tb[16];
  scoreboard#(.pkg_size(pkg_size)) scoreboard_tb;
  trans_checker #(.pkg_size(40)) checker_tb;
  trans_bushandler#(40) trans;
  trans_bushandler_mbx monitor_checker_mb[16];
  trans_bushandler_mbx agente_scoreboard_mb;
  trans_bushandler_mbx checker_sb_mb;
  instrucciones_agente instrucciones;
  monitor_switches monitorswitches_tb;
  mapeo_ruta_mbx scoreboard_checker_mb;
  mesh_gnrtr#(.ROWS(rows), .COLUMS(columns), .pkg_size(40), .fifo_depth(fifo_depth)) uut(
    .clk(clk),
    .reset(_if.reset),
    .pndng(_if.pndng),
    .data_out(_if.data_out),
    .popin(_if.popin),
    .pop(_if.pop),
    .data_out_i_in(_if.data_out_i_in),
    .pndng_i_in(_if.pndng_i_in)
  );
    initial begin
      forever begin
        #5 clk = ~clk; // Reloj 
      end
    end
  initial #50000 begin
    checker_tb.receive_mapeos();
    checker_tb.Compare();

    scoreboard_tb.solicitudes();
      scoreboard_tb.reporte();

      $finish;
  end

  initial begin
    // Create instances and connections
   clk=0;
   _if.reset=0;
   #5
   _if.reset=1;
   #5
   _if.reset=0;
    for (int i =0; i<16;i=i+1) begin
    _if.pop[i]=0;
    _if.pndng_i_in[i]=0;
    _if.data_out_i_in[i]=0;
   end
    monitorswitches_tb=new();
    trans_trayectoria_mb=new;
    scoreboard_tb=new();
    checker_tb=new();
    checker_sb_mb=new(); 
    agente_tb = new();
    test_tb = new();
    test_agente_mb = new();
    agente_scoreboard_mb=new();
    scoreboard_checker_mb=new();
    monitorswitches_tb.switches_checker_mbx=trans_trayectoria_mb;
    checker_tb.switches_checker_mbx=trans_trayectoria_mb;
 scoreboard_tb.transaccion_checker_sb_mbx=checker_sb_mb;
    checker_tb.checker_scoreboard_mbx=checker_sb_mb;
    scoreboard_tb.agente_scoreboard_mbx=agente_scoreboard_mb;
    scoreboard_tb.scoreboard_checker_mbx=scoreboard_checker_mb;
    checker_tb.mapeo_ruta_mbx=scoreboard_checker_mb;
    test_tb.test_agente_mbx = test_agente_mb;
    agente_tb.test_agente_mbx = test_agente_mb;
    agente_tb.agente_scoreboard_mbx=agente_scoreboard_mb;
    for (int i = 0; i < 16; i = i + 1) begin
      monitor_tb[i]=new();
      monitor_checker_mb[i]=new();
      monitor_tb[i].id=i;
      monitor_tb[i].vif=_if;
      monitor_tb[i].monitor_checker_mbx=monitor_checker_mb[i];
      checker_tb.monitor_checker_mbx[i]=monitor_checker_mb[i];
      driver_tb[i] = new();
      driver_tb[i].id = i;
      driver_tb[i].vif = _if;
      agente_driver_mb[i] = new();
      agente_tb.agente_driver_mbx[i] = agente_driver_mb[i];
      driver_tb[i].agente_driver_mbx = agente_driver_mb[i];
    end

    // Clock generation


    // Run the testbench
    test_tb.run();
    $display("Imprimiendo items en el mailbox");
    $display("Numero de transacciones, %g", test_agente_mb.num());
  
    fork
      monitorswitches_tb.run();
    join_none
    fork
      agente_tb.InitandRun();
 
    join_none
    fork
      scoreboard_tb.run();
    join_none
    fork 
      checker_tb.lists();
    join_none
    fork
          driver_tb[0].run();
      
    join_none
    fork
      driver_tb[1].run();
      
    join_none
    fork
              driver_tb[2].run();
      
    join_none
    fork
      driver_tb[3].run();
      
    join_none        
    fork
      driver_tb[4].run();
      
    join_none
    fork
      driver_tb[5].run();
      
    join_none    
    fork
      driver_tb[6].run();
      
    join_none
    fork
      driver_tb[7].run();
      
    join_none    
    fork
      driver_tb[8].run();
      
    join_none
    fork
      driver_tb[9].run();
      
    join_none
    fork
      driver_tb[10].run();
      
    join_none
    fork
      driver_tb[11].run();
      
    join_none
    fork
      driver_tb[12].run();
      
    join_none
    fork
      driver_tb[13].run();
      
    join_none        fork
      driver_tb[14].run();
      
    join_none
    fork
      driver_tb[15].run();
      
    join_none
    fork
      monitor_tb[0].run();
    join_none 
     fork
       monitor_tb[1].run();
    join_none 
        fork
          monitor_tb[2].run();
    join_none 
     fork
       monitor_tb[3].run();
    join_none 
        fork
          monitor_tb[4].run();
    join_none 
     fork
       monitor_tb[5].run();
    join_none 
        fork
          monitor_tb[6].run();
    join_none 
     fork
       monitor_tb[7].run();
    join_none 
        fork
          monitor_tb[8].run();
    join_none 
     fork
       monitor_tb[9].run();
    join_none 
        fork
          monitor_tb[10].run();
    join_none 
     fork
       monitor_tb[11].run();
    join_none 
            fork
              monitor_tb[12].run();
    join_none 
     fork
       monitor_tb[13].run();
    join_none 
        fork
          monitor_tb[14].run();
    join_none 
     fork
       monitor_tb[15].run();
    join_none 
  
   
  end
endmodule


class ambiente #( parameter rows=4, columns=4,parameter pkg_size=40, parameter fifo_depth=8, parameter drvrs=16); // Parametros se definen en el test
	
  // Declaracion de los componentes (dispotivos, bloques) del ambiente
  reg clk;
  driver #(.pkg_size(pkg_size)) driver_tb[drvrs];
	scoreboard#(.pkg_size(pkg_size), .fifo_depth(fifo_depth)) scoreboard_tb;
  monitor #(.pkg_size(pkg_size)) monitor_tb[drvrs];
  agente #(pkg_size) agente_tb;
	monitor_switches monitorswitches_tb;
    test test_tb;
  trans_checker #(.pkg_size(pkg_size)) checker_tb;
	
    
    int num_transacciones;

	// Declaracion de la interface que conecta el DUT
     //    bus_mesh_if #(rows, columns, fifo_depth, pkg_size) _if (.clk(clk));
  	virtual bus_mesh_if #(.rows(rows), .columns(columns), .fifo_depth(fifo_depth), .pkg_size(pkg_size)) _if;
	// Declaracion de los mailboxes
        trans_bushandler_mbx monitor_checker_mb[16];
        trans_bushandler_mbx agente_scoreboard_mb;
        trans_bushandler_mbx checker_sb_mb;
        comando_test_agente_mbx test_agente_mb;
        trans_trayectoria_mbx trans_trayectoria_mb;
        trans_bushandler_mbx agente_driver_mb[16];
        mapeo_ruta_mbx scoreboard_checker_mb;
	 
	function new();
		// Instanciacion de los mailboxes
		trans_trayectoria_mb=new;
		test_agente_mb = new();
        agente_scoreboard_mb=new();
        scoreboard_checker_mb=new();
        checker_sb_mb=new(); 
        
        for (int i = 0; i < 16; i = i + 1) begin
		    monitor_checker_mb[i]=new();
            agente_driver_mb[i] = new();
        end

		// Instanciacion de los componenetes del ambiente
        scoreboard_tb=new();
        checker_tb=new();
        agente_tb = new();
        test_tb = new();
        monitorswitches_tb=new();
    
      for (int i=0; i < 16 ; i++) begin
            monitor_tb[i]=new();
            driver_tb[i] = new();
        end
    endfunction
    


	virtual task run();
          for (int i =0; i<16;i=i+1) begin
            _if.pop[i]=0;
            _if.pndng_i_in[i]=0;
            _if.data_out_i_in[i]=0;
            end

	    // Conexion de la interfaz 
        for (int i=0; i < 16 ; i++) begin
            monitor_tb[i].vif=_if;
            driver_tb[i].vif = _if;
            driver_tb[i].id = i;
            monitor_tb[i].id=i;
        end

        //Conexion de los mailboxes
        test_tb.test_agente_mbx=test_agente_mb;
        agente_tb.test_agente_mbx=test_agente_mb;
        agente_tb.agente_scoreboard_mbx=agente_scoreboard_mb;
        monitorswitches_tb.switches_checker_mbx=trans_trayectoria_mb;
        checker_tb.switches_checker_mbx=trans_trayectoria_mb; 
        checker_tb.checker_scoreboard_mbx=checker_sb_mb;
        checker_tb.mapeo_ruta_mbx=scoreboard_checker_mb;
        scoreboard_tb.scoreboard_checker_mbx=scoreboard_checker_mb;
        scoreboard_tb.agente_scoreboard_mbx=agente_scoreboard_mb;
        scoreboard_tb.transaccion_checker_sb_mbx=checker_sb_mb; 
        for (int i=0; i<16; i++) begin
            driver_tb[i].agente_driver_mbx = agente_driver_mb[i];
            monitor_tb[i].monitor_checker_mbx=monitor_checker_mb[i];
            checker_tb.monitor_checker_mbx[i]=monitor_checker_mb[i];
            agente_tb.agente_driver_mbx[i] = agente_driver_mb[i];

   		end

	
		$display("[%g] El ambiente fue inicializado",$time);
		
            test_tb.run();
            $display("Imprimiendo items en el mailbox");
            $display("Numero de transacciones, %g", test_agente_mb.num());
			agente_tb.InitandRun();
            fork
                monitorswitches_tb.run();
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
            
             
            
		
	endtask
    virtual task reportes;
        checker_tb.receive_mapeos();
        checker_tb.Compare(); 
        scoreboard_tb.solicitudes(); 
        scoreboard_tb.reporte();
    endtask
endclass

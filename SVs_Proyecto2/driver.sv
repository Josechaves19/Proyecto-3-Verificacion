
`include "Fifo_ema.sv"
class driver #(parameter rows = 4, parameter columns = 4,parameter pkg_size   = 40,
               parameter fifo_depth = 8);

    int id;//terminal
    int espera;
	trans_bushandler_mbx agente_driver_mbx;
    //trans_mbx #(.pckg_sz(pckg_sz)) mbx_agt_drv;
	
	trans_bushandler #(.pkg_size(pkg_size)) transaccion_driver;
	//pkg_trans #(.pkg_size(pkg_size)) transaction;
	
	virtual bus_mesh_if #(.rows(rows), .columns(columns), .pkg_size(pkg_size),.fifo_depth(fifo_depth)) vif;
    //virtual if_dut #(.pckg_sz(pckg_sz)) vif;
	int FIFO_IN[$:fifo_depth];
   
    task run();
	    $display("[%g] El driver (%2d) se inicia", $time, this.id);
        @(posedge vif.clk);
        forever begin
            transaccion_driver = new();

		$display("[%g] El driver (%2d) espera por un item del agente", $time, this.id);
            	agente_driver_mbx.get(transaccion_driver);
		$display("[%g] El driver (%2d) recibe instruccion del agente", $time, this.id);
            /* `ifdef DEBUG */
		transaccion_driver.print_transaccion(); // es solo .print o si es .print_transaccion*******
            /* `endif */

		vif.pndng_i_in[this.id] = 0;
            espera = 0;
		$display("[%g] El driver (%2d) espera retardo de %2d clk", $time, this.id, transaccion_driver.retardo);
            while(espera < transaccion_driver.retardo) begin
                @(posedge vif.clk);
                espera = espera + 1;
            end
		$display("[%g] El driver (%2d) ha terminado la espera de %2d clk", $time, this.id, transaccion_driver.retardo);

          FIFO_IN.push_back(transaccion_driver.pkg);
		vif.pndng_i_in[this.id]    = 1;
          vif.data_out_i_in[this.id] = FIFO_IN.pop_front();
    
		    @(negedge vif.popin[this.id]);
          if(FIFO_IN.size() == 0) begin
			vif.pndng_i_in[this.id] = 0;
                end
            end
  
    endtask

endclass


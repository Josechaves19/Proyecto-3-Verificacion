class monitor #(parameter rows = 4, parameter columns = 4,parameter pkg_size   = 50,
	parameter fifo_depth = 8);
int id;

trans_bushandler_mbx monitor_checker_mbx;

trans_bushandler #(.pkg_size(pkg_size)) transaccion_driver;

virtual bus_mesh_if #(.rows(rows), .columns(columns), .pkg_size(pkg_size),.fifo_depth(fifo_depth)) vif;

virtual task run();
$display("[%g] Iniciando el monitor (%2d) ", $time, this.id);
@(posedge vif.clk);

forever begin
  
 transaccion_driver = new();
 $display("[%g] El monitor (%2d) está esperando por dato del DUT", $time, this.id);

@(posedge vif.pndng[this.id]);
vif.pop[this.id] = 1;
 @(posedge vif.clk);
vif.pop[this.id] = 0;

 //transaccion_driver.t_recibo = $time;
$display("[%g] El monitor (%2d) recibió un dato del DUT, lo siguiente es enviar el dato al checker", $time, this.id);
transaccion_driver.pkg = vif.data_out[this.id];
$display("Paquete recibido %b",transaccion_driver.pkg);
	 transaccion_driver.print_transaccion();
	 transaccion_driver.tiempo_recibido=$time;

monitor_checker_mbx.put(transaccion_driver);
end
endtask
endclass

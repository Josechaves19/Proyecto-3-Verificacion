class monitor_switches #(pkg_size=40);
  trans_trayectoria #(.pkg_size(pkg_size)) transaccion_checker;
  trans_trayectoria_mbx switches_checker_mbx;
	
  
	
  task run();
fork 
 while($time<100000) begin 
 transaccion_checker=new(); 
  @(posedge tb.uut._rw_[1]._clm_[1].rtr._nu_[0].rtr_ntrfs_.pop) begin 
 transaccion_checker.columna=1;
 transaccion_checker.fila=1; 
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[1].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0]; 
 transaccion_checker.print_transaccion(); 
 switches_checker_mbx.put(transaccion_checker); 
 end 
end 
 join_none
fork 
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[1].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[1].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[1].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[1].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[1].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[1].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[2].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[2].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[2].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[2].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[2].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[2].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[2].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[2].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[3].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[3].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[3].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[3].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[3].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[3].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[3].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[3].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[4].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[4].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[4].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[4].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[4].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[4].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[1]._clm_[4].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=1;
 transaccion_checker.dato=tb.uut._rw_[1]._clm_[4].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[1].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[1].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[1].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[1].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[1].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[1].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[1].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[1].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[2].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[2].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[2].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[2].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[2].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[2].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[2].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[2].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[3].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[3].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[3].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[3].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[3].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[3].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[3].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[3].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[4].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[4].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[4].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[4].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[4].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[4].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[2]._clm_[4].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=2;
 transaccion_checker.dato=tb.uut._rw_[2]._clm_[4].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[1].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[1].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[1].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[1].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[1].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[1].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork 
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[1].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[1].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[2].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[2].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[2].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[2].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[2].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[2].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[2].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[2].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[3].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[3].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[3].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[3].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[3].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[3].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[3].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[3].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[4].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[4].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[4].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[4].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[4].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[4].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[3]._clm_[4].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=3;
 transaccion_checker.dato=tb.uut._rw_[3]._clm_[4].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[1].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[1].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[1].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[1].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[1].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[1].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[1].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=1;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[1].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[2].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[2].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[2].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[2].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork 
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[2].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[2].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[2].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=2;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[2].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[3].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[3].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[3].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[3].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[3].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[3].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[3].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=3;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[3].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[4].rtr._nu_[0].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[4].rtr._nu_[0].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[4].rtr._nu_[1].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[4].rtr._nu_[1].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[4].rtr._nu_[2].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[4].rtr._nu_[2].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
fork
 while($time<100000) begin
 transaccion_checker=new();
  @(posedge tb.uut._rw_[4]._clm_[4].rtr._nu_[3].rtr_ntrfs_.pop) begin
 transaccion_checker.columna=4;
 transaccion_checker.fila=4;
 transaccion_checker.dato=tb.uut._rw_[4]._clm_[4].rtr._nu_[3].rtr_ntrfs_.data_out[pkg_size-26:0];
 transaccion_checker.print_transaccion();
 switches_checker_mbx.put(transaccion_checker);
 end
end
 join_none
  endtask
endclass
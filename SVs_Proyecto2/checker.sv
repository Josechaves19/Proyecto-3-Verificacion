class trans_checker #(parameter pkg_size   = 40, parameter drivers=16);
  trans_bushandler #(.pkg_size(pkg_size)) trans_monitor;
  trans_bushandler #(.pkg_size(pkg_size)) trans_scoreboard;
  trans_bushandler #(.pkg_size(pkg_size)) trans_sb;
  trans_trayectoria #(.pkg_size(pkg_size)) trans_switches;
  mapeo_ruta#(.pkg_size(pkg_size)) trans_mapeo;
  mapeo_ruta_mbx mapeo_ruta_mbx; 
  trans_bushandler_mbx checker_scoreboard_mbx;
  trans_trayectoria_mbx switches_checker_mbx;
  trans_bushandler_mbx monitor_checker_mbx[drivers];
  trans_bushandler #(.pkg_size(pkg_size)) monitor_lista[$]={};
  trans_bushandler #(.pkg_size(pkg_size)) lista_envio[$]={};
  mapeo_ruta mapeos_lista[$]={};
mapeo_ruta golden_mapeos[$]={};
string linea_csv, d_enviado,s_tx,s_rx,s_tp;
int terminal_fila;
int terminal_columna;
int meter; 
bit [pkg_size-9:0] lista_eliminados[$]={};
bit [pkg_size-9:0] lista_unicos[$]={};  
bit [pkg_size-1:0] envio;
task lists();
  $system("echo Paquete > checker.csv");//Envio el header del csv
  forever begin: Tiempo_checker
  #1
    for (int i=0; i<16; i=i+1) begin
    while(monitor_checker_mbx[i].num()!=0) begin
          trans_monitor=new();
          monitor_checker_mbx[i].get(trans_monitor);
          trans_monitor.tiempo_recibido=$time;

        entrante_row_columna(trans_monitor.pkg[this.pkg_size-22:this.pkg_size-25]);
        trans_mapeo=new();
        trans_mapeo.terminal_fila=this.terminal_fila;
        trans_mapeo.terminal_columna=this.terminal_columna;
        trans_mapeo.dato=trans_monitor.pkg[pkg_size-9:0];   
        mapeos_lista.push_back(trans_mapeo);
      trans_mapeo=new();
        entrante_row_columna(trans_monitor.pkg[this.pkg_size-18:this.pkg_size-21]);
        trans_mapeo.terminal_fila=this.terminal_fila;
        trans_mapeo.terminal_columna=this.terminal_columna;
      trans_mapeo.dato=trans_monitor.pkg[pkg_size-9:0];   
        mapeos_lista.push_back(trans_mapeo);        	
        monitor_lista.push_back(trans_monitor);
        
        
        
          
      end
  end
      while(switches_checker_mbx.num()!=0) begin 
          trans_switches=new();
          trans_mapeo=new();
          switches_checker_mbx.get(trans_switches);
          trans_mapeo.terminal_fila=trans_switches.fila;
          trans_mapeo.terminal_columna=trans_switches.columna;
          trans_mapeo.dato=trans_switches.dato; 
          mapeos_lista.push_back(trans_mapeo);
      
      end
      if ($time > 100000) begin
          disable Tiempo_checker; 
      end
  end
endtask

task print_listas();
  $display("******************Mapeos**********************");
  while (mapeos_lista.size()>0) begin
    trans_mapeo=new();
    trans_mapeo=mapeos_lista.pop_front();
    trans_mapeo.print_transaccion();
  end
  $display("******************Transacciones**********************");
  while (monitor_lista.size()>0) begin
    trans_monitor=new();
    trans_monitor=monitor_lista.pop_front();
    trans_monitor.print_transaccion();
  end
  $display("****GOLDEN_MAPEOS*************");
  while (golden_mapeos.size()>0) begin
    trans_mapeo=new();
    trans_mapeo=golden_mapeos.pop_front();
    trans_mapeo.print_transaccion();
  end
endtask


function void entrante_row_columna(int id);

  case (id) 
   
  4'b0000: begin
      this.terminal_columna = 1;
      this.terminal_fila = 0;
  end
  4'b0001: begin
      this.terminal_columna = 2;
      this.terminal_fila = 0;
  end
  4'b0010: begin
      this.terminal_columna = 3;
      this.terminal_fila = 0;
  end
  4'b0011: begin
      this.terminal_columna = 4;
      this.terminal_fila = 0;
  end
  4'b0100: begin
      this.terminal_columna = 0;
      this.terminal_fila = 1;
  end
  4'b0101: begin
      this.terminal_columna = 0;
      this.terminal_fila = 2;
  end
  4'b0110: begin
     this.terminal_columna = 0;
      this.terminal_fila = 3;
  end
  4'b0111: begin
      this.terminal_columna = 0;
      this.terminal_fila = 4;
  end
  4'b1000: begin
      this.terminal_columna = 1;
      this.terminal_fila = 5;
  end
  4'b1001: begin
      this.terminal_columna = 2;
      this.terminal_fila = 5;
  end
  4'b1010: begin
      this.terminal_columna = 3;
      this.terminal_fila = 5;
  end
  4'b1011: begin
      this.terminal_columna = 4;
      this.terminal_fila = 5;
  end
  4'b1100: begin
      this.terminal_columna = 5;
      this.terminal_fila = 1;
  end
  4'b1101: begin
      this.terminal_columna = 5;
      this.terminal_fila = 2;
  end
  4'b1110: begin
      this.terminal_columna = 5;
      this.terminal_fila = 3;
  end
  4'b1111: begin
      this.terminal_columna = 5;
      this.terminal_fila = 4;
  end
  
  endcase
endfunction

task receive_mapeos();
  while(mapeo_ruta_mbx.num()!=0) begin
    trans_mapeo=new();
    mapeo_ruta_mbx.get(trans_mapeo);
    golden_mapeos.push_back(trans_mapeo);
  end
endtask
task Compare();
  assert (mapeos_lista.size() == golden_mapeos.size()) $display(""); 
else $error("La cantidad de mapeos realizados no coincide con los mapeos de la referencia");

for (int i = 0; i < mapeos_lista.size(); i++) begin
  for (int j = 0; j < golden_mapeos.size(); j++) begin
      if (mapeos_lista[i].terminal_columna == golden_mapeos[j].terminal_columna &&
          mapeos_lista[i].terminal_fila == golden_mapeos[j].terminal_fila &&
          mapeos_lista[i].dato == golden_mapeos[j].dato) begin
        mapeos_lista[i].print_transaccion(); 
        golden_mapeos[j].print_transaccion(); 
          lista_eliminados.push_back(mapeos_lista[i].dato);
          break;
      end
  end
end
meter=1;
$display("Transacciones"); 
foreach(lista_eliminados[i]) begin
  $display("%b", lista_eliminados[i]);
end

for (int i =0 ; i<lista_eliminados.size(); i++) begin
  meter=1; 
  $display("Dato a evaluar: %b Cantidad de datos unicos en este momento: %g", lista_eliminados[i],  lista_unicos.size());
  if (lista_unicos.size==0) begin
    lista_unicos.push_back(lista_eliminados[i]);
    meter=0; 
  end
  else begin
    for (int j=0; j<lista_unicos.size(); j++) begin
      if (lista_unicos[j]==lista_eliminados[i]) begin
        meter=0;
      end
    
    end
  end
  if (meter==1) begin
    lista_unicos.push_back(lista_eliminados[i]); 
    
  end

end

  for ( int i=0; i<monitor_lista.size(); i++) begin
  trans_monitor=new();
    trans_monitor=monitor_lista[i]; 
   $display("Paquete Monitor %b ",trans_monitor.pkg);
   $display("Tiempo Monitor %g", trans_monitor.tiempo_recibido);
   
end
 $display("Datos Unicos");
 
for (int i = 0; i < lista_unicos.size(); i++) begin
  for (int j=0; j < monitor_lista.size(); j++) begin
    if (lista_unicos[i]==monitor_lista[j].pkg[pkg_size-9:0]) begin
      trans_sb=new(); 
      trans_sb.pkg={8'b0, lista_unicos[i]};
      trans_sb.tiempo_recibido=monitor_lista[j].tiempo_recibido; 
      d_enviado.hextoa(this.trans_sb.pkg); 
      $system($sformatf("echo %0s >> checker.csv", d_enviado)); 
      checker_scoreboard_mbx.put(trans_sb);
    end
      
end
end

endtask    

    
endclass

class scoreboard #(parameter pkg_size=40, parameter drvrs=16, parameter fifo_depth=32);
    int terminal_columna;
    int terminal_fila;
    int target_fila;
    int target_columna;
    int movimientos;
    int direccion_filas=1;
    int direccion_columnas=1;
    int terminal_fila_inicial;
    int terminal_columna_inicial;
    bit [pkg_size-26:0] dato;
    int modo;//esto es de la tra
    int cant_saltos;
    int archivo;
    int meter;
    int k_encontrado;
//    transaccion_reducida lista_pkg_agente[$]={};
  //  transaccion_reducida lista_pkg_checker[$]={};
	trans_bushandler_mbx agente_scoreboard_mbx;// aqui viene el pkg con src,target_ fila, target_columna, mode
	trans_bushandler #(.pkg_size(pkg_size)) transaccion_entrante;
	mapeo_ruta#(.pkg_size(pkg_size)) trans_mapeo;
    mapeo_ruta_mbx scoreboard_checker_mbx;
//datos que vienen del checker para completar la transaccion
    trans_bushandler#(.pkg_size(pkg_size)) transaccion_checker_sb;
    trans_bushandler_mbx transaccion_checker_sb_mbx;
//definiendo transaccion_reducida
    transaccion_reducida#(.pkg_size(pkg_size)) transaccion_reducida_agente;
    transaccion_reducida#(.pkg_size(pkg_size)) transaccion_reducida_checker;
    transaccion_reducida#(.pkg_size(pkg_size)) transaccion_completa;

    transaccion_reducida#(.pkg_size(pkg_size)) lista_pkg_agente[$]={};
    transaccion_reducida#(.pkg_size(pkg_size)) lista_pkg_checker[$]={};
    transaccion_reducida#(.pkg_size(pkg_size)) lista_completa[$]={};
task run ();
    
begin:  tiempo_scoreboard
        forever begin
            #1
        if ($time>101) begin //ver que numero poner en vez de 100
            disable tiempo_scoreboard;
        end    
    while(agente_scoreboard_mbx.num()>0) begin
    cant_saltos=0;
    agente_scoreboard_mbx.get(transaccion_entrante);
    modo=transaccion_entrante.modo;
    target_fila= transaccion_entrante.target_fila;
    direccion_columnas=1;
    direccion_filas=1;
    target_columna= transaccion_entrante.target_columna;
    transaccion_reducida_agente=new();
    transaccion_reducida_agente.pkg = transaccion_entrante.pkg;
    transaccion_reducida_agente.tiempo_envio=transaccion_entrante.tiempo_envio;
case (transaccion_entrante.dispositivo_tx) 
    4'b0000: begin
        terminal_columna = 1;
        terminal_fila = 0;
    end
    4'b0001: begin
        terminal_columna = 2;
        terminal_fila = 0;
    end
    4'b0010: begin
        terminal_columna = 3;
        terminal_fila = 0;
    end
    4'b0011: begin
        terminal_columna = 4;
        terminal_fila = 0;
    end
    4'b0100: begin
        terminal_columna = 0;
        terminal_fila = 1;
    end
    4'b0101: begin
        terminal_columna = 0;
        terminal_fila = 2;
    end
    4'b0110: begin
        terminal_columna = 0;
        terminal_fila = 3;
    end
    4'b0111: begin
        terminal_columna = 0;
        terminal_fila = 4;
    end
    4'b1000: begin
        terminal_columna = 1;
        terminal_fila = 5;
    end
    4'b1001: begin
        terminal_columna = 2;
        terminal_fila = 5;
    end
    4'b1010: begin
        terminal_columna = 3;
        terminal_fila = 5;
    end
    4'b1011: begin
        terminal_columna = 4;
        terminal_fila = 5;
    end
    4'b1100: begin
        terminal_columna = 5;
        terminal_fila = 1;
    end
    4'b1101: begin
        terminal_columna = 5;
        terminal_fila = 2;
    end
    4'b1110: begin
        terminal_columna = 5;
        terminal_fila = 3;
    end
    4'b1111: begin
        terminal_columna = 5;
        terminal_fila = 4;
    end
    endcase
    trans_mapeo =new();
    trans_mapeo.terminal_columna=terminal_columna;
    trans_mapeo.terminal_fila=terminal_fila;
    trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
    trans_mapeo.print_transaccion();
    cant_saltos=0;
    terminal_fila_inicial = terminal_fila;
    terminal_columna_inicial = terminal_columna;

    this.scoreboard_checker_mbx.put(this.trans_mapeo);
    $display("Comenzamos en el punto columna %g fila %g", terminal_columna, terminal_fila);
    $display("target fila: %g, target columna: %g",target_fila, target_columna);
    if (terminal_fila>target_fila) begin
        direccion_filas=-1;
    end

    if (target_columna<terminal_columna) begin//se cambio el orden
        direccion_columnas=-1;// esto se cambio a -1

    end
    if (target_fila==terminal_fila || target_columna==terminal_columna) begin
        if (target_fila==terminal_fila) begin
          if (terminal_fila==5) begin
            $display("Filas Iguales, moviendo hacia arriba");
            terminal_fila=terminal_fila-1;
            $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            $display("La cantidad de saltos es:%g", cant_saltos);
            trans_mapeo.print_transaccion();      
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
            $display("Desplazandonos en columna. en direccion %g", direccion_columnas);
            while (terminal_columna!=target_columna) begin
                terminal_columna=terminal_columna+direccion_columnas;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                $display("La cantidad de saltos es:%g", cant_saltos);
                trans_mapeo.print_transaccion();
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
              end
               if(terminal_fila!=target_fila)begin
                       terminal_fila=terminal_fila+1;
                   end

            $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            $display("La cantidad de saltos es:%g", cant_saltos); 
            trans_mapeo.print_transaccion();      
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
          end
          else begin
                $display("Filas iguales, moviendo hacia abajo");
                terminal_fila=terminal_fila+1;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                $display("La cantidad de saltos es:%g", cant_saltos); 
                trans_mapeo.print_transaccion();      
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
              while (terminal_columna!=target_columna) begin
                terminal_columna=terminal_columna+direccion_columnas;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                $display("La cantidad de saltos es:%g", cant_saltos);
                trans_mapeo.print_transaccion();
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
              end
              if(target_fila!=terminal_fila)begin
            
                    terminal_fila=terminal_fila-1;
                end
            $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            $display("La cantidad de saltos es:%g", cant_saltos);
            trans_mapeo.print_transaccion();      
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
          end
        end
        else begin
            if (terminal_columna==5) begin
              $display("Columnas iguales, moviendo hacia la izquierda");
              terminal_columna=terminal_columna-1;
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              $display("La cantidad de saltos es:%g", cant_saltos);
              trans_mapeo.print_transaccion();
              this.scoreboard_checker_mbx.put(this.trans_mapeo);
              $display("Desplazandonos en filas en direccion %g", direccion_filas);
                while (terminal_fila!=target_fila) begin
                    terminal_fila=terminal_fila+direccion_filas;
                  $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                  trans_mapeo =new();
                  trans_mapeo.terminal_columna=terminal_columna;
                  trans_mapeo.terminal_fila=terminal_fila;
                  trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                  cant_saltos+=1;
                  $display("La cantidad de saltos es:%g", cant_saltos);
                  trans_mapeo.print_transaccion();        
                  this.scoreboard_checker_mbx.put(this.trans_mapeo);
              end
               if(terminal_columna!=target_columna)begin
                      terminal_columna=terminal_columna+1;
                   end
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              $display("La cantidad de saltos es:%g", cant_saltos);
              trans_mapeo.print_transaccion();      
              this.scoreboard_checker_mbx.put(this.trans_mapeo);
            end
            else begin
                $display("Columnas iguales, moviendo hacia la derecha");
                      terminal_columna=terminal_columna+1;
                      $display("Desplazandonos en columna. en direccion %g", direccion_columnas);
                while (terminal_fila!=target_fila) begin
                      terminal_fila=terminal_fila+direccion_filas;
                      $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                      trans_mapeo =new();
                      trans_mapeo.terminal_columna=terminal_columna;
                      trans_mapeo.terminal_fila=terminal_fila;
                      trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                      cant_saltos+=1;
                      $display("La cantidad de saltos es:%g", cant_saltos);
                      trans_mapeo.print_transaccion();      
                      this.scoreboard_checker_mbx.put(this.trans_mapeo);
               end
               if(terminal_columna!=target_columna)begin
                      terminal_columna=terminal_columna-1;
                  end

              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              $display("La cantidad de saltos es:%g", cant_saltos);
              trans_mapeo.print_transaccion();       
              this.scoreboard_checker_mbx.put(this.trans_mapeo);
          end

        end


      end
    else begin
        if (modo==1) begin 
          if (terminal_columna==0 || terminal_columna ==5) begin
                  terminal_columna=terminal_columna+direccion_columnas;
                  movimientos=movimientos+1;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                $display("La cantidad de saltos es:%g", cant_saltos);
                trans_mapeo.print_transaccion();       
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
            end
          $display("Desplazandonos en Fila");
          while (terminal_fila != target_fila && movimientos<(target_fila - terminal_columna_inicial))  begin        
          terminal_fila=terminal_fila+direccion_filas;
                  movimientos=movimientos+1;
            $display("Ahora nos encontramos en el punto  columna %g  fila %g", terminal_columna, terminal_fila);
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            $display("La cantidad de saltos es:%g", cant_saltos);
            trans_mapeo.print_transaccion();            
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
        end
          $display("Desplazandonos en columna. en direccion %g", direccion_columnas);
              while (terminal_columna!=target_columna) begin
                  terminal_columna=terminal_columna+direccion_columnas;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                $display("La cantidad de saltos es:%g", cant_saltos); 
                trans_mapeo.print_transaccion();       
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
            end
          while (target_fila!=terminal_fila) begin
              $display("5555555555555555555555555555555555555555555555555555555555555555555555");
                  terminal_fila=terminal_fila+direccion_filas;
            $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            $display("La cantidad de saltos es:%g", cant_saltos);
            trans_mapeo.print_transaccion();        
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
        end
         transaccion_reducida_agente.cant_saltos=cant_saltos;
         transaccion_reducida_agente.print_transaccion();

          end
          else begin
            $display("Desplazandonos en columna");
            if (terminal_fila==0 || terminal_fila ==5) begin
                $display("me movi a como el if",direccion_filas);
                terminal_fila=terminal_fila+direccion_filas;
                movimientos=movimientos+1;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                $display("La cantidad de saltos es:%g", cant_saltos); 
                trans_mapeo.print_transaccion();        
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
            end
            while (terminal_columna != target_columna && movimientos<target_columna-terminal_columna_inicial) begin      
            terminal_columna=terminal_columna+direccion_columnas;
                  movimientos=movimientos+1;
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              $display("La cantidad de saltos es:%g", cant_saltos);
              trans_mapeo.print_transaccion();         
              this.scoreboard_checker_mbx.put(this.trans_mapeo);
          end
              $display("Desplazandonos en fila");
              while (terminal_fila!=target_fila) begin

                  terminal_fila=terminal_fila+direccion_filas;
                  $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                  trans_mapeo =new();
                  trans_mapeo.terminal_columna=terminal_columna;
                  trans_mapeo.terminal_fila=terminal_fila;
                  trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                  cant_saltos+=1;
                  $display("La cantidad de saltos es:%g", cant_saltos);
                  trans_mapeo.print_transaccion();
                  this.scoreboard_checker_mbx.put(this.trans_mapeo);
              end
            while (target_columna!=terminal_columna) begin
                $display("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
                  terminal_columna=terminal_columna+direccion_columnas;
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              $display("La cantidad de saltos es:%g", cant_saltos);
              trans_mapeo.print_transaccion();      
              this.scoreboard_checker_mbx.put(this.trans_mapeo);
          end
      end
      end
                transaccion_reducida_agente.cant_saltos=cant_saltos;
                lista_pkg_agente.push_back(transaccion_reducida_agente);
                transaccion_reducida_agente.print_transaccion();

    end
  
end
end
endtask
task solicitudes();
    
    while(transaccion_checker_sb_mbx.num()!=0) begin 
        transaccion_checker_sb=new(); 
        transaccion_checker_sb_mbx.get(transaccion_checker_sb);
        transaccion_reducida_checker=new(); 
        transaccion_reducida_checker.pkg = this.transaccion_checker_sb.pkg;          
        transaccion_reducida_checker.tiempo_recibido=this.transaccion_checker_sb.tiempo_recibido;
        lista_pkg_checker.push_back(transaccion_reducida_checker); 
    end

    for (int i=0; i<lista_pkg_checker.size(); i++) begin 
        for  (int j=0; j<lista_pkg_agente.size(); j++) begin 
                   if (lista_pkg_agente[j].pkg==lista_pkg_checker[i].pkg) begin
                     $display("Coincidencia %g %g", i, j);
                     transaccion_completa=new(); 
                transaccion_completa.pkg = this.lista_pkg_checker[i].pkg;
                transaccion_completa.tiempo_envio = this.lista_pkg_agente[j].tiempo_envio;
                transaccion_completa.cant_saltos = this.lista_pkg_agente[j].cant_saltos;
                transaccion_completa.tiempo_recibido = this.lista_pkg_checker[i].tiempo_recibido;
                transaccion_completa.calc_retraso();
                transaccion_completa.calc_bandwidth();
            end
                
        end
    $display(transaccion_completa.pkg);
      lista_completa.push_back(transaccion_completa);
    end
foreach(this.lista_completa[i])begin
            $display(lista_completa[i].pkg);
end

endtask

task reporte();
    /*foreach(this.lista_completa[i])begin
            $display(lista_completa[i].pkg);
    end*/
        archivo = $fopen ("./Reporte_proyecto2.csv","a");

        $display("Reporte Cola Scoreboard");
        foreach(this.lista_completa[i])begin
           $fdisplay(archivo,"Posición %d de la cola, paquete = %b , retraso = %g, bandwidth: %g, fifo_depth: %g, saltos: %g",i,this.lista_completa[i].pkg,this.lista_completa[i].retraso, this.lista_completa[i].bandwidth, this.fifo_depth, this.lista_completa[i].cant_saltos);
        end
         $fclose(archivo);
endtask
endclass


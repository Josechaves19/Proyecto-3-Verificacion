class scoreboard extends `uvm_scoreboard;
  ``uvm_component_utils(scoreboard)
  parameter int pkg_size = 40;
/////////////////////// Se puede?  //////////////////////////////////////
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
    int k_encontrado
 ////////// Debo revisar si es legal meter esto asi no mas /////////////
 
 //////////////// Averiguar como recibir los siguientes mailboxs///////////
 	trans_bushandler_mbx agente_scoreboard_mbx;// aqui viene el pkg con src,target_ fila, target_columna, mode
	trans_bushandler #(.pkg_size(pkg_size)) transaccion_entrante_item;
    /// VER QUE DEMONIOS SON MAPEO RUTA, son terminal fila, columna y un dato
    //de pkg-9 a 0, no lo necsito para e task run///
	mapeo_ruta#(.pkg_size(pkg_size)) trans_mapeo;
    mapeo_ruta_mbx scoreboard_checker_mbx;
//datos que vienen del checker para completar la transaccion
    trans_bushandler#(.pkg_size(pkg_size)) transaccion_checker_sb_item;
    trans_bushandler_mbx transaccion_checker_sb_mbx;
//definiendo transaccion_reducida
    trans_bushandler#(.pkg_size(pkg_size)) transaccion_reducida_agente;
    trans_bushandler#(.pkg_size(pkg_size)) transaccion_reducida_checker;
    trans_bushandler#(.pkg_size(pkg_size)) transaccion_completa;
/////////////////////////////////////////////////////////////////////////////////////////


  uvm_analysis_imp #(trans_bushandler,scoreboard) trans_driver_export;
 

  function new(string name = "scoreboard", `uvm_component parent = null);
    super.new(name,parent);
  // BUILD PHASE
    trans_driver_export = new("trans_driver_export",this);
  endfunction
  
  // Empieza la fase de corrida/
   task run_phase(`uvm_phase phase);

    transaccion_entrante_item = trans_bushandler::type_id::create("transaccion_entrante_item");
    transaccion_reducida_agente = trans_bushandler::type_id::create("transaccion_reducida_agente");
    transaccion_reducida_checker = trans_bushandler::type_id::create("transaccion_reducida_checker");
    transaccion_completa = trans_bushandler::type_id::create("transaccion_completa");
    phase.raise_objection(this);
    ``uvm_warning("Se inicializó el scoreboard", get_type_name())
     phase.drop_objection(this);
    begin:  tiempo_scoreboard
        forever begin
            #1
        if ($time>10000) begin //ver que numero poner en vez de 100
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
    //prints de `uvm
    `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("target fila %g target columna %g", target_fila, target_columna), UVM_LOW)

    if (terminal_fila>target_fila) begin
        direccion_filas=-1;
    end

    if (target_columna<terminal_columna) begin//se cambio el orden
        direccion_columnas=-1;// esto se cambio a -1

    end
    if (target_fila==terminal_fila || target_columna==terminal_columna) begin
        if (target_fila==terminal_fila) begin
          if (terminal_fila==5) begin
            `uvm_info(get_type_name(), "Filas Iguales, moviendo hacia arriba", UVM_MEDIUM)
            terminal_fila=terminal_fila-1;
            //print `uvm
            `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)

            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
            trans_mapeo.print_transaccion();      
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
            `uvm_info(get_type_name(), $sformatf("Desplazandonos en columna. en direccion %0d", direccion_columnas), UVM_MEDIUM)
            while (terminal_columna!=target_columna) begin
                terminal_columna=terminal_columna+direccion_columnas;
                //print `uvm
                `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)

                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
                trans_mapeo.print_transaccion();
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
              end
               if(terminal_fila!=target_fila)begin
                       terminal_fila=terminal_fila+1;
                   end
            //print `uvm
            `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM) 
            trans_mapeo.print_transaccion();      
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
          end
          else begin
                `uvm_info(get_type_name(), "Filas iguales, moviendo hacia abajo", UVM_MEDIUM)
                terminal_fila=terminal_fila+1;
                //`uvm PRINT
                `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM) 
                trans_mapeo.print_transaccion();      
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
              while (terminal_columna!=target_columna) begin
                terminal_columna=terminal_columna+direccion_columnas;
                `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
                trans_mapeo.print_transaccion();
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
              end
              if(target_fila!=terminal_fila)begin
            
                    terminal_fila=terminal_fila-1;
                end
            `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
            trans_mapeo.print_transaccion();      
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
          end
        end
        else begin
            if (terminal_columna==5) begin
              `uvm_info(get_type_name(), "Columnas iguales, moviendo hacia la izquierda", UVM_MEDIUM)
              terminal_columna=terminal_columna-1;
              `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
              trans_mapeo.print_transaccion();
              this.scoreboard_checker_mbx.put(this.trans_mapeo);
              `uvm_info(get_type_name(), $sformatf("Desplazandonos en filas en direccion %0d", direccion_filas), UVM_MEDIUM)
                while (terminal_fila!=target_fila) begin
                    terminal_fila=terminal_fila+direccion_filas;
                  `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
                  trans_mapeo =new();
                  trans_mapeo.terminal_columna=terminal_columna;
                  trans_mapeo.terminal_fila=terminal_fila;
                  trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                  cant_saltos+=1;
                  `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
                  trans_mapeo.print_transaccion();        
                  this.scoreboard_checker_mbx.put(this.trans_mapeo);
              end
               if(terminal_columna!=target_columna)begin
                      terminal_columna=terminal_columna+1;
                   end
              `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
              trans_mapeo.print_transaccion();      
              this.scoreboard_checker_mbx.put(this.trans_mapeo);
            end
            else begin
                      `uvm_info(get_type_name(), $sformatf("Columnas iguales moviendo hacia la derecha"), UVM_MEDIUM)
                      terminal_columna=terminal_columna+1;
                      `uvm_info(get_type_name(), $sformatf("Desplazandonos en columna. en direccion %0d", direccion_columnas), UVM_MEDIUM)
                while (terminal_fila!=target_fila) begin
                      terminal_fila=terminal_fila+direccion_filas;
                      `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
                      trans_mapeo =new();
                      trans_mapeo.terminal_columna=terminal_columna;
                      trans_mapeo.terminal_fila=terminal_fila;
                      trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                      cant_saltos+=1;
                      `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
                      trans_mapeo.print_transaccion();      
                      this.scoreboard_checker_mbx.put(this.trans_mapeo);
               end
               if(terminal_columna!=target_columna)begin
                      terminal_columna=terminal_columna-1;
                  end

              `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
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
                `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
                trans_mapeo.print_transaccion();       
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
            end
         `uvm_info(get_type_name(), "Desplazandonos en fila", UVM_MEDIUM)

          while (terminal_fila != target_fila && movimientos<(target_fila - terminal_columna_inicial))  begin        
          terminal_fila=terminal_fila+direccion_filas;
                  movimientos=movimientos+1;
           c`uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
            trans_mapeo.print_transaccion();            
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
        end
          `uvm_info(get_type_name(), $sformatf("Desplazandonos en columna. en direccion %0d", direccion_columnas), UVM_MEDIUM)
              while (terminal_columna!=target_columna) begin
                  terminal_columna=terminal_columna+direccion_columnas;
                `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM) 
                trans_mapeo.print_transaccion();       
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
            end
          while (target_fila!=terminal_fila) begin
                  terminal_fila=terminal_fila+direccion_filas;
                `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
            trans_mapeo =new();
            trans_mapeo.terminal_columna=terminal_columna;
            trans_mapeo.terminal_fila=terminal_fila;
            trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
            cant_saltos+=1;
            `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
            trans_mapeo.print_transaccion();        
            this.scoreboard_checker_mbx.put(this.trans_mapeo);
        end
         transaccion_reducida_agente.cant_saltos=cant_saltos;
         transaccion_reducida_agente.print_transaccion();

          end
          else begin
              `uvm_info(get_type_name(), "Desplazandonos en columna", UVM_MEDIUM)
            if (terminal_fila==0 || terminal_fila ==5) begin
                `uvm_info(get_type_name(), $sformatf("me movi como el if:%0d", direccion_filas), UVM_MEDIUM)
                terminal_fila=terminal_fila+direccion_filas;
                movimientos=movimientos+1;
                `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
                trans_mapeo =new();
                trans_mapeo.terminal_columna=terminal_columna;
                trans_mapeo.terminal_fila=terminal_fila;
                trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                cant_saltos+=1;
                `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM) 
                trans_mapeo.print_transaccion();        
                this.scoreboard_checker_mbx.put(this.trans_mapeo);
            end
            while (terminal_columna != target_columna && movimientos<target_columna-terminal_columna_inicial) begin      
            terminal_columna=terminal_columna+direccion_columnas;
                  movimientos=movimientos+1;
              `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
              trans_mapeo.print_transaccion();         
              this.scoreboard_checker_mbx.put(this.trans_mapeo);
          end
             `uvm_info(get_type_name(), "Desplazandonos en fila", UVM_MEDIUM)

              while (terminal_fila!=target_fila) begin

                  terminal_fila=terminal_fila+direccion_filas;
                  `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
                  trans_mapeo =new();
                  trans_mapeo.terminal_columna=terminal_columna;
                  trans_mapeo.terminal_fila=terminal_fila;
                  trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
                  cant_saltos+=1;
                  `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
                  trans_mapeo.print_transaccion();
                  this.scoreboard_checker_mbx.put(this.trans_mapeo);
              end
            while (target_columna!=terminal_columna) begin
                  terminal_columna=terminal_columna+direccion_columnas;
              `uvm_info(get_type_name(), $sformatf("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila), UVM_LOW)
              trans_mapeo =new();
              trans_mapeo.terminal_columna=terminal_columna;
              trans_mapeo.terminal_fila=terminal_fila;
              trans_mapeo.dato=transaccion_entrante.pkg[pkg_size-9:0];
              cant_saltos+=1;
              `uvm_info(get_type_name(), $sformatf("La cantidad de saltos es:%0d", cant_saltos), UVM_MEDIUM)
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
  
  function write (item trans);
        `uvm_info"write", $sformatf("Se recibe del driver:%h", m_analysis.imp), UVM_HIGH)
        m_analysis_imp[{transaccion_entrante.target_fila, transaccion_entrante.target_columna,transaccion_entrante. payload}] = m_analysis_imp.dato;
  endfunction  

  //FASE CORRESPOMNDIENTE al checker
  function void report_phase( uvm_phase phase );
    `uvm_info("Inorder Comparator", $sformatf("Matches:m matches"), UVM LOW);
    `uvm_info("Inorder Comparator", $sformatf("Mismatches: %0d", m_mismatches), UVM_LOW);


 endfunction

endclass


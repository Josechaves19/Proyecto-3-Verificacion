class driver extends uvm_driver #(item);
	`uvm_component_utils(driver)

    function new(string name = "driver", uvm_component parent = null); //Constructor 
      super.new(name, parent);
    endfunction 

	virtual bus_mesh_if vif; //interfaz virtual
    int id_driver; 
  	bit [3:0] f_fila;
  	bit [3:0] f_columna;

  /////////////////////////////////////////////////////////


  
   //fase de construccion
    virtual function void  build_phase(uvm_phase phase); //Se conecta el bus_mesh_if con vif para la interfaz virtual.
        super.build_phase(phase);
        if (!uvm_config_db #(virtual bus_mesh_if)::get(this,"","bus_mesh_if",vif)) //uvm_config_db es una clase de utlidades para almacenar y recibir info entre componentes
            `uvm_fatal("Interfaz virtual", "No se pudo conectar vif")              //uvm_config_db es usada para recuperar la interfaz virtual a partir del agente
    endfunction
          
////////////////////////////////////////////////////////////

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        vif.reset = 1;

        vif.data_out_i_in[id_driver] = 0; // Ingresa un dato 0 a los diferentes terminales
        vif.pndng_i_in[id_driver] = 0; //Asigna el pending  de entrada =1  a las terminales

        @(posedge vif.clk);
        #1;
        vif.reset = 0;
        
        forever begin
          //`uvm_info("DRV", $formatf("Esperando por item de secuencia"), UVM_HIGH);
          item s_item;
          seq_item_port.get_next_item(s_item);
          @(posedge vif.clk);
            vif.data_out_i_in[id_driver] = 0;
            vif.pndng_i_in[id_driver] = 0;
          @(posedge vif.clk);
          @(posedge vif.clk);
          vif.data_out_i_in[id_driver] = {s_item.Next_jump, s_item.d_fila, s_item.d_columna, s_item.modo, f_fila, f_columna, s_item.dato}; //Podria agregarse la filas y columnas de origen para mostrarlas
            vif.pndng_i_in[id_driver] = 1;
          @(posedge vif.clk);
            wait (vif.popin[id_driver]);
            vif.pndng_i_in[id_driver] = 0;
            seq_item_port.item_done();
          //`uvm_info("DRV", $sformatf("Transaccion %s", item, print_transaccion()), UVM_HIGH);
          $display("El driver #%0d envia el mensaje: %b ", id_driver, vif.data_out_i_in[id_driver] );
          //$display("El driver #%0d envia a fila: %0d, columna: %0d ", id_driver, s_item.d_fila, s_item.d_columna);
          //$display("El driver #%0d envia a next_jmp: %0d, %0d", id_driver, f_fila, f_columna);
          //$display("El driver #%0d tiene fila: [%b], columna: [%b]", f_fila, f_columna);
        end   
    endtask 

endclass
      
class trans_bushandler_sequencer extends uvm_sequencer #(trans_bushandler);

    // Constructor
    function new(string name = "trans_bushandler_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Función para iniciar la secuencia
    virtual task body();
        trans_bushandler trans;
        `uvm_create(trans)
    
        // Randomizar algunos campos de la transacción
        trans.retardo = $urandom_range(0, 10); // Ejemplo: retardo en el rango [0, 10]
        trans.modo = $urandom_range(0, 1); // Ejemplo: modo como 0 o 1 de manera aleatoria
    
        // Utilizar randc para generar valores aleatorios controlados
        trans.target_fila = trans.target_fila.randc({0,1,2,3,4,5});
        trans.target_columna = trans.target_columna.randc({0,1,2,3,4,5});
        trans.dispositivo_tx = trans.dispositivo_tx.randc({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15});
        trans.dispositivo_rx = trans.dispositivo_rx.randc({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15});
        
        // Otras configuraciones y actualizaciones de la transacción
        trans.update_pkg();
        trans.calc_latencia();
    
        // Enviar la transacción al driver
        seq_item_port.put(trans, sequencer_get_next_priority() /*opcional*/);
    endtask

endclass
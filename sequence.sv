
class trans_sequence extends uvm_sequence;
    int ID_pkg;
    `uvm_object_utils(trans_sequence)
    function new(string name="trans_sequence");
        super.new(name);
    endfunction
    rand int num; //Numero de transacciones
    constraint NumTrans {soft num inside {[5:10]};}
    int dispositivo_rx=200;
    int dispositivo_tx=200; 
    virtual task body(); 
        
        for (int i = 0 ; i <num ; i++) begin
                trans_bushandler trans;
                trans=trans_bushandler::type_id::create("trans"); 
                start_item(trans); 
                trans.randomize();
                ID_pkg=trans.dispositivo_rx;
                trans.update_rows_columns(ID_pkg);
                if (dispositivo_rx!=200) begin
                    trans.dispositivo_rx=this.dispositivo_rx; 
                    ID_pkg=trans.dispositivo_rx;
                    trans.update_rows_columns(ID_pkg);

                end
                if (dispositivo_tx!=200) begin
                    trans.dispositivo_tx=this.dispositivo_tx;
                end
                trans.update_pkg; 
                `uvm_info("SEQ", $sformatf("Generando transaccion %40b", trans.pkg), UVM_LOW)
                
                finish_item(trans);
        end
        
        `uvm_info("SEQ",$sformatf("Terminando de generar %0d transacciones", num), UVM_LOW)
    endtask 
endclass


//module tb;

  //  trans_sequence secuencia;
   // initial begin
    //    
     //    secuencia=new();
      //  secuencia.randomize();
       // secuencia.body();
//    end

// endmodule




class trans_sequence extends uvm_sequence;
    int ID_pkg;
    `uvm_object_utils(trans_sequence)
    function new(string name="trans_sequence");
        super.new(name);
    endfunction
    rand int num; //Numero de transacciones
    constraint NumTrans {soft num inside {[2:50]};}

    virtual task body(); 
        
        for (int i = 0 ; i <num ; i++) begin
                trans_bushandler trans;
                start_item(trans); 
                trans.randomize();
                ID_pkg=trans.dispositivo_rx;
                trans.update_rows_columns(ID_pkg);
                trans.update_pkg; 
                `uvm_info("SEQ", $sformatf("Generando transaccion"), UVM_LOW)
                trans.print();
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



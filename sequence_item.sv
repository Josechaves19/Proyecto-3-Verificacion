
class trans_bushandler #(parameter ROWS =4, parameter COLUMNS = 4, parameter pkg_size =40) extends uvm_sequence_item;
   
    rand int retardo; 
    rand bit[pkg_size-26:0] dato; // este es el dato de la transacción 
    rand bit [3:0] target_fila;
    rand bit [3:0] target_columna;
    rand  bit modo;
    int tiempo_envio; //Representa el tiempo  de la simulación en el que se ejecutó la transacción 
    int tiempo_recibido; 
    int max_retardo;
    bit [7:0] nxt_jump;
    rand bit [3:0] dispositivo_tx; //fifo in (QUEUE)
    rand bit [3:0] dispositivo_rx; // fifo out (QUEUE)
    int drvrs=16;
    reg [pkg_size-1:0] pkg;
    int latencia;
    //Necesidades de trans_mapeo.
   int terminal_columna;
 int terminal_fila;
  bit [pkg_size-9:0] dato;
 function print_transaccion_mapeo();
   $display("trmnl_col: %g", this.terminal_columna);
   $display("trmnl_fil: %g", this.terminal_fila);
   $display("pkg sin nxt jump: %b",this.dato[pkg_size-9:0]);
endfunction 
   //

    function update_pkg;
        this.nxt_jump = 8'b00000000;
        this.pkg = {this.nxt_jump, this.target_fila, this.target_columna, this.modo, this.dispositivo_tx, this.dispositivo_rx, this.dato};
    endfunction
    constraint tiempo_recibido_constraint {
      tiempo_recibido >= tiempo_envio;
  }
    //Macros
    `uvm_object_utils_begin(trans_bushandler)
        `uvm_field_int(dato,UVM_ALL_ON)
        `uvm_field_int(dispositivo_tx,UVM_ALL_ON)
        `uvm_field_int(dispositivo_rx,UVM_ALL_ON)
        `uvm_field_int(pkg,UVM_ALL_ON)
    `uvm_object_utils_end   
    function update_rows_columns(int id);

        case (id)
         
          0: begin
            this.target_fila=0;
            this.target_columna=1;
          end  
          1:begin
            this.target_fila=0;
            this.target_columna=2;
          end  
          2:begin
            this.target_fila=0;
            this.target_columna=3;
          end  
          3:begin
            this.target_fila=0;
            this.target_columna=4;
          end  
          4:begin
            this.target_fila=1;
            this.target_columna=0;
          end  
          5:begin
            this.target_fila=2;
            this.target_columna=0;
          end  
          6:begin
            this.target_fila=3;
            this.target_columna=0;
          end  
          7:begin
            this.target_fila=4;
            this.target_columna=0;
          end  
          8:begin
            this.target_fila=5;
            this.target_columna=1;
          end  
          9:begin
            this.target_fila=5;
            this.target_columna=2;
          end  
          10:begin
            this.target_fila=5;
            this.target_columna=3;
          end  
          11:begin
            this.target_fila=5;
            this.target_columna=4;
          end  
          12:begin
            this.target_fila=1;
            this.target_columna=5;
          end  
          13:begin
            this.target_fila=2;
            this.target_columna=5;
          end  
          14:begin
            this.target_fila=3;
            this.target_columna=5;
          end  
          15:begin
            this.target_fila=4;
            this.target_columna=5;
          end
        endcase
      endfunction
      
function void calc_latencia();
    this.latencia=this.tiempo_recibido-this.tiempo_envio; 
  endfunction
  constraint tx_range {
    dispositivo_tx inside {[0: drvrs-1]}; // Restringido al rango de 0 a drvrs-1
    }
    constraint rx_range {
        dispositivo_rx inside {[0: drvrs-1]}; // Restringido al rango de 0 a drvrs-1
    }
     
    
    function new(string name = "trans_bushandler", int pkg_size=40);
        super.new(name);
    endfunction 
    function print_transaccion();

  $display("trgt_r: %g", this.pkg[this.pkg_size-9:this.pkg_size-12]);
  $display("trgt_c: %g", this.pkg[this.pkg_size-13:this.pkg_size-16]);
  $display("mode: %g",this.pkg[this.pkg_size-17]);
  $display("src: %g",this.pkg[this.pkg_size-18:this.pkg_size-21]);
  $display("id: %g",this.pkg[this.pkg_size-22:this.pkg_size-25]);
  $display("pyld: %b",this.pkg[this.pkg_size-26:0]);
  $display("pkg: %b", this.pkg);

endfunction
endclass  

//module trans_bushandler_tb;
  //  trans_bushandler trans;

    //initial begin
      //  for (int i=0 ; i<10; i++) begin 
       // trans = trans_bushandler::type_id::create();
        //trans.print_transaccion; 

       // trans.randomize();
       // trans.update_rows_columns(trans.dispositivo_rx);
       // trans.update_pkg;
       // trans.print_transaccion; 
       // trans.print();
//    end
//    end
//endmodule

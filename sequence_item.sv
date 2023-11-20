class trans_bushandler #(parameter ROWS =4, parameter COLUMNS = 4, parameter pkg_size =40) extends uvm_sequence_item;
   
    `uvm_object_utils(trans_bushandler);   
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
    reg [pkg_size-1:0] pkg;
    function update_pkg;
        this.nxt_jump = 8'b00000000;
        this.pkg = {this.nxt_jump, this.target_fila, this.target_columna, this.modo, this.dispositivo_tx, this.dispositivo_rx, this.dato};
    endfunction
    
   
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
     
    
    function new(string name = "trans_bushandler");
        super.new(name);
    endfunction 
endclass  
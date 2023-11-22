/*class trans_bushandler #(parameter pkg_size  = 40);
  rand int retardo; // tiempo de retardo en ciclos de reloj que se debe esperar antes de ejecutar la transacción
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
 
bit reset;//lo hago así para controlarlo manualmente y probarlo
constraint tx_range {
      dispositivo_tx inside {[0: drvrs-1]}; // Restringido al rango de 0 a drvrs-1
  }

  constraint rx_range {
      dispositivo_rx inside {[0: drvrs-1]}; // Restringido al rango de 0 a drvrs-1
  }
   

function bit inside_driver_range();
      if (dispositivo_rx >= 0 && dispositivo_rx < drvrs)
          return 1;
      else
          return 0;
  endfunction
//esta restricción const_dispositivo_rx  asegura que la variable dispositivo_rx debe estar dentro del rango definido, en resumen solo me asegura de que el ID que randomice, vaya de cero a drvrs-1 y que si el valor no esté en ese rango tire un error
  constraint const_retardo {retardo < max_retardo; retardo>0;} // esta restricción acota el retardo de cada transacción entre 0 y un retardo máximo definido
  constraint const_transmisor_receptor {this.dispositivo_rx != this.dispositivo_tx;} 
//////Creando el constructor para inicializar los miembros de la clase //////
function new(int rtrd = 0, bit [pkg_size-34:0] dato = 0,int temp = $time,int mx_rtrd = 10,bit [7:0] disp_tx = 0, bit [7:0] disp_rx = 0, bit rst=1);
this.retardo = rtrd;
this.dato = dato;
this.tiempo_envio = temp;
  this.reset=rst;
  this.pkg=0;
this.max_retardo = mx_rtrd;
this.dispositivo_tx = disp_tx;
this.dispositivo_rx = disp_rx;
  this.update_rows_columns(disp_rx);  
  this.nxt_jump=8'b0;

endfunction
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
function print_transaccion();

  $display("trgt_r: %g", this.pkg[this.pkg_size-9:this.pkg_size-12]);
  $display("trgt_c: %g", this.pkg[this.pkg_size-13:this.pkg_size-16]);
  $display("mode: %g",this.pkg[this.pkg_size-17]);
  $display("src: %g",this.pkg[this.pkg_size-18:this.pkg_size-21]);
  $display("id: %g",this.pkg[this.pkg_size-22:this.pkg_size-25]);
  $display("pyld: %b",this.pkg[this.pkg_size-26:0]);
  $display("pkg: %b", this.pkg);

endfunction
function print_transaccion_checker();
$display("pkg: %b", pkg);
$display("Tiempo de recibido", tiempo_recibido);
 endfunction

function void calc_latencia();
  this.latencia=this.tiempo_recibido-this.tiempo_envio; 
endfunction

endclass */

/*
class trans_gen_agent; //Transacción del generador al agente
  int cant_transac;
  int data_modo;        
  int tipo_dato; // Aleatorio o con variabilidad
  int tipo_envio; // A quien envia y como
  bit [3:0] fila;
  bit [3:0] columna;
  int fuente_aleat;
  int fuente;
  int retardo;
endclass

class Mapeo_colum_fila;
  int colum;
  int fila;
endclass


class trans_test_gen;
    int tipo_prueba; // Variable que indica el tipo de prueba que va ejecutarse
  endclass 
*///Esto lo comente por que creo que no lo necesito
//CLASE HECHA POR ALEX PARA OBTENER LO QUIE SE VA A PASAR AL MBX
class mapeo_ruta#(parameter pkg_size  = 40);
 int terminal_columna;
 int terminal_fila;
  bit [pkg_size-9:0] dato;
 function print_transaccion();
   $display("trmnl_col: %g", this.terminal_columna);
   $display("trmnl_fil: %g", this.terminal_fila);
   $display("pkg sin nxt jump: %b",this.dato[pkg_size-9:0]);

endfunction

endclass
class trans_trayectoria #(parameter pkg_size  = 40); 
  bit[pkg_size-9:0] dato;
  int fila;
  int columna; 

  function print_transaccion();
    $display("Dato: %b", this.dato);
    $display("Columna %g", this.columna);
    $display("Fila %g", this.fila);
  endfunction
endclass
class transaccion_reducida#(parameter pkg_size);
bit [pkg_size-1:0] pkg;
shortreal pkge=pkg_size; 
int tiempo_envio;
int cant_saltos;
int tiempo_recibido;
shortreal  retraso;
shortreal bandwidth;
   function print_transaccion();
      $display("Empezando funcion de impresion en transaccion reducida");
     $display("paquete: %b", this.pkg);
     $display("tiempo de envio: %g", this.tiempo_envio);
     $display("cant_saltos: %g", this.cant_saltos);  
     $display("tiempo de recibido: %g", this.tiempo_recibido);  
     $display("termine de imprimir");
   endfunction
function void calc_retraso();
   this.retraso=this.tiempo_recibido-this.tiempo_envio;
endfunction
function void calc_bandwidth();
   $display(this.pkg_size,this.retraso);
  $display(this.pkge/this.retraso); 
   this.bandwidth=this.pkge/this.retraso; 
 endfunction

endclass
//Interface actualizada
interface bus_mesh_if #( parameter rows = 4, parameter columns=4, parameter fifo_depth=8, parameter pkg_size = 40)
  (
    input clk  
  );
logic reset;
logic pndng[rows*2+columns*2];
logic pndng_i_in[rows*2+columns*2];
logic popin[rows*2+columns*2];
logic pop[rows*2+columns*2];
logic [pkg_size-1:0] data_out [rows*2+columns*2];
logic [pkg_size-1:0] data_out_i_in [rows*2+columns*2];

endinterface


/////////////////////////////////////////////////////////////////////////
// Definición de estructura para generar comandos hacia el scoreboard //
/////////////////////////////////////////////////////////////////////////
typedef enum {bw_promedio,retardo_promedio,reporte} solicitud_sb;

/////////////////////////////////////////////////////////////////////////
// Definición de estructura para generar comandos hacia el agente      //
/////////////////////////////////////////////////////////////////////////
typedef enum {llenado_aleatorio,OneForAll, AllForOne, trans_aleatoria} instrucciones_agente;

///////////////////////////////////////////////////////////////////////////////////////
// Definicion de mailboxes de tipo definido trans_fifo para comunicar las interfaces //
///////////////////////////////////////////////////////////////////////////////////////
typedef mailbox #(trans_bushandler) trans_bushandler_mbx;

///////////////////////////////////////////////////////////////////////////////////////
// Definicion de mailboxes de tipo definido trans_fifo para comunicar las interfaces //
///////////////////////////////////////////////////////////////////////////////////////
//typedef mailbox #(trans_sb) trans_sb_mbx;

///////////////////////////////////////////////////////////////////////////////////////
// Definicion de mailboxes de tipo definido trans_fifo para comunicar las interfaces //
///////////////////////////////////////////////////////////////////////////////////////
typedef mailbox #(solicitud_sb) comando_test_sb_mbx;

///////////////////////////////////////////////////////////////////////////////////////
// Definicion de mailboxes de tipo definido trans_fifo para comunicar las interfaces //
///////////////////////////////////////////////////////////////////////////////////////
typedef mailbox #(instrucciones_agente) comando_test_agente_mbx;

//////////////////////////////////////////////////////////////////////////////////////
//  Definicion de mailboxes de tipo definido mapeo_ruta para comunicar sb con chkr  //
//////////////////////////////////////////////////////////////////////////////////////
typedef mailbox #(mapeo_ruta) mapeo_ruta_mbx; 
typedef mailbox #(trans_trayectoria) trans_trayectoria_mbx; 

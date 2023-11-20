// Estudiantes: -Enmanuel Araya Esquivel. (emanuelarayaesq@gmail.com)
//              -Randall Vargas Chaves. (randallv07@gmail.com)
// Curso: EL-5511 Verificación funcional de circuitos integrados
// Este Script esta estructurado en System Verilog
// Propósito General: Objetos de datos que deben enviarse al DUT
// Modulo: Sequence_item

class mapeo;
int fila;
int column;
endclass

////////////////////////////////////////////////////////////////////////////////////
// Sequence Item: En este se realizan las transacciones que seran enviadas al DUT //
////////////////////////////////////////////////////////////////////////////////////

class item extends uvm_sequence_item;
`uvm_object_utils(item); // Registro en la fabrica
parameter int ROWS = 4;
parameter int COLUMS = 4;
parameter int pckg_sz = 40;

function new(string name = "item"); // Constructor
super.new(name);
endfunction

// Trasacción {Nextjump, d_fila, d_columna, modo, f_fila, f_columna, dato}
rand bit  [pckg_sz-26:0] dato;  // Payload
 rand bit modo; // Modo
bit [7:0] Next_jump = 8'b11111111;
rand bit  [3:0] d_fila;  // Fila de destino
rand bit  [3:0] d_columna;  // Columna de destino
//bit  [3:0] f_fila;  // Fila de fuente
//bit  [3:0] f_columna;  // Columna de fuente
rand int fuente;
mapeo pos_driver [COLUMS*2+ROWS*2];

//Otros
int tiempo;
int variabilidad;
rand int retardo;
int retardo_max=50;
int fuente_aux=5;

//salida
bit  [pckg_sz-1:0] salida;  // Fila de fuente


virtual function string print_transaccion(); // Imprime la transacción
  return $sformatf("Envio: Fila_d=%0h, Columna_d=%0h, Modo=%0d, Pyld=%0d", d_fila, d_columna, modo, dato);
endfunction

virtual function string print_salida(); // Imprime la transacción
    return $sformatf("Recibido: Fila_d=%0h, Columna_d=%0h, Modo=%0d, Fila_f=%0d, Columna_F=%0d, Pyld=%0d",
    salida[pckg_sz-9:pckg_sz-12], salida[pckg_sz-13:pckg_sz-16], salida[pckg_sz-17], salida[pckg_sz-18:pckg_sz-21], salida[pckg_sz-22:pckg_sz-26], salida[pckg_sz-27:0]); //[id_mntr] -> lo necesito?
endfunction

// *************************************Constraints*************************************

//Modo
constraint MODO_1 {modo == 1;};
constraint MODO_0 {modo == 0;};
//Fuente
constraint Existe_fuente {fuente >= 0; fuente < 2*ROWS+2*COLUMS;}; 
//constraint send_self {d_fila != pos_driver[fuente].fila; d_columna != pos_driver[fuente].column;};
//constraint send_self{d_fila == pos_driver[fuente].fila; d_columna == pos_driver[fuente].column;};
//constraint misma_fila_columna {d_fila != pos_driver[fuente].fila; d_columna != pos_driver[fuente].column;};
//Dirección
constraint Existe_direccion {d_fila <= ROWS+1; d_fila >= 0; d_columna <= COLUMS+1; d_columna >= 0;};
constraint restric_columna {
  if(d_fila == 0 | d_fila == ROWS+1) 
    d_columna <= COLUMS & d_columna > 0;
};
constraint restric_fila {
  if(d_columna == 0 | d_columna == COLUMS+1) 
    d_fila <= ROWS & d_fila > 0;
};
constraint direccion_valida_drvs {
  if(d_fila != 0 & d_fila != ROWS+1)
    d_columna == 0 | d_columna == COLUMS+1;
};
//Datos
//constraint variabilidad_dato {dato inside {{(pckg_sz-25){2'b10}},{(pckg_sz-25){2'b01}},{(pckg_sz-25){1'b1}},{(pckg_sz-25){1'b0}}};};// Variabilidad maxima

//Fuente estatica
//constraint Fuente_estatica {fuente == fuente_aux;};

//Retardo
constraint retardo_aleat{retardo<=retardo_max;retardo>0;};
constraint retardo_0{retardo == 0;};



endclass

class my_sequence extends uvm_sequence #(item);

`uvm_object_utils(my_sequence)
function new (string name="my_sequence");
    super.new(name);
endfunction
parameter int ROWS = 4;
parameter int COLUMS = 4;
parameter int pckg_sz = 40;

//`uvm_declare_p_sequencer() Debe agregarse?

rand int trans_num;
mapeo pos_driver [COLUMS*2+ROWS*2];

constraint trans_limit {soft trans_num inside {[50:100]};}

function void build_phase(uvm_phase phase);

  for (int i = 0; i<COLUMS;i++)begin 
      pos_driver[i].fila = 0;              
      pos_driver[i].column = i+1; 
  end 
    for (int i = 0; i<ROWS;i++)begin 
        pos_driver[i+COLUMS].column = 0; 
        pos_driver[i+COLUMS].fila = i+1; 
    end 
    for (int i = 0; i<COLUMS;i++)begin 
        pos_driver[i+ROWS*2].fila = ROWS+1; 
        pos_driver[i+ROWS*2].column = i+1; 
    end 
    for (int i = 0; i<ROWS;i++)begin 
        pos_driver[i+COLUMS*3].column = COLUMS+1; 
      pos_driver[i+COLUMS*3].fila = i+1; 
    end 
    /*foreach (pos_driver[i]) begin
        $display("POS %d ROW=%0d COL=%0d",i,pos_driver[i].row,pos_driver[i].column);
    */
  
endfunction

virtual task body();
    for (int i = 0; i < trans_num; i++) begin 
        item s_item = item::type_id::create("s_item");
        //Transacciones validas
        s_item.Existe_fuente.constraint_mode(1);
        s_item.Existe_direccion.constraint_mode(1);
        //s_item.send_self.constraint_mode(1);
        //Modo
        s_item.MODO_1.constraint_mode(0);
        s_item.MODO_0.constraint_mode(0);
        //retardo
      s_item.retardo_0.constraint_mode(1);
      s_item.retardo_aleat.constraint_mode(0);
        //fuente estatica
      //s_item.Fuente_estatica.constraint_mode(1);
        start_item(s_item);
        
        s_item.randomize();
        //`uvm_info("Sequenciador",$sformatf("Se genera nuevo item", s_item.print_transaccion()), UVM_HIGH);
        finish_item(s_item);
    end 
    //`uvm_info("Sequenciador",$sformatf("El numero de transacciones es  %0d", trans_num), UVM_LOW);
endtask
endclass


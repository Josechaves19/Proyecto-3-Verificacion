//Agente-Generador
//`include "transacciones_interface.sv"
class agente #(parameter pkg_size = 50, parameter drvrs=16);
  trans_bushandler_mbx test_agente_trans_mbx; 
//trans_sb_mbx agente_checker_mbx;
trans_bushandler_mbx agente_driver_mbx[16];
trans_bushandler_mbx agente_scoreboard_mbx; 
comando_test_agente_mbx test_agente_mbx; 
  int ID_pkg;
int max_retardo;
rand int num_transacciones_aleatorias;
rand int numero_aleatorio;
instrucciones_agente tipo_instruccion; 
trans_bushandler #(.pkg_size(pkg_size)) transaccion_driver;
//  trans_sb #(.pkg_size(pkg_size), .drvrs(drvrs)) trans_agente_checker;
string linea_csv, d_enviado,s_tx,s_rx,s_tp;
int tiempo_actual;
function new;
    max_retardo=20;
      this.transaccion_driver=new();
endfunction

constraint numero_aleatorio_const {numero_aleatorio>1; numero_aleatorio<50;} 
constraint num_transacciones_aleatorias_const {num_transacciones_aleatorias>20; num_transacciones_aleatorias<50;}
task  mailboxes_put();

   //tiempo_actual=$time;
   //while ($time-tiempo_actual<this.transaccion_driver.retardo) #1 

  this.transaccion_driver.print_transaccion();
  this.transaccion_driver.tiempo_envio=$time+transaccion_driver.retardo;
  this.agente_driver_mbx[this.transaccion_driver.dispositivo_tx].put(this.transaccion_driver);// Pongo la transaccion en el mailbox respectivo (hacia el driver)
  this.agente_scoreboard_mbx.put(this.transaccion_driver);
  d_enviado.hextoa(this.transaccion_driver.pkg); 
  $system($sformatf("echo %0s >> agente.csv", d_enviado)); 
  /* this.trans_agente_checker=new;  
   this.trans_agente_checker.dato_enviado=transaccion_driver.D_push;//Introduzco el paquete en la transaccion que va al checker
   this.trans_agente_checker.tiempo_push=$time;
   this.trans_agente_checker.drvr_rx=transaccion_driver.dispositivo_rx;
   this.trans_agente_checker.drvr_tx=transaccion_driver.dispositivo_tx;
   d_enviado.hextoa(this.transaccion_driver.D_push);
   s_rx.hextoa(this.transaccion_driver.dispositivo_rx);
   s_tx.hextoa(this.transaccion_driver.dispositivo_tx);
   linea_csv= {d_enviado,",",s_tx,",",s_rx,",",s_tp};
   $system($sformatf("echo %0s >> agente.csv", linea_csv));//Introduzco la informacion relevante al csv, esto en caso de que no haya broadcast
   this.agente_checker_mbx.put(trans_agente_checker); A1 */
endtask

task InitandRun;   
  
int trans_realizadas=0;
int trans_restantes;
this.randomize();     
$system("echo Paquete> agente.csv");//Envio el header del csv
$display("Inicializando agente en [%g], pkg_size %g y drvrs %g", $time, this.pkg_size, this.drvrs);//Inicializo el agente
begin

//$display ("Pruebas a realizar %g", num_transacciones);
trans_restantes=test_agente_mbx.num(); //Obteniendo numero de cosas en el mailbox

while (trans_restantes==0) begin
    
      
    trans_restantes=test_agente_mbx.num();//Esto es para  esperar a que llegue una transaccion
    if (trans_restantes==0) begin
        $display("Sin transacciones en el agente %g", $time);
end    
end
while(trans_restantes>0) begin 
    $display(trans_restantes); 
    $display("Transacciones Restantes %g", trans_restantes);
    $display("Instruccion tomada del mailbox en [%g]", $time);
    test_agente_mbx.get(tipo_instruccion);//Se toma la instruccion del mailbox del test
    case(tipo_instruccion)
        llenado_aleatorio: begin
            $display ("Llenando aleatoriamente a partir de [%g]", $time);
            for (int i=0; i<num_transacciones_aleatorias; i++) begin
                #1   
                
                transaccion_driver=new;
                transaccion_driver.drvrs=drvrs;
                transaccion_driver.max_retardo=30;
                transaccion_driver.randomize(); //Introduzco transacciones aleatorias a los mailboxes
                ID_pkg=transaccion_driver.dispositivo_rx;
             
                transaccion_driver.update_rows_columns(ID_pkg);
                transaccion_driver.update_pkg;
                
                
                mailboxes_put();//Lo pongo en mailboxes
            
                trans_realizadas++;
        
                
            end
        end
        trans_aleatoria: begin
                #1 
                $display ("Generando una transaccion aleatoria en [%g]", $time);
                transaccion_driver=new;
                transaccion_driver.drvrs=drvrs;
                transaccion_driver.randomize();//Hago una transaccion totalmente aleatoria
                  ID_pkg=transaccion_driver.dispositivo_rx;
                transaccion_driver.update_rows_columns(ID_pkg);
                transaccion_driver.update_pkg;
                    
                mailboxes_put();
               

                trans_realizadas++;


            end 

        OneForAll: begin
            
            $display ("Generando Una Para Todos");
            transaccion_driver=new;
            transaccion_driver.drvrs=drvrs;
            transaccion_driver.randomize();

            for (int j=0; j <this.drvrs; j=j+1) begin
              transaccion_driver.dispositivo_rx=j;
              for (int i = 0; i< this.drvrs; i=i+1) begin
                  if (i!=j) begin
                    ID_pkg=i;
                    transaccion_driver.dispositivo_tx=i;
                    transaccion_driver.update_rows_columns(ID_pkg);
                    transaccion_driver.update_pkg;          
                    mailboxes_put();
                  end
              end
            end
            trans_realizadas++;
            end

        

        AllForOne: begin
            
            $display ("Generando todas hacia uno");
            transaccion_driver=new;
            transaccion_driver.drvrs=drvrs;
            transaccion_driver.randomize();
            for (int j=0 ; j < this.drvrs; j=j+1) begin
              transaccion_driver.dispositivo_rx=j; 
              ID_pkg=j;
              for (int i=0; i<this.drvrs; i=i+1) begin 
                if (i!=j) begin
                  $display("Valores de I y J", i, j);
                  transaccion_driver.dispositivo_tx=i;
                  ID_pkg=transaccion_driver.dispositivo_rx;
                  transaccion_driver.update_rows_columns(ID_pkg);
                  transaccion_driver.update_pkg;
                  mailboxes_put();
                end
              end
            end
            trans_realizadas++;
        end

        
    endcase
    trans_restantes=test_agente_mbx.num();//Reviso las transacciones en caso de que haya nuevas transacciones en el mailbox

end
end

endtask

endclass                







    



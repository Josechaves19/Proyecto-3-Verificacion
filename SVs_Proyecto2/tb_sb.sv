`timescale 1ns/1ps
`include "scoreboard.sv"
//`include "transacciones_interface.sv"

module tb;
parameter pkg_size = 40;
parameter drvrs =16;
reg clk = 0;
trans_bushandler_mbx agente_scoreboard_mbx;
trans_bushandler#(.pkg_size(pkg_size)) transaccion_driver; //esto es lo que va al scoreboard tambien
trans_bushandler#(.pkg_size(pkg_size)) transaccion_checker_sb;

scoreboard#(.pkg_size(pkg_size), .drvrs(drvrs)) scoreboard_tb;
mapeo_ruta_mbx mapeo_ruta_mb;
mapeo_ruta#(.pkg_size(pkg_size)) trans;
trans_bushandler_mbx transaccion_checker_sb_mbx;

initial begin
    trans=new();
    transaccion_checker_sb_mbx=new();
    mapeo_ruta_mb=new();
    scoreboard_tb=new();
    transaccion_driver=new();
//    transaccion_reducida=new();
    agente_scoreboard_mbx=new();
    scoreboard_tb.agente_scoreboard_mbx=agente_scoreboard_mbx;
    scoreboard_tb.transaccion_checker_sb_mbx=transaccion_checker_sb_mbx;
    scoreboard_tb.scoreboard_checker_mbx=mapeo_ruta_mb;
    transaccion_driver.target_fila = 4'b0100;
    transaccion_driver.target_columna =4'b0101;
    transaccion_driver.modo=1;
    transaccion_driver.dispositivo_tx =4'b0111;
    transaccion_driver.dispositivo_rx =4'b1111; 
    transaccion_driver.tiempo_envio =1;
    transaccion_driver.dato = 100001000001000;
    transaccion_driver.update_pkg();
 //   transaccion_driver.pkg = 0000000001000101101111111010100011000111;
    transaccion_driver.print_transaccion();
    agente_scoreboard_mbx.put(transaccion_driver);

    //
   #100
    transaccion_driver=new();
    transaccion_driver.target_fila = 4'b0010;
    transaccion_driver.target_columna =4'b0101;
    transaccion_driver.modo=0;
    transaccion_driver.dispositivo_tx =4'b1001;
    transaccion_driver.dispositivo_rx =4'b1101; 
    transaccion_driver.tiempo_envio=2;
    transaccion_driver.dato = 100001010001111;
    transaccion_driver.update_pkg();
  transaccion_driver.print_transaccion();
     agente_scoreboard_mbx.put(transaccion_driver); 
       scoreboard_tb.run();
       $display("Contenido del mailbox :");
   while(mapeo_ruta_mb.num()>0)begin
           mapeo_ruta_mb.try_get(trans);
           trans.print_transaccion();
           end

/////////////////////////////////////////////////////////////////////////////////////////
#1    
     transaccion_checker_sb=new();
     //debo inicializar en cero el resto de los atributos
     transaccion_checker_sb.target_fila = 4'b0100;
     transaccion_checker_sb.target_columna =4'b0101;
     transaccion_checker_sb.modo=1;
     transaccion_checker_sb.dispositivo_tx =4'b0111;
     transaccion_checker_sb.dispositivo_rx =4'b1111; 
     transaccion_checker_sb.dato = 100001000001000;
     transaccion_checker_sb.update_pkg();
     //$display("imprimiendo lo del paquete:%b",transaccion_checker_sb.pkg);

     transaccion_checker_sb.tiempo_recibido=10;
     //transaccion_checker_sb.print_transaccion_checker();
     transaccion_checker_sb_mbx.put(transaccion_checker_sb);
#100
     transaccion_checker_sb=new();
     transaccion_checker_sb.target_fila = 4'b0010;
     transaccion_checker_sb.target_columna =4'b0101;
     transaccion_checker_sb.modo=0;
     transaccion_checker_sb.dispositivo_tx =4'b1001;
     transaccion_checker_sb.dispositivo_rx =4'b1101;
     transaccion_checker_sb.tiempo_envio=2;
     transaccion_checker_sb.dato = 100001010001111;

     transaccion_checker_sb.update_pkg();
    // $display("imprimiendo lo del paquete:%b",transaccion_checker_sb.pkg);
   
     transaccion_checker_sb.tiempo_recibido=30;
    //transaccion_checker_sb.print_transaccion_checker();
     transaccion_checker_sb_mbx.put(transaccion_checker_sb);

//     scoreboard_tb.solicitudes();
/*
while(transaccion_checker_sb_mbx.num()>0)begin
    $display("Imprimiendo lo que viene del checker");
          transaccion_checker_sb_mbx.try_get(transaccion_checker_sb);
          transaccion_checker_sb.print_transaccion_checker();
         end*/
scoreboard_tb.solicitudes();

#1000
scoreboard_tb.reporte();
end
    endmodule

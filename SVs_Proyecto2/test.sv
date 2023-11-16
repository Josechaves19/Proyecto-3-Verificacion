class test #(parameter pkg_size = 50, parameter drvrs= 16);
    comando_test_agente_mbx test_agente_mbx;
    rand int num_transacciones;
  constraint num_transacciones_max {num_transacciones < 2; num_transacciones>0;}//Constraint del numero de transacciones minimos
    parameter max_retardo=20;
    rand int casos;
    constraint casos_const {casos<4;}//Limito este numero a 5, para que el caso sea el adecuado
    solicitud_sb solicitud_scoreboard;
    instrucciones_agente instruccion_agente;
    trans_bushandler transaccion_test_agente;
    trans_bushandler_mbx transaccion_test_agente_mbx;
    comando_test_sb_mbx transaccion_test_sb_mbx;
    //Implementar Ambiente
    instrucciones_agente caso;
    int primer_num;
    function new;
      
        transaccion_test_agente_mbx=new();
    endfunction
    function instrucciones_agente randomizar_transacciones;
        reg [2:0] escoge_casos;
        escoge_casos=this.casos;
        case(escoge_casos)
            0: begin
                $system("echo Transaccion Aleatoria>> test.csv");//Envio el header del csv
                return trans_aleatoria;

            end
            1: begin
                $system("echo Llenado Aleatorio>> test.csv");//Envio el header del csv
                return llenado_aleatorio;
            end
            2: begin
                $system("echo Uno para todos>> test.csv");//Envio el header del csv
                return OneForAll;

            end
            3: begin
                $system("echo Todos para uno>> test.csv");//Envio el header del csv
                return AllForOne;
            end

        endcase
    

    endfunction
    task run;
        #10
        $system("echo Pruebas a correr> test.csv");//Envio el header del csv
        $display("[%g] Inicializando Test", $time);
        this.randomize();
        $display("Numero de transacciones a realizar %g", num_transacciones);
        this.primer_num=this.num_transacciones;
        for (int i=0; i<primer_num; i++) begin
            #1
            this.randomize();
            caso=this.randomizar_transacciones;
            this.test_agente_mbx.put(caso); 
	        $display("Transaccion introducida en el mailbox %g", caso);
        end

    endtask

   
endclass
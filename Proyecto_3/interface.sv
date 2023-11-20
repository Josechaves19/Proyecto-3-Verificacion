// Estudiantes: -Enmanuel Araya Esquivel. (emanuelarayaesq@gmail.com)
//              -Randall Vargas Chaves. (randallv07@gmail.com)
// Curso: EL-5511 Verificación funcional de circuitos integrados
// Este Script esta estructurado en System Verilog
// Propósito General: Diseño de pruebas en capas para un BUS mesh de datos
// Modulo: Interface

////////////////////////////////////////////////////////////////
// Interface: Esta es la interface que se conecta con el Bus  //
////////////////////////////////////////////////////////////////

interface bus_mesh_if #(parameter ROWS = 4, parameter COLUMS =4, parameter pckg_sz =40, parameter fifo_depth = 4) (
    input bit clk);

    logic pndng[ROWS*2+COLUMS*2];
    logic [pckg_sz-1:0] data_out[ROWS*2+COLUMS*2];
    logic popin[ROWS*2+COLUMS*2];
    logic pop[ROWS*2+COLUMS*2];
    logic [pckg_sz-1:0]data_out_i_in[ROWS*2+COLUMS*2];
    logic pndng_i_in[ROWS*2+COLUMS*2];
    logic reset;

    clocking cb @(posedge clk);
        input pndng;
        input data_out;
        input popin;
        output pop;
        output data_out_i_in;
        output pndng_i_in;
    endclocking
endinterface

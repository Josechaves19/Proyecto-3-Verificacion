`timescale 1ns/1ps
`include "transacciones_interface.sv"
`include "agente.sv"
`include "test.sv"
`include "driver.sv"
`include "Router_library.sv"
`include "monitorAlex.sv"  
`include "scoreboard.sv"
`include "monitor_switches.sv"
`include "checker.sv"
`include "ambiente.sv"
// Modulo del testbench

module tb;
    parameter rows = 4;
    parameter columns = 4;
    parameter fifo_depth = 8;
    parameter pkg_size = 40;
  
    reg clk = 0;
	


	bus_mesh_if #(rows, columns, fifo_depth, pkg_size) _if (.clk(clk));


	always #5 clk = ~clk;
	
    mesh_gnrtr#(.ROWS(rows), .COLUMS(columns), .pkg_size(40), .fifo_depth(fifo_depth)) uut(
        .clk(clk),
        .reset(_if.reset),
        .pndng(_if.pndng),
        .data_out(_if.data_out),
        .popin(_if.popin),
        .pop(_if.pop),
        .data_out_i_in(_if.data_out_i_in),
        .pndng_i_in(_if.pndng_i_in)
      );

    ambiente #(.rows(rows), .columns(columns), .fifo_depth(fifo_depth), .pkg_size(pkg_size)) ambiente_tb;

	initial begin
        clk=0;
        _if.reset=0;
        #5
        _if.reset=1;
        #5
        _if.reset=0;
         for (int i =0; i<16;i=i+1) begin
         _if.pop[i]=0;
         _if.pndng_i_in[i]=0;
         _if.data_out_i_in[i]=0;
        end
		clk = 0;
		ambiente_tb = new();
		ambiente_tb._if = _if;
		ambiente_tb.randomize();
		fork
          $display("Corriendo Ambiente de simulacion en [%g]", $time); 
			ambiente_tb.run();
		join_none
	end

	always@(posedge clk)begin
      if ($time > 50000)begin
			$display("Testbench: Tiempo limite de prueba en el testbench alcanzado:%g",$time);
           ambiente_tb.reportes(); 
			$finish;
		end
	end
endmodule

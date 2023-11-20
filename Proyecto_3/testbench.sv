
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "Router_library.sv"
`include "interface.sv"
`include "sequence_item.sv"
//`include "sequence.sv"
`include "monitor.sv"
`include "Driver.sv"
//`include "scoreboard.sv"
`include "agente.sv"
`include "ambiente.sv"
`include "test.sv"

module tb;	
	//import "DPI-C" context function int report();
	reg clk;
	always #10 clk =~ clk;
	bus_mesh_if vif(clk);

    //Defincion de parametros
	parameter ROWS_tb = 4;
	parameter COLUMS_tb = 4;
	parameter pckg_sz_tb = 40;
	parameter fifo_depth_tb = 8;
	parameter c_fila_tb = 0;
  	parameter broadcast ={pckg_sz_tb-18{1'b1}};
	parameter c_columna_tb = 0;
	parameter drvrs_tb = ROWS_tb*2+COLUMS_tb*2;
	
  
    //Se genera dumpfile para ver señales
	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0,tb);
	end

	mesh_gnrtr #(.ROWS(ROWS_tb), .COLUMS(COLUMS_tb), .pckg_sz(pckg_sz_tb),.fifo_depth(fifo_depth_tb), .bdcst(broadcast)) DUT (
  		.clk(clk),
  		.reset(vif.reset),
  		.pndng(vif.pndng),
  		.data_out(vif.data_out),
  		.popin(vif.popin),
  		.pop(vif.pop),
  		.data_out_i_in(vif.data_out_i_in),
  		.pndng_i_in(vif.pndng_i_in));

	initial begin
		clk <= 0;
		uvm_config_db#(virtual bus_mesh_if)::set(null,"uvm_test_top","bus_mesh_if",vif);
		run_test("test_debug");
	end
	
endmodule

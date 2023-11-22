`include "uvm_macros.svh"
import uvm_pkg::*;
`include "Router_library.sv"
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "monitor.sv"
`include "driver.sv"
//`include "scoreboard.sv"
`include "agente.sv"
`include "ambiente.sv"
`include "test.sv"


module tb;
    reg clk;
    always #5 clk = ~clk;
    bus_mesh_if vif(clk);

    parameter ROWS=4;
    parameter COLUMNS=4;
    parameter pkg_size=4;
    parameter fifo_depth=4;
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
            clk<=0;
            uvm_config_db#(virtual bus_mesh_if)::set(null,"uvm_test_top","bus_mesh_if",vif);
            run_test("test_1");
        end
    endmodule

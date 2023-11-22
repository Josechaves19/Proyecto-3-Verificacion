`include "uvm_macros.svh"
import uvm_pkg::*;
`include "Router_library.sv"
`include "Interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "monitor.sv"
`include "driver.sv"
//`include "scoreboard.sv"
`include "agente.sv"
`include "ambiente.sv"
`include "test.sv"
`include "Wrapper.sv"

module tb;
    reg clk;
    always #5 clk = ~clk;

    parameter ROWS=4;
    parameter COLUMS=4;
    parameter pkg_size=4;
    parameter fifo_depth=4;
    bus_mesh_if vif(clk); 
    uut_wrapper uut(._if (vif));  
        initial begin
            clk<=0;
            uvm_config_db#(virtual bus_mesh_if)::set(null,"uvm_test_top","vif",vif);
            uvm_config_db#(int)::set(null, "*","COLUMS", COLUMS);
             uvm_config_db#(int)::set(null, "*","ROWS", ROWS);
             uvm_config_db#(int)::set(null, "*","fifo_size", fifo_depth);
            uvm_config_db#(int)::set(null, "*","pckg_sz", pkg_size);
            run_test("test_5");
            
        end
    endmodule

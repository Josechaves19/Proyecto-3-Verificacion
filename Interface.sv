interface bus_mesh_if #(parameter ROWS = 4, parameter COLUMNS =4, parameter pkg_sz =40, parameter fifo_depth = 4) (
    input bit clk);

    logic pndng[ROWS*2+COLUMNS*2];
    logic [pkg_sz-1:0] data_out[ROWS*2+COLUMNS*2];
    logic popin[ROWS*2+COLUMNS*2];
    logic pop[ROWS*2+COLUMNS*2];
    logic [pkg_sz-1:0]data_out_i_in[ROWS*2+COLUMNS*2];
    logic pndng_i_in[ROWS*2+COLUMNS*2];
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
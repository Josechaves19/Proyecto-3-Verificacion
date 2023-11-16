////////////////////////////////////////////////////////////////
// fifo_in: Este bloque se encarga de mandar los datos al DUT //
////////////////////////////////////////////////////////////////

class fifo_in #(parameter rows = 4, parameter columns = 4, parameter pkg_size = 50, parameter fifo_depth = 4);

    bit [pkg_size-1:0] FIFO_IN[$]; //Queue llamada FIFO_IN
    int id_fifo;
    virtual bus_mesh_if #(.rows(rows), .columns(columns), .pkg_size(pkg_size),.fifo_depth(fifo_depth)) vif;

    function new (int ID); //id_fifo identifica el numero de fifo correspondiente a la instancia
        FIFO_IN = {}; //Inicializa la Queue vacia 
        this.id_fifo = ID; //Asigna un numero a la variable id_fifo, segun el numero de iteraciones que se haga en el testbench
    endfunction


    function Fin_push(bit [pkg_size-1:0] dato); // Push de la FIFO in
            this.FIFO_IN.push_back(dato);
            this.vif.data_out_i_in[this.id_fifo] = FIFO_IN[0];
            this.vif.pndng_i_in[this.id_fifo] = 1;
    endfunction

    task interfaz();
        $display("FIFO #%d: ingresa dato al bus",this.id_fifo);
          this.vif.pndng_i_in[this.id_fifo] = 0;
        forever begin
            if(this.FIFO_IN.size==0) begin 
                this.vif.pndng_i_in[this.id_fifo] = 0;
                this.vif.data_out_i_in[this.id_fifo] = 0;
            end
            else begin
                this.vif.pndng_i_in[this.id_fifo] = 1;
                this.vif.data_out_i_in[this.id_fifo] = FIFO_IN[0];
            end
              @(posedge this.vif.popin[this.id_fifo]);
          if(this.FIFO_IN.size>0) this.FIFO_IN.delete(0);
        end
    endtask
endclass



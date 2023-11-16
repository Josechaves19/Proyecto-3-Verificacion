

module tb;
  int pkg_size;
  trans_bushandler #(50) trans;
  bit [3:0] target_fila;
  bit [3:0] target_columna;
  initial begin;
    pkg_size=50;
    trans=new();
    $display("Hola");
    trans.randomize();
    trans.update_pkg();
    $display("%g", trans.dispositivo_rx);
    $display("trgt_r: %g", trans.pkg[50-9:50-12]);
    $display("trgt_c: %g", trans.pkg[50-13:50-16]);
    $display("mode: %g",trans.pkg[50-17]);
      $display("src: %g",trans.pkg[50-18:50-21]);
      $display("id: %g",trans.pkg[50-22:50-25]);
      $display("pyld: %h",trans.pkg[50-26:0]);
  end
endmodule


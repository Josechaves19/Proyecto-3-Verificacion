always @* begin
    case (dispositivo_tx) 
      4'b0000: begin
        columna_terminal = 0;
        fila_terminal = 0;
      4'b0001:
        columna_terminal = 1;
        fila_terminal = 0;
      4'b0010:
        columna_terminal = 2;
        fila_terminal = 0;
      4'b0011:
        columna_terminal = 3;
        fila_terminal = 0;
      4'b0100:
        columna_terminal = 0;
        fila_terminal = 1;
      4'b0101:
        columna_terminal = 1;
        fila_terminal = 1;
      4'b0110:
        columna_terminal = 2;
        fila_terminal = 1;
      4'b0111:
        columna_terminal = 3;
        fila_terminal = 1;
      4'b1000:
        columna_terminal = 0;
        fila_terminal = 2;
      4'b1001:
        columna_terminal = 1;
        fila_terminal = 2;
      4'b1010:
        columna_terminal = 2;
        fila_terminal = 2;
      4'b1011:
        columna_terminal = 3;
        fila_terminal = 2;
      4'b1100:
        columna_terminal = 0;
        fila_terminal = 3;
      4'b1101:
        columna_terminal = 1;
        fila_terminal = 3;
      4'b1110:
        columna_terminal = 2;
        fila_terminal = 3;
      4'b1111:
        columna_terminal = 3;
        fila_terminal = 3;
      default:
        columna_terminal = 0;
        fila_terminal = 0;
    endcase
    $display("columna terminal: %d, fila terminal: %d", columna_terminal, fila_terminal);
  end
always @* begin
    case (dispositivo_tx)
      4'b0000: begin
        columna_terminal = 0;
        fila_terminal = 0;   end
      4'b0001: begin
        columna_terminal = 1;
        fila_terminal = 0;  end
      4'b0010: begin
        columna_terminal = 2;
        fila_terminal = 0;  end
      4'b0011: begin
        columna_terminal = 3;
        fila_terminal = 0;  end
      4'b0100: begin
        columna_terminal = 0;
        fila_terminal = 1;  end
      4'b0101: begin
        columna_terminal = 1;
        fila_terminal = 1;  end
      4'b0110: begin
        columna_terminal = 2;
        fila_terminal = 1;  end
      4'b0111: begin
        columna_terminal = 3;
        fila_terminal = 1;  end
      4'b1000:begin
        columna_terminal = 0;
        fila_terminal = 2; end
      4'b1001: begin
        columna_terminal = 1;
        fila_terminal = 2; end
      4'b1010: begin
        columna_terminal = 2;
        fila_terminal = 2; end
      4'b1011: begin
        columna_terminal = 3;
        fila_terminal = 2; end
      4'b1100: begin
        columna_terminal = 0;
        fila_terminal = 3; end
      4'b1101: begin
        columna_terminal = 1;
        fila_terminal = 3; end
      4'b1110: begin
        columna_terminal = 2;
        fila_terminal = 3; end
      4'b1111: begin
        columna_terminal = 3;
        fila_terminal = 3; end
      default:
        $display("terminal invalida")
    endcase
    $display("columna terminal: %d, fila terminal: %d", columna_terminal, fila_terminal);
  end
module tb;
    initial begin
      int modo=1;
        int terminal_fila=1;
          int target_fila=4;
          int terminal_columna=5;
        int target_columna=5;
          int direccion_filas=1;
        int direccion_columnas=1;
        int movimientos=0;
      $display("Comenzamos en el punto columna %g fila %g", terminal_columna, terminal_fila);  
      if (terminal_fila>target_fila) begin
            direccion_filas=-1;
        end
      
      if (target_columna>terminal_columna) begin
            direccion_columnas=1;
        
        end
      if (target_fila==terminal_fila || target_columna==terminal_columna) begin
        if (target_fila==terminal_fila) begin
          if (target_fila==5) begin
              terminal_fila=terminal_fila-1;
            $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);	
            $display("Desplazandonos en columna. en direccion %g", direccion_columnas);
              while (terminal_columna!=target_columna) begin
                  terminal_columna=terminal_columna+direccion_columnas;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              end
            terminal_fila=terminal_fila+1;
            $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);	
            
          end
          else begin
                    terminal_fila=terminal_fila+1;
                        $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);	
                    
              while (terminal_columna!=target_columna) begin
                    terminal_columna=terminal_columna+direccion_columnas;
                    $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              end
                    terminal_fila=terminal_fila-1;
            $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);	
          end
        end
        else begin
            if (target_columna==5) begin
                terminal_columna=terminal_columna-1;
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);	
              $display("Desplazandonos en filas en direccion %g", direccion_filas);
                while (terminal_fila!=target_fila) begin
                    terminal_fila=terminal_fila+direccion_filas;
                  $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                end
              terminal_columna=terminal_columna+1;
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);	
              
            end
            else begin
                      terminal_columna=terminal_columna+1;
                      $display("Desplazandonos en columna. en direccion %g", direccion_columnas);
                while (terminal_fila!=target_fila) begin
                      terminal_fila=terminal_fila+direccion_filas;
                      $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
                end
                      terminal_columna=terminal_columna-1;
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);	
            end

        end

      
      end
    else begin
        if (modo==0) begin //no se el valor, pero aja, solo para tener un machote
          if (terminal_columna==0 || terminal_columna ==5) begin
                  terminal_columna=terminal_columna+direccion_columnas;
                  movimientos=movimientos+1;	
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              end
          $display("Desplazandonos en Fila");
          while (terminal_fila != target_fila && movimientos<4) begin
                  terminal_fila=terminal_fila+direccion_filas;
                  movimientos=movimientos+1;
            $display("Ahora nos encontramos en el punto  columna %g  fila %g", terminal_columna, terminal_fila);
              end
          $display("Desplazandonos en columna. en direccion %g", direccion_columnas);
              while (terminal_columna!=target_columna) begin
                  terminal_columna=terminal_columna+direccion_columnas;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              end
          while (target_fila!=terminal_fila) begin
                  terminal_fila=terminal_fila+direccion_filas;
            $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
          end
    
    
          end
          else begin
            $display("Desplazandonos en columna");
            if (terminal_fila==0 || terminal_fila ==5) begin
                  terminal_fila=terminal_fila+direccion_filas;
                movimientos=movimientos+1;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              end
            while (terminal_columna != target_columna && movimientos<4) begin
                  terminal_columna=terminal_columna+direccion_columnas;
                  movimientos=movimientos+1;
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              end
              $display("Desplazandonos en fila");
              while (terminal_fila!=target_fila) begin
    
                  terminal_fila=terminal_fila+direccion_filas;
                $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
              end
            while (target_fila!=terminal_fila) begin
                  terminal_fila=terminal_fila+direccion_filas;
              $display("Ahora nos encontramos en el punto columna %g fila %g", terminal_columna, terminal_fila);
            end
    
    
          end
    end
            
        
    end
    endmodule
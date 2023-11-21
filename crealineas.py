for x in range(1, 5):
    for y in range(1, 5):
        for z in range(0, 4):
            print(f"fork \n while($time<100000) begin \n transaccion_checker=new(); \n  @(posedge tb.uut._rw_[{x}]._clm_[{y}].rtr._nu_[{z}].rtr_ntrfs_.pop) begin \n transaccion_checker.columna={y};\n transaccion_checker.fila={x}; \n transaccion_checker.dato=tb.uut._rw_[{x}]._clm_[{y}].rtr._nu_[{z}].rtr_ntrfs_.data_out[pkg_size-9:0];  \n switches_checker_mbx.put(transaccion_checker); \n end \nend \n join_none")


CREATE OR REPLACE PROCEDURE `ds_b_sp_core.altchequesfact_opt_oro`(val_first_day DATE, val_last_day DATE, PROJECT_ID_PLT STRING, PROJECT_ID_ORO STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(

"INSERT INTO " ,PROJECT_ID_ORO, ".`ds_b_dwh_cap_oro.t_b_dwh_cap_saldo_vista` (",
    "cuenta_id,",
    "fechaultmov_date,",
    "cliente_dwh_id,",
    "pdimproducto_id,",
    "pdimtiempo_fecha,",
    "saldodisval_monto",
    " )",
" SELECT",
" cuenta_id,",
"fechaultmov_date,",
"cliente_dwh_id,",
"pdimproducto_id,",
"pdimtiempo_fecha,",
"saldodisval_monto ",
"FROM ", PROJECT_ID_PLT, ".`ds_b_dwh_cap_plt.t_b_dwh_cap_saldo_vista`",
"WHERE pdimtiempo_fecha BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
);
END;
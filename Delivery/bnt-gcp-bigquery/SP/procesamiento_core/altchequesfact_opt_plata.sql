CREATE OR REPLACE PROCEDURE `ds_b_sp_core.altchequesfact_opt_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(

"INSERT INTO " ,PROJECT_ID_PLT, ".`ds_b_dwh_cap_plt.t_b_dwh_cap_saldo_vista` (",
    "cuenta_id,",
    "fechaultmov_date,",
    "cliente_dwh_id,",
    "pdimproducto_id,",
    "pdimtiempo_fecha,",
    "saldodisval_monto",
    " )",
" SELECT",
" cuenta,",
  "fechaultmov,",
  "CAST(pdimcliente AS INT64),",
  "pdimproducto,",
  "pdimtiempo,",
  "saldodisval,",
"FROM ", PROJECT_ID_BRC, ".`ds_b_dwh_cap_brc.altchequesfact_opt`",
"WHERE pdimtiempo BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
);
END;
CREATE OR REPLACE PROCEDURE `ds_b_sp_core.altamira_fusiones_fin_opt_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(

"INSERT INTO " ,PROJECT_ID_PLT, ".`ds_b_cli_plt.t_b_cli_fusiones` (",
     "clie_fusio_id,",
     "clie_perm_numero,",
     "fecha_informacion",
    " )",
" SELECT",
" CAST(clie_fusio AS INT64)clie_fusio,",
"clie_perm,",
"fecha_informacion,",
"FROM ", PROJECT_ID_BRC, ".`ds_b_cli_brc.altamira_fusiones_fin_opt`",
"WHERE fecha_informacion BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
);
END;
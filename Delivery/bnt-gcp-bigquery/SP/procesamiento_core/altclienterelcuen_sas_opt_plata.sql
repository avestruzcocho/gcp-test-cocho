CREATE OR REPLACE PROCEDURE `ds_b_sp_core.altclienterelcuen_sas_opt_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(

"INSERT INTO " ,PROJECT_ID_PLT, ".`ds_b_cli_plt.t_b_cli_productos` (",
    "cliente_id,",
    "cuenta_id,",
    "producto_tipo,",
    "estatus_tipo,",
    "nom_subp_nombre,",
    "fecha_informacion",
    " )",
" SELECT",
" CAST(num_clie as int64)num_clie,",
  "cuenta,",
  "tipo,",
  "estatus,",
  "nom_subp,",
  "fecha_informacion,",
"FROM ", PROJECT_ID_BRC, ".`ds_b_cli_brc.altclienterelcuen_sas_opt`",
"WHERE fecha_informacion BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
);
END;
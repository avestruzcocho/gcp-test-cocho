CREATE OR REPLACE PROCEDURE `ds_b_sp_core.fugas_total_personal_observadas_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(

"INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_ant_plt.t_b_ant_fugas_total_personal_observadas` (",
    "cliente_id,",
    "fecha_informacion,",
    "objetivo,",
    "fecha_abandono",
    " )",
  " SELECT ",
  " CAST(clie_final AS INT64),",
  "fecha_obs,",
  "CAST(target AS INT64),",
  "fecha_abandono,",
  "FROM ", PROJECT_ID_BRC, ".`ds_b_ant_brc.fugas_total_personal_observadas`",
  "WHERE fecha_abandono BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
  );
END;
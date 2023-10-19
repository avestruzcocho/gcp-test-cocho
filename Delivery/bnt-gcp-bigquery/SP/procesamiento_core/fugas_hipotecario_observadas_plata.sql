CREATE OR REPLACE PROCEDURE `ds_b_sp_core.fugas_hipotecario_observadas_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
  EXECUTE IMMEDIATE CONCAT(
    "INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_ant_plt.t_b_ant_fugas_hipotecario_observadas` (",
    "cliente_id,",
    "credito,",
    "fuga_bandera,",
    "fecha_informacion ",
    ") ",
    "SELECT ",
    "CAST(num_clie AS INT64),",
    "CAST (credito AS INT64),",
    "CAST(flag_fuga AS INT64),",
    "fecha_informacion ",
    "FROM ", PROJECT_ID_BRC, ".`ds_b_ant_brc.fugas_hipotecario_observadas` ",
    "WHERE fecha_informacion BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
  );
  END;
CREATE OR REPLACE PROCEDURE `ds_b_sp_core.segmentos_clientes_opt_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
  EXECUTE IMMEDIATE CONCAT(
    "INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_cli_plt.t_b_cli_segmentos` (",
    "cliente_id,",
    "segmento_nombre,",
    "subsegmento_numero,",
    "fecha_informacion ",
    ") ",
    "SELECT ",
    "cast(num_clie as int64) num_clie,",
    "segmento,",
    "subsegmento,",
    "fecha_informacion ",
    "FROM ", PROJECT_ID_BRC, ".`ds_b_cli_brc.segmentos_clientes_opt` ",
    "WHERE fecha_informacion BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
  );
  END;
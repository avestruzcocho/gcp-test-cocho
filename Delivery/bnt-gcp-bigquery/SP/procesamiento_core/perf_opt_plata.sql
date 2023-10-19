CREATE OR REPLACE PROCEDURE `ds_b_sp_core.perf_opt_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
  EXECUTE IMMEDIATE CONCAT(
    "INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_col_plt.t_b_col_tdc_mensual` (",
    "ambs_acct_id,",
    "sdo_total_fin_monto,",
    "clasificacion1_bandera,",
    "mes_fecha,",
    "ambs_abierta_fecha,",
    "ambs_bloqueo_codigo_1,",
    "ambs_bloqueo_codigo_2,",
    "fecha_informacion ",
    ") ",
    "SELECT ",
    "ambs_acct,",
    "sdo_total_fin,",
    "clasificacion1,",
    "mth,",
    "ambs_date_opened,",
    "ambs_block_code_1,",
    "ambs_block_code_2,",
    "fecha_informacion ",
    "FROM ", PROJECT_ID_BRC, ".`ds_b_col_brc.perf_opt` ",
    "WHERE fecha_informacion BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
  );
  END;
CREATE OR REPLACE PROCEDURE `ds_b_sp_core.ctasactnom_opt_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(
  "INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_cap_plt.t_b_cap_dispersion_nomina_m`(",
  "cliente_id,",
  "mes_fecha,",
  "importe_acum_monto,",
  "fecha_informacion",
   " )",
   " SELECT",
   " CAST(num_clie AS INT64),",
   "mth,",
   "importe_acum,",
   "fecha_informacion,",
   "FROM ", PROJECT_ID_BRC, ".`ds_b_cap_brc.ctasactnom_opt`",
   "WHERE mth BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
    );
END;
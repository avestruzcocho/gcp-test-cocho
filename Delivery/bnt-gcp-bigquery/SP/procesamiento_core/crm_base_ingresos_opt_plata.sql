CREATE OR REPLACE PROCEDURE `ds_b_sp_core.crm_base_ingresos_opt_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, proyecto_dest STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(

"INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_rie_plt.t_b_rie_ingreso_cliente` (",
"ing_mensual_monto,",
"cliente_id,",
"metodo_desc,",
"retrospectivo_bandera,",
"fecha_informacion",
   " )",
" SELECT",
" ing_mensual,",
 "cast(sic as int64)sic,",
  "metodo,",
  "retrospectivo,",
  "fecha_informacion,",
  "FROM ", PROJECT_ID_BRC, ".`ds_b_rie_brc.crm_base_ingresos_opt`",
  "WHERE fecha_informacion BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
   );
END;
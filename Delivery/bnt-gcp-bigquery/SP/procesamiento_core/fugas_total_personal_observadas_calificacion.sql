CREATE OR REPLACE PROCEDURE `ds_b_sp_core.fugas_total_personal_observadas_calificacion`(val_first_day DATE, val_last_day DATE, PROJECT_ID_PLT STRING, PROJECT_ID_ORO STRING)
OPTIONS (strict_mode=false)
BEGIN
  EXECUTE IMMEDIATE CONCAT(
    "INSERT INTO ",PROJECT_ID_ORO, ".`.ds_oro_generico.t_b_ant_fugas_total_personal_observadas` (",
    "cliente_id,",
    "objetivo,",
    "fecha_abandono,",
    "prediccion_umbral,",
    "fecha_informacion ",
    ") ",
    "SELECT ",
    "b.cliente_id,",
    "a.objetivo,",
    "a.fecha_abandono,",
    "b.prediccion_umbral,",
    "b.fecha_informacion ",
    "FROM (( ",
    "SELECT ",
    "* ",
    "FROM ", PROJECT_ID_PLT, ".`ds_b_ant_plt.t_b_ant_fugas_total_personal_observadas` ",
    "WHERE fecha_abandono BETWEEN '",val_first_day, "' AND ", "'", val_last_day, "' ) a ",
    "RIGHT JOIN ( ",
    "SELECT ",
    "* ",
    "FROM ",PROJECT_ID_ORO,".`ds_b_ant_oro.t_b_ant_calif_abandono_total_hist_vxx` ",
    "WHERE fecha_informacion BETWEEN '",val_first_day,"' AND ", "LAST_DAY('",val_first_day,"')) b ",
    "ON a.cliente_id=b.cliente_id and a.fecha_informacion=b.fecha_informacion) "
  );
  END;
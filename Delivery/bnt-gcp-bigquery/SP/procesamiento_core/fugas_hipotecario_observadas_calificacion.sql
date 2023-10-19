CREATE OR REPLACE PROCEDURE `ds_b_sp_core.fugas_hipotecario_observadas_calificacion`(val_first_day DATE, val_last_day DATE, PROJECT_ID_PLT STRING, PROJECT_ID_ORO STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(

"INSERT INTO " ,PROJECT_ID_ORO, ".`ds_oro_generico.t_b_ant_fugas_hipotecario_observadas` ( ",
      "cliente_id,",
      "credito,",
      "fuga_bandera,",
      "fecha_informacion,",
      "credito_numero,",
      "calificacion_cliente_id,",
      "obs,",
      "prediccion_umbral",
     " )",
  " SELECT",
  " a.cliente_id,",
    "a.credito,",
    "a.fuga_bandera,",
    "a.fecha_informacion,",
    "b.credito_numero,",
    "b.cliente_id AS calificacion_cliente_id,",
    "b.obs,",
    "b.prediccion_umbral ",
  " FROM ",
     " ( ",
    " SELECT ",
     " * ",
    "FROM ", PROJECT_ID_PLT, ".`ds_b_ant_plt.t_b_ant_fugas_hipotecario_observadas` ",
    " WHERE fecha_informacion BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'",
    " ) a ",
  " RIGHT JOIN ",
      " ( ",
    "SELECT ",
     " * ",
    "FROM ", PROJECT_ID_ORO, ".`.ds_b_ant_oro.t_b_ant_calif_abandono_hip_hist_vxx` ",
    "WHERE obs BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'",
    ") b",
  " ON a.credito=b.credito_numero and a.cliente_id=b.cliente_id "
);
END;
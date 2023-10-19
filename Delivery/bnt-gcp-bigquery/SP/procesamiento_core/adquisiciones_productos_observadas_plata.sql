CREATE OR REPLACE PROCEDURE `ds_b_sp_core.adquisiciones_productos_observadas_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(

"INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_ant_plt.t_b_ant_adquisiciones_productos_observadas` (",
  "cliente_id,",
  "producto_tipo,",
  "num_caso,",
  "fecha_informacion,",
  "primer_valor_decreto,",
  "decreto_desc,",
  "max_nun_credito,",
  "num_credito,",
  "grupo_tipo",
  " )",
   " SELECT",
   " CAST(sic AS INT64),",
  "producto,",
  "num_caso,",
  "fecha_captura,",
  "first_value_decreto,",
  "decreto,",
  "max_nun_credito,",
  "num_credito,",
  "grupo,",
  "FROM ", PROJECT_ID_BRC, ".`ds_b_ant_brc.adquisiciones_productos_observadas`",
  "WHERE fecha_captura BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
  );
END;
CREATE OR REPLACE PROCEDURE `ds_b_sp_core.codigos_postales_mexico_ii_plata`(PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
  EXECUTE IMMEDIATE CONCAT (
    "TRUNCATE TABLE `",PROJECT_ID_PLT,".ds_b_ant_plt.t_b_ant_codigos_postales`"
  );
  EXECUTE IMMEDIATE CONCAT(
    "INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_ant_plt.t_b_ant_codigos_postales` (",
    "d_codigo_id,",
    "codpos_long_numero,",
    "codpos_lat_numero ",
    ")",
    "SELECT ",
    "d_codigo,",
    "codpos_long,",
    "codpos_lat ",
    "FROM ", PROJECT_ID_BRC, ".`ds_b_ant_brc.codigos_postales_mexico_ii`"
  );
  END;
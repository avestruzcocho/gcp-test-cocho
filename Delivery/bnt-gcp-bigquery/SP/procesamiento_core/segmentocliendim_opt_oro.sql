CREATE OR REPLACE PROCEDURE `ds_b_sp_core.segmentocliendim_opt_oro`(PROJECT_ID_PLT STRING, PROJECT_ID_ORO STRING)
OPTIONS (strict_mode=false)
BEGIN
  EXECUTE IMMEDIATE CONCAT(
    "TRUNCATE TABLE `",proyecto_dest,".ds_b_dwh_cat_oro.t_b_dwh_cat_segmentos` "
  );
  EXECUTE IMMEDIATE CONCAT(
    "INSERT INTO ",PROJECT_ID_ORO, ".`ds_b_dwh_cat_oro.t_b_dwh_cat_segmentos` ( ",
    "pdimsegmento_numero,",
    "bancagrup_tipo,",
    "segmentogrupclav_numero,",
    "segmentogrupdes_desc,",
    "segmentoclav_numero,",
    "segmentodes_desc,",
    "segmentodesalt_desc,",
    "segmentoclavalt_desc,",
    "subsegmento_numero ",
    ") ",
    "SELECT ",
    "pdimsegmento_numero,",
    "bancagrup_tipo,",
    "segmentogrupclav_numero,",
    "segmentogrupdes_desc,",
    "segmentoclav_numero,",
    "segmentodes_desc,",
    "segmentodesalt_desc,",
    "segmentoclavalt_desc,",
    "subsegmento_numero ",
    "FROM ", PROJECT_ID_PLT, ".`ds_b_dwh_cat_plt.t_b_dwh_cat_segmentos` "
  );
  END;
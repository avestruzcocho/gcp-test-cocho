CREATE OR REPLACE PROCEDURE `ds_b_sp_core.segmentocliendim_opt_plata`(PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
  EXECUTE IMMEDIATE CONCAT(
    "INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_dwh_cat_plt.t_b_dwh_cat_segmentos` (",
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
    "pdimsegmento,",
    "bancagrup,",
    "segmentogrupclav,",
    "segmentogrupdes,",
    "segmentoclav,",
    "segmentodes,",
    "segmentodesalt,",
    "segmentoclavalt,",
    "subsegmento ",
    "FROM ", PROJECT_ID_BRC, ".`ds_b_dwh_cat_brc.segmentocliendim_opt`"
  );
  END;
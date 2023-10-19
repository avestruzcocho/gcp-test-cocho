CREATE OR REPLACE PROCEDURE `ds_b_sp_core.altclientedim_opt_oro`(PROJECT_ID_PLT STRING, proyecto_dest STRING)
OPTIONS (strict_mode=false)
BEGIN
EXECUTE IMMEDIATE CONCAT(
  "TRUNCATE TABLE `",PROJECT_ID_ORO,".ds_b_dwh_cli_oro.t_b_dwh_cli_datos_basicos`"
  );

EXECUTE IMMEDIATE CONCAT(
"INSERT INTO ",PROJECT_ID_ORO, ".`ds_b_dwh_cli_oro.t_b_dwh_cli_datos_basicos` (",
    "numerocif_id,",
    "pdimcliente_id,",
    "tipoperclav_id,",
    "aniosresdom_desc,",
    "sexo_tipo,",
    "estadociv_tipo,",
    "nivelestclav_numero,",
    "estadoclav_id,",
    "ocupacionpmclav_id,",
    "ocupacionpfclav_id,",
    "codigopos_id",
    ")",
  "SELECT ",
   " numerocif_id,",
   "pdimcliente_id,",
   "tipoperclav_id,",
   "aniosresdom_desc,",
   "sexo_tipo,",
   "estadociv_tipo,",
   "nivelestclav_numero,",
   "estadoclav_id,",
   "ocupacionpmclav_id,",
   "ocupacionpfclav_id,",
   "codigopos_id ",
   "FROM ", PROJECT_ID_PLT, ".`ds_b_dwh_cli_plt.t_b_dwh_cli_datos_basicos`"
  );
  END;
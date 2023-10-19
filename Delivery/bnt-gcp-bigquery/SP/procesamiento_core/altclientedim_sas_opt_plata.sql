CREATE OR REPLACE PROCEDURE `ds_b_sp_core.altclientedim_sas_opt_plata`(val_first_day DATE, val_last_day DATE, PROJECT_ID_BRC STRING, PROJECT_ID_PLT STRING)
OPTIONS (strict_mode=false)
BEGIN
  EXECUTE IMMEDIATE CONCAT(
    "INSERT INTO ",PROJECT_ID_PLT, ".`ds_b_cli_plt.t_b_cli_datos_complementarios` (",
    "cliente_id,",
    "alta_fecha,",
    "persona_tipo,",
    "nac_fecha,",
    "estudios_desc,",
    "cp_id,",
    "tel1_numero,",
    "e_mail_id,",
    "reus_bandera,",
    "fecha_informacion ",
    ") ",
    "SELECT ",
    "cast(num_clie as int64) num_clie,",
    "fecha_alta,",
    "tipo_persona,",
    "fecha_nac,",
    "estudios,",
    "cp,",
    "tel1,",
    "e_mail,",
    "reus,",
    "fecha_informacion ",
    "FROM ", PROJECT_ID_BRC, ".`ds_b_cli_brc.altclientedim_sas_opt` ",
    "WHERE fecha_informacion BETWEEN '",val_first_day, "' AND ", "'",val_last_day, "'"
  );
  END;
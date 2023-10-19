CREATE OR REPLACE PROCEDURE `bnt-lakehouse-oro-pro.ds_b_ant_oro.sp_bq_abandono_total_calc`(BMONTH DATE, PROJECT_ID_PLT STRING)
BEGIN

---------------------------------------------------------------   PASO 1   -------------------------------------------------------
BEGIN
DECLARE _queryString1 STRING;
SET _queryString1 = """
create or replace table `ds_paso.lgcf_at_all_pob` as
WITH
  ONE AS (
          SELECT
            clie_fusio_id,
            clie_perm_numero,
            max(fecha_informacion) as fch
          FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_fusiones`
          GROUP BY clie_fusio_id, clie_perm_numero)
          ,
  TWO AS (
          SELECT
            *,
            row_number() over(partition by clie_fusio_id ORDER BY fch DESC) AS rn_za
          FROM ONE)
          ,
  THREE AS (
            SELECT
              clie_fusio_id,
              clie_perm_numero
            FROM TWO
            WHERE rn_za = 1)
         ,
  FOUR AS (
            SELECT
              CASE WHEN clie_perm_numero IS NULL THEN cliente_id
                   ELSE clie_perm_numero
              END AS clie_final,
              fecha_informacion,
              alta_fecha
            FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_datos_complementarios` A
            LEFT JOIN THREE B
                   ON B.clie_fusio_id = A.cliente_id
            WHERE persona_tipo <> 'PM')
          ,
  AUX as (
          SELECT
            clie_final,
            max(DATE_TRUNC(fecha_informacion, MONTH)) AS fecha_obs,
            min(alta_fecha) AS min_fecha
          FROM FOUR
          GROUP BY
            clie_final
          HAVING MIN(fecha_informacion) < DATE_ADD('"""||BMONTH||"""', INTERVAL -6 MONTH)
          AND    MAX(CASE WHEN fecha_informacion = LAST_DAY('"""||BMONTH||"""') THEN 1 ELSE 0 END)
          =1 )
  SELECT
    clie_final,
    DATE('"""||BMONTH||"""') AS fecha_obs,
    min_fecha
  FROM AUX ;
""";
select _queryString1;
EXECUTE IMMEDIATE (_queryString1);
END;
---------------------------------------------------------------   PASO 2   -------------------------------------------------------
BEGIN
DECLARE _queryString2 STRING;
SET _queryString2 = """
create or replace table `ds_paso.lgcf_at_nomina` as
WITH
  ONE AS (
          SELECT
            DISTINCT clie_fusio_id,
            clie_perm_numero
          FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_fusiones`)
          ,
  TWO AS (
          SELECT
            DISTINCT clie_final,
            clie_fusio_id
          FROM `ds_paso.lgcf_at_all_pob`
          LEFT JOIN ONE ON clie_final=clie_perm_numero)
         ,
  THREE AS (
            SELECT
              cliente_id,
              MAX(fecha_informacion) M
            FROM `"""||PROJECT_ID_PLT||""".ds_b_cap_plt.t_b_cap_dispersion_nomina_m`
            WHERE fecha_informacion BETWEEN DATE_ADD('"""||BMONTH||"""', INTERVAL -9 MONTH)
              AND LAST_DAY('"""||BMONTH||"""')
            GROUP BY cliente_id)
           ,
  FOUR AS (
            SELECT
              cliente_id,
              clie_final,
              M
            FROM TWO
            INNER JOIN THREE ON cliente_id = clie_final
            UNION DISTINCT
            SELECT
              cliente_id,
              clie_final,
              M
            FROM TWO
            INNER JOIN THREE ON cliente_id = clie_fusio_id)
            ,
  FIVE AS (
            SELECT
              clie_final,
              MAX(M) max_fecha_nomina
            FROM FOUR
            GROUP BY clie_final)
SELECT
  *
FROM FIVE;
""";
select _queryString2;
EXECUTE IMMEDIATE (_queryString2);
END;
---------------------------------------------------------------   PASO 3   -------------------------------------------------------
BEGIN
DECLARE _queryString3 STRING;
SET _queryString3 = """
create or replace table `ds_paso.lgcf_at_all_productos` as
WITH
  ONE AS (
          SELECT
            DISTINCT clie_fusio_id,
            clie_perm_numero
          FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_fusiones`),
  TWO AS(
          SELECT
            DISTINCT clie_final,
            clie_fusio_id
          FROM `ds_paso.lgcf_at_all_pob`
          LEFT JOIN ONE ON clie_final=clie_perm_numero)
          ,
  THREE AS (
            SELECT
              cliente_id,
              fecha_informacion,
              SUM(CASE WHEN producto_tipo = 'BXI' THEN 1 ELSE 0 END) AS fam_bxi,
              SUM(CASE WHEN producto_tipo = 'CASABOLSA' THEN 1 ELSE 0 END) AS fam_casabolsa,
              SUM(CASE WHEN producto_tipo = 'CREDITOS APOLO' THEN 1 ELSE 0 END) AS fam_credito,
              SUM(CASE WHEN producto_tipo = 'PLAZO' THEN 1 ELSE 0 END) AS fam_plazo,
              SUM(CASE WHEN producto_tipo = 'SEGUROS' THEN 1 ELSE 0 END) AS fam_seguros,
              SUM(CASE WHEN producto_tipo = 'SOCIEDADES' THEN 1 ELSE 0 END ) AS fam_sociedades,
              SUM(CASE WHEN producto_tipo = 'TARJETA DE CREDITO' THEN 1 ELSE 0 END) AS fam_tdc,
              SUM(CASE WHEN producto_tipo = 'VISTA' THEN 1 ELSE 0 END) AS fam_vista,
              SUM(CASE WHEN nom_subp_nombre LIKE '%NOMINA%' AND nom_subp_nombre NOT LIKE '%CRE%' THEN 1 ELSE 0 END) AS fam_nomina
            FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_productos`
            WHERE estatus_tipo NOT IN ('VENCIDO', 'LIQUIDADO', 'CANCELADA')
            AND fecha_informacion BETWEEN DATE_ADD('"""||BMONTH||"""', INTERVAL -5 MONTH) AND LAST_DAY('"""||BMONTH||"""')
            GROUP BY cliente_id, fecha_informacion)
            ,
  FOUR AS(
          SELECT
            clie_final,
            fecha_informacion,
            fam_bxi,
            fam_casabolsa,
            fam_credito,
            fam_plazo,
            fam_seguros,
            fam_sociedades,
            fam_tdc,
            fam_vista,
            fam_nomina,
            (fam_casabolsa + fam_credito + fam_plazo + fam_seguros + fam_sociedades + fam_tdc + fam_vista) AS N_productos
          FROM THREE
          INNER JOIN two ON cliente_id = clie_final
          UNION DISTINCT
          SELECT
            clie_final,
            fecha_informacion,
            fam_bxi,
            fam_casabolsa,
            fam_credito,
            fam_plazo,
            fam_seguros,
            fam_sociedades,
            fam_tdc,
            fam_vista,
            fam_nomina,
            (fam_casabolsa + fam_credito + fam_plazo + fam_seguros + fam_sociedades + fam_tdc + fam_vista) AS n_productos
          FROM THREE
          INNER JOIN TWO ON cliente_id = clie_fusio_id)
          ,
  FIVE AS(
          SELECT
            clie_final,
            fecha_informacion,
            SUM(fam_bxi) fam_bxi,
            SUM(fam_nomina) fam_nomina,
            SUM(fam_casabolsa) fam_casabolsa,
            SUM(fam_credito) fam_credito,
            SUM(fam_plazo) fam_plazo,
            SUM(fam_seguros) fam_seguros,
            SUM(fam_sociedades) fam_sociedades,
            SUM(fam_tdc) fam_tdc,
            SUM(fam_vista) fam_vista,
            SUM(n_productos) n_productos
          FROM FOUR
          GROUP BY clie_final, fecha_informacion)
          ,
  SIX AS (
          SELECT
            clie_final,
            MAX(n_productos) max_n_productos
          FROM FIVE
          GROUP BY clie_final)
SELECT
  clie_final,
  fam_bxi,
  fam_nomina,
  fam_casabolsa,
  fam_credito,
  fam_plazo,
  fam_seguros,
  fam_sociedades,
  fam_tdc,
  fam_vista,
  n_productos,
  max_n_productos
FROM five
LEFT JOIN six USING (clie_final)
WHERE fecha_informacion = LAST_DAY('"""||BMONTH||"""');
""";
select _queryString3;
EXECUTE IMMEDIATE (_queryString3);
END;

---------------------------------------------------------------   PASO 4  -------------------------------------------------------

BEGIN
DECLARE _queryString4 STRING;
SET _queryString4 = """
create or replace table `ds_paso.lgcf_at_vista_datos` as
WITH
  zero AS (
          SELECT
            cliente_dwh_id,
            cuenta_id,
            pdimproducto_id,
            saldodisval_monto,
            DATE_TRUNC(pdimtiempo_fecha, MONTH) AS fecha,
            fechaultmov_date,
            ROW_NUMBER() OVER(PARTITION BY cliente_dwh_id, cuenta_id, pdimproducto_id, DATE_TRUNC(pdimtiempo_fecha, MONTH)
            ORDER BY pdimtiempo_fecha DESC,saldodisval_monto DESC,fechaultmov_date DESC) AS rn_za
          FROM `"""||PROJECT_ID_PLT||""".ds_b_dwh_cap_plt.t_b_dwh_cap_saldo_vista`
          WHERE pdimtiempo_fecha BETWEEN DATE_ADD('"""||BMONTH||"""', INTERVAL -9 MONTH) AND LAST_DAY('"""||BMONTH||"""'))
SELECT
  cliente_dwh_id as pdimcliente_id,
  cuenta_id,
  pdimproducto_id,
  saldodisval_monto,
  fecha,
  fechaultmov_date
FROM zero
WHERE rn_za = 1;
""";
select _queryString4;
EXECUTE IMMEDIATE (_queryString4);
END;

---------------------------------------------------------------   PASO 5  -------------------------------------------------------
BEGIN
DECLARE _queryString5 STRING;
SET _queryString5 = """
create or replace table `ds_paso.lgcf_at_vista` as
WITH
  ONE AS(
          SELECT
            DISTINCT clie_fusio_id,
            clie_perm_numero
          FROM 	`"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_fusiones`),
  TWO AS(
          SELECT
            DISTINCT clie_final,
            clie_fusio_id
          FROM `ds_paso.lgcf_at_all_pob`
          LEFT JOIN ONE ON clie_final=clie_perm_numero)
          ,
  THREE AS (
          SELECT
            pdimcliente_id,
            fecha,
            SUM(saldodisval_monto) saldo,
            MAX(fechaultmov_date) fechaultmov
          FROM `ds_paso.lgcf_at_vista_datos`
          WHERE fecha BETWEEN DATE_ADD('"""||BMONTH||"""', INTERVAL -9 MONTH) AND LAST_DAY('"""||BMONTH||"""')
          GROUP BY pdimcliente_id, fecha)
          ,
  FOUR AS (
          SELECT
            CAST (numerocif_id AS BIGINT) AS num_clie,
            fecha,
            saldo,
            fechaultmov
          FROM THREE
          LEFT JOIN `"""||PROJECT_ID_PLT||""".ds_b_dwh_cli_plt.t_b_dwh_cli_datos_basicos` USING (pdimcliente_id))
          ,
  five AS (
          SELECT
            num_clie,
            clie_final,
            fecha,
            saldo,
            fechaultmov
          FROM FOUR
          INNER JOIN TWO ON clie_final = num_clie UNION DISTINCT
          SELECT
            num_clie,
            clie_final,
            fecha,
            saldo,
            fechaultmov
          FROM FOUR
          INNER JOIN TWO ON clie_fusio_id = num_clie)
          ,
  six AS (
          SELECT
            clie_final,
            fecha,
            SUM(saldo) saldo,
            MAX(fechaultmov) fechaultmov
          FROM
            five
          GROUP BY clie_final, fecha)
          ,
  seven AS (
          SELECT
            *,
            LAG(saldo,1)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p1,
            LAG(saldo,2)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p2,
            LAG(saldo,3)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p3,
            LAG(saldo,4)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p4,
            LAG(saldo,5)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p5,
            LAG(saldo,6)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p6,
            LAG(saldo,7)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p7,
            LAG(saldo,8)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p8,
            LAG(saldo,9)OVER(PARTITION BY clie_final ORDER BY fecha) saldo_p9
          FROM six)
SELECT
  clie_final,
  fechaultmov,
  saldo,
  saldo_p1,
  saldo_p2,
  saldo_p3,
  saldo_p4,
  saldo_p5,
  saldo_p6,
  saldo_p7,
  saldo_p8,
  saldo_p9,
  CASE
    WHEN SALDO = 0 AND saldo_p1 = 0 AND saldo_p2 = 0 AND saldo_p3 = 0 AND saldo_p4 = 0 AND saldo_p5 = 0 AND saldo_p6 = 0 AND (saldo_p7 > 0 OR saldo_p8 > 0 OR saldo_p9 > 0) THEN '6 MESES CON SALDO 0'
    WHEN SALDO = 0 AND saldo_p1 = 0 AND saldo_p2 = 0 AND saldo_p3 = 0 AND saldo_p4 = 0 AND saldo_p5 = 0 AND saldo_p6 = 0 AND NOT (saldo_p7 > 0 OR saldo_p8 > 0 OR saldo_p9 > 0) THEN '9 MESES O MAS DE SALDO 0'
    WHEN SALDO = 0 AND saldo_p1 = 0 AND saldo_p2 = 0 AND saldo_p3 = 0 AND (saldo_p4 > 0 OR saldo_p5 > 0 OR saldo_p6 > 0) THEN '3 MESES CON SALDO 0'
    ELSE 'SALDO NORMAL'
  END AS VISTA_CEROS,
  CASE
    WHEN saldo < 100 AND saldo_p1 < 100 AND saldo_p2 < 100 AND (saldo_p3 > 500 OR saldo_p4 > 500 OR saldo_p5 > 500 OR saldo_p6 > 500 OR saldo_p7 > 500 OR saldo_p8 > 500 OR saldo_p9 > 500) THEN 'BAJON SALDO RECIENTE'
    WHEN SALDO < 100 AND saldo_p1 < 100 AND saldo_p2 < 100 AND saldo_p3 < 100 AND saldo_p4 < 100 AND saldo_p5 < 100 AND saldo_p6 < 100 AND (saldo_p7 > 500 OR saldo_p8 > 500 OR saldo_p9 > 500) THEN 'BAJON SALDO VIEJO'
    WHEN SALDO < 100 AND saldo_p1 < 100 AND saldo_p2 < 100 AND saldo_p3 < 100 AND saldo_p4 < 100 AND saldo_p5 < 100 AND saldo_p6 < 100 AND NOT(saldo_p7 > 500 OR saldo_p8 > 500 OR saldo_p9 > 500) THEN 'SALDO BAJO'
    WHEN SALDO < 100 AND (saldo_p1> 500 OR saldo_p2 > 500 OR saldo_p3 > 500 OR saldo_p4 > 500 OR saldo_p5 > 500 OR saldo_p6 > 500 OR saldo_p7 > 500 OR saldo_p8 > 500 OR saldo_p9 > 500) THEN 'BAJON SALDO AHORA'
    ELSE 'SALDO NORMAL'
  END AS BAJON_SALDO,
  CASE
    WHEN SALDO < 1000 AND SALDO = SALDO_P1 AND SALDO = SALDO_P2 AND SALDO=SALDO_P3 AND SALDO = SALDO_P4 AND SALDO = SALDO_P5 AND SALDO = SALDO_P6 THEN 'SALDO IGUAL 6M'
    WHEN SALDO < 1000 AND SALDO = SALDO_P1 AND SALDO = SALDO_P2 AND SALDO=SALDO_P3 THEN 'SALDO IGUAL 3M'
    ELSE 'SALDO NORMAL'
  END AS SALDO_INACTIVO
FROM
  seven
WHERE
  fecha = '"""||BMONTH||"""' ;
""";
select _queryString5;
EXECUTE IMMEDIATE (_queryString5);
END;

---------------------------------------------------------------   PASO 6  -------------------------------------------------------
BEGIN
DECLARE _queryString6 STRING;
SET _queryString6 = """
create or replace table `ds_paso.lgcf_at_creditos` as
WITH
  ONE AS (
          SELECT
            DISTINCT clie_fusio_id,
            clie_perm_numero
          FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_fusiones`),
  TWO AS(
          SELECT
            DISTINCT clie_final,
            clie_fusio_id
          FROM `ds_paso.lgcf_at_all_pob`
          LEFT JOIN ONE ON clie_final=clie_perm_numero),
  THREE AS (
          SELECT
            cliente_id,
            MAX(fecha_informacion) M
          FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_productos`
          WHERE producto_tipo = 'CREDITOS APOLO'
          AND estatus_tipo = 'VIGENTE'
          AND fecha_informacion BETWEEN DATE_ADD('"""||BMONTH||"""', INTERVAL -9 MONTH) AND LAST_DAY('"""||BMONTH||"""')
          GROUP BY cliente_id)
          ,
  FOUR AS (
          SELECT
            clie_final,
            M
          FROM THREE
          INNER JOIN TWO ON clie_final = cliente_id
          UNION DISTINCT
          SELECT
            clie_final,
            M
          FROM THREE
          INNER JOIN TWO ON clie_fusio_id = clie_final),
  FIVE AS (
          SELECT
            clie_final,
            MAX(M) MAX_FECHA_CRED
          FROM FOUR
          GROUP BY clie_final)
SELECT
  *
FROM FIVE;
""";
select _queryString6;
EXECUTE IMMEDIATE (_queryString6);
END;
---------------------------------------------------------------   PASO 7  -------------------------------------------------------
BEGIN
DECLARE _queryString7 STRING;
SET _queryString7 = """
create or replace table `ds_paso.lgcf_at_all_tdc` as
WITH
  ONE AS (
          SELECT
            ambs_acct_id,
            SUM(sdo_total_fin_monto) S
          FROM `"""||PROJECT_ID_PLT||""".ds_b_col_plt.t_b_col_tdc_mensual`
          WHERE mes_fecha BETWEEN DATE_ADD('"""||BMONTH||"""', INTERVAL -23 MONTH) AND LAST_DAY('"""||BMONTH||"""')
          GROUP BY ambs_acct_id
          HAVING SUM(sdo_total_fin_monto) > 0),
  TWO AS (
          SELECT
            ambs_acct_id,
            clasificacion1_bandera AS CLASIFICACION1_
          FROM `"""||PROJECT_ID_PLT||""".ds_b_col_plt.t_b_col_tdc_mensual`
          INNER JOIN ONE USING (ambs_acct_id)
          WHERE mes_fecha = DATE_ADD('"""||BMONTH||"""', INTERVAL -5 MONTH)),
  THREE AS (
          SELECT
          ambs_acct_id
          FROM `"""||PROJECT_ID_PLT||""".ds_b_col_plt.t_b_col_tdc_mensual` A
          INNER JOIN ONE B USING (ambs_acct_id)
          LEFT JOIN TWO C USING (ambs_acct_id)
          WHERE mes_fecha = '"""||BMONTH||"""' AND (CLASIFICACION1_ IS NULL OR CLASIFICACION1_ = 'SI')),
  FOUR AS (
          SELECT
            ambs_acct_id,
            mes_fecha,
            ambs_abierta_fecha,
            sdo_total_fin_monto,
            ambs_bloqueo_codigo_1,
            ambs_bloqueo_codigo_2
          FROM `"""||PROJECT_ID_PLT||""".ds_b_col_plt.t_b_col_tdc_mensual`
          INNER JOIN THREE
          USING (ambs_acct_id)
          WHERE mes_fecha BETWEEN DATE_ADD('"""||BMONTH||"""', INTERVAL -5 MONTH) AND '"""||BMONTH||"""'),
  FIVE AS (
          SELECT
            ambs_acct_id,
            mes_fecha,
            ambs_abierta_fecha,
            LAG(sdo_total_fin_monto,0)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) SALDO_P1,
            LAG(sdo_total_fin_monto,1)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) SALDO_P2,
            LAG(sdo_total_fin_monto,2)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) SALDO_P3,
            LAG(sdo_total_fin_monto,3)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) SALDO_P4,
            LAG(sdo_total_fin_monto,4)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) SALDO_P5,
            LAG(sdo_total_fin_monto,5)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) SALDO_P6,
            LAG(ambs_bloqueo_codigo_1,0)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) BLOCK_CODE_1_P1,
            LAG(ambs_bloqueo_codigo_1,1)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) BLOCK_CODE_1_P2,
            LAG(ambs_bloqueo_codigo_1,2)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) BLOCK_CODE_1_P3,
            LAG(ambs_bloqueo_codigo_1,3)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) BLOCK_CODE_1_P4,
            LAG(ambs_bloqueo_codigo_1,4)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) BLOCK_CODE_1_P5,
            LAG(ambs_bloqueo_codigo_1,5)OVER(PARTITION BY ambs_acct_id ORDER BY mes_fecha) BLOCK_CODE_1_P6
          FROM FOUR A),
  six AS (
          SELECT
            ambs_acct_id,
            ambs_abierta_fecha,
            CASE
              WHEN saldo_p1 = saldo_p2 AND saldo_p1 = saldo_p3 AND saldo_p1=saldo_p4 AND saldo_p1 = saldo_p5 AND saldo_p1=saldo_p6 THEN 6
              WHEN saldo_p1 = saldo_p2 AND saldo_p1 = saldo_p3 THEN 3
              ELSE 0
            END AS saldo_eq,
            CASE
              WHEN block_code_1_p1 = 'K' AND block_code_1_p6 IS NULL THEN 1
              ELSE 0
            END AS cancelada,
            CASE
              WHEN block_code_1_p1 IN ('P', 'Q', 'T') AND (block_code_1_p6 IS NULL OR block_code_1_p6 = 'R') THEN 1
              ELSE 0
            END AS CASTIGADA,
            CASE
              WHEN block_code_1_p1 = 'K' AND block_code_1_p6 = 'K' THEN 1
              ELSE 0
            END AS cancelada_antes,
            CASE
              WHEN block_code_1_p1 IN ('P', 'Q', 'T') AND (block_code_1_p6 IN ('G', 'P', 'Q', 'T')) THEN 1
              ELSE 0
            END AS castigada_antes
          FROM five
          WHERE mes_fecha = '"""||BMONTH||"""'),
  SEVEN AS (
          SELECT
            cliente_id,
            a.*
          FROM six a
          LEFT JOIN `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_productos` b
            ON CAST(ambs_acct_id AS NUMERIC) = cuenta_id AND fecha_informacion = LAST_DAY('"""||BMONTH||"""')),
  EIGHT AS (
          SELECT
            DISTINCT clie_fusio_id,
            clie_perm_numero
          FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_fusiones`),
  NINE AS(
          SELECT
            DISTINCT CLIE_FINAL,
            clie_fusio_id
          FROM `ds_paso.lgcf_at_all_pob`
          LEFT JOIN EIGHT ON CLIE_FINAL=clie_perm_numero),
  TEN AS (
          SELECT
            CLIE_FINAL,
            ambs_acct_id,
            ambs_abierta_fecha,
            SALDO_EQ,
            CANCELADA,
            CASTIGADA,
            CANCELADA_ANTES,
            CASTIGADA_ANTES
          FROM SEVEN
          INNER JOIN NINE ON cliente_id=CLIE_FINAL
          UNION DISTINCT
          SELECT
            CLIE_FINAL,
            ambs_acct_id,
            ambs_abierta_fecha,
            SALDO_EQ,
            CANCELADA,
            CASTIGADA,
            CANCELADA_ANTES,
            CASTIGADA_ANTES
          FROM SEVEN
          INNER JOIN NINE ON cliente_id=clie_fusio_id)
SELECT
  CLIE_FINAL,
  MIN(ambs_abierta_fecha) DATE_OPENED_TDC,
  MIN(SALDO_EQ) AS SALDO_EQ_TDC,
  MIN(CANCELADA) AS CANCELADA_TDC,
  MIN(CASTIGADA) AS CASTIGADA_TDC,
  MIN(CANCELADA_ANTES) AS CANCELADA_ANTES_TDC,
  MIN(CASTIGADA_ANTES) AS CASTIGADA_ANTES_TDC
FROM TEN
GROUP BY CLIE_FINAL;
""";
select _queryString7;
EXECUTE IMMEDIATE (_queryString7);
END;
---------------------------------------------------------------   PASO 8  -------------------------------------------------------

create or replace table `ds_paso.lgcf_at_all_tabla`
(
clie_final numeric,
fecha_obs date,
min_fecha date,
max_fecha_nomina date,
fam_bxi int64,
fam_nomina int64,
fam_casabolsa int64,
fam_credito int64,
fam_plazo int64,
fam_seguros int64,
fam_sociedades int64,
fam_tdc int64,
fam_vista int64,
n_productos int64,
max_n_productos int64,
fechaultmov date,
saldo float64 ,
saldo_p1 float64 ,
saldo_p2 float64 ,
saldo_p3 float64 ,
saldo_p4 float64 ,
saldo_p5 float64 ,
saldo_p6 float64 ,
saldo_p7 float64 ,
saldo_p8 float64 ,
saldo_p9 float64 ,
vista_ceros string(24),
bajon_saldo string(20),
saldo_inactivo string(14),
max_fecha_cred date,
date_opened_tdc date,
saldo_eq_tdc int64,
cancelada_tdc int64,
castigaga_tdc int64,
cancelada_antes_tdc int64,
castigada_antes_tdc int64
);


INSERT INTO `ds_paso.lgcf_at_all_tabla` (
SELECT * FROM `ds_paso.lgcf_at_all_pob`
LEFT JOIN `ds_paso.lgcf_at_nomina` USING (CLIE_FINAL)
LEFT JOIN `ds_paso.lgcf_at_all_productos` USING (CLIE_FINAL)
LEFT JOIN `ds_paso.lgcf_at_vista` USING (CLIE_FINAL)
LEFT JOIN `ds_paso.lgcf_at_creditos` USING (CLIE_FINAL)
LEFT JOIN `ds_paso.lgcf_at_all_tdc` USING (CLIE_FINAL));

BEGIN
DECLARE _queryString8 STRING;
SET _queryString8 = """
create or replace table `ds_paso.lgcf_at_all_month` as
WITH
  zero AS (
          SELECT
            cliente_id,
            MIN(nac_fecha) fecha_nac
          FROM `"""||PROJECT_ID_PLT||""".ds_b_cli_plt.t_b_cli_datos_complementarios`
          GROUP BY cliente_id)
SELECT
  clie_final,
  fecha_obs,
  ROUND(ds_b_ant_oro.fn_months_between(LAST_DAY(DATE_ADD(fecha_obs, INTERVAL -1 MONTH)), min_fecha)) antiguedad,
  ROUND(ds_b_ant_oro.fn_months_between(LAST_DAY(DATE_ADD(fecha_obs, INTERVAL -1 MONTH)), MAX_FECHA_NOMINA),0) meses_ult_dispersion,
  fam_bxi,
  fam_nomina,
  fam_casabolsa,
  fam_credito,
  fam_plazo,
  fam_seguros,
  fam_sociedades,
  fam_tdc,
  fam_vista,
  n_productos,
  max_n_productos,
  ROUND(ds_b_ant_oro.fn_months_between(LAST_DAY(DATE_ADD(FECHA_OBS, INTERVAL -1 MONTH)), fechaultmov),2) meses_ult_mov_vista,
  SALDO,
  SALDO_P1,
  SALDO_P2,
  SALDO_P3,
  SALDO_P4,
  SALDO_P5,
  SALDO_P6,
  SALDO_P7,
  SALDO_P8,
  SALDO_P9,
  VISTA_CEROS,
  BAJON_SALDO,
  SALDO_INACTIVO,
  ROUND(ds_b_ant_oro.fn_months_between(LAST_DAY(DATE_ADD(FECHA_OBS, INTERVAL -1 MONTH)), MAX_FECHA_CRED),0) months_ult_credito,
  ROUND(ds_b_ant_oro.fn_months_between(LAST_DAY(DATE_ADD(FECHA_OBS, INTERVAL -1 MONTH)), DATE_OPENED_TDC),0) antig_tdc,
  SALDO_EQ_TDC,
  CANCELADA_TDC,
  CASTIGAGA_TDC,
  CANCELADA_ANTES_TDC,
  CASTIGADA_ANTES_TDC,
  FLOOR(ds_b_ant_oro.fn_months_between(LAST_DAY(DATE_ADD(FECHA_OBS, INTERVAL -1 MONTH)), fecha_nac)) EDAD,
  FROM `ds_paso.lgcf_at_all_tabla`
  LEFT JOIN zero ON clie_final=cliente_id;
""";
select _queryString8;
EXECUTE IMMEDIATE (_queryString8);
END;

--Cargar data a tabla entrada
  TRUNCATE TABLE  `ds_b_ant_oro.t_b_ant_ins_abn_tot_vxx` ;

  INSERT INTO `ds_b_ant_oro.t_b_ant_ins_abn_tot_vxx`
  SELECT
  cast(clie_final as int64)as clie_final,
  CAST(FORMAT_DATE("%Y%m%d", fecha_obs) AS int64) as fecha_informacion,
  CAST(antiguedad as INT64)as antiguedad,
  CAST(meses_ult_dispersion as INT64) as meses_ult_dispersion,
  fam_bxi,
  fam_nomina,
  fam_casabolsa,
  fam_credito,
  fam_plazo,
  fam_seguros,
  fam_sociedades,
  fam_tdc,
  fam_vista,
  n_productos,
  max_n_productos,
  meses_ult_mov_vista,
  cast(SALDO as numeric)as SALDO,
  CAST(months_ult_credito as INT64) as months_ult_credito,
  CAST(antig_tdc as INT64) as antig_tdc,
  SALDO_EQ_TDC,
  CANCELADA_TDC,
  CASTIGAGA_TDC,
  CANCELADA_ANTES_TDC,
  CASTIGADA_ANTES_TDC,
  CAST(EDAD as INT64)as edad,
  case when vista_ceros = '3 MESES CON SALDO 0' then 1 else 0 end as vista_ceros_3_meses_con_saldo_0,
  case when vista_ceros = '6 MESES CON SALDO 0' then 1 else 0 end as vista_ceros_6_meses_con_saldo_0,
  case when vista_ceros = '9 MESES O MAS DE SALDO 0' then 1 else 0 end as vista_ceros_9_meses_o_mas_de_saldo_0,
  case when vista_ceros = 'SALDO NORMAL' then 1 else 0 end as vista_ceros_saldo_normal,
  case when bajon_saldo = 'BAJON SALDO AHORA' then 1 else 0 end as bajon_saldo_bajon_saldo_ahora,
  case when bajon_saldo = 'BAJON SALDO RECIENTE' then 1 else 0 end as bajon_saldo_bajon_saldo_reciente,
  case when bajon_saldo = 'SALDO BAJO' then 1 else 0 end as bajon_saldo_saldo_bajo,
  case when bajon_saldo = 'SALDO NORMAL' then 1 else 0 end as bajon_saldo_saldo_normal,
  case when saldo_inactivo = 'SALDO IGUAL 3M' then 1 else 0 end as saldo_inactivo_saldo_igual_3m,
  case when saldo_inactivo = 'SALDO IGUAL 6M' then 1 else 0 end as saldo_inactivo_saldo_igual_6m,
  case when saldo_inactivo = 'SALDO NORMAL' then 1 else 0 end as saldo_inactivo_saldo_normal,
  SALDO / (SALDO_P1 + 1) as saldo_r1,
  SALDO / (SALDO_P1 + SALDO_P2 + SALDO_P3  + 1) as saldo_r3,
  (SALDO + SALDO_P1 + SALDO_P2) / (SALDO_P3 + SALDO_P4 + SALDO_P5 + 1) as saldo_r36
  FROM `ds_paso.lgcf_at_all_month`;


  ---Evita duplicados tabla historica
  delete from `ds_b_ant_oro.t_b_ant_ins_abn_tot_hist`
  where PARSE_DATE('%Y%m%d', CAST(fecha_informacion AS STRING)) = BMONTH ;

  ---Guardar tabla de entrada mensual en una tabla historica
  insert into `ds_b_ant_oro.t_b_ant_ins_abn_tot_hist`    ---tabla historica
  select * from  `ds_b_ant_oro.t_b_ant_ins_abn_tot_vxx`; ---tabla de entrada para el modelo

  ----------------------------------------------------------------------------------
  -- Se aplica un Delete para evitar duplicados en la tabla de Salida Predccion ML.
  ----------------------------------------------------------------------------------
   ----Evita duplicados en tabla de calificar
  DELETE FROM `ds_b_ant_oro.t_b_ant_calif_abandono_total_hist_vxx`
  WHERE fecha_informacion = BMONTH ;

  ------
  TRUNCATE TABLE `ds_b_ant_oro.t_paso_pred_abn_total_full`;


  ---Depura tablas temporales

  DROP TABLE `ds_paso.lgcf_at_all_pob`;
  DROP TABLE `ds_paso.lgcf_at_nomina`	;
  DROP TABLE `ds_paso.lgcf_at_all_productos`;
  DROP TABLE `ds_paso.lgcf_at_vista_datos`	;
  DROP TABLE `ds_paso.lgcf_at_vista`	;
  DROP TABLE `ds_paso.lgcf_at_creditos`;
  DROP TABLE `ds_paso.lgcf_at_all_tdc`	;
  DROP TABLE `ds_paso.lgcf_at_all_tabla`;

------------------
END;
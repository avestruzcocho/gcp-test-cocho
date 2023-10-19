#!/bin/bash

project_temp=$(export project_id='bnt-lakehouse-gob-pro')

#1 codigos_postales_mexico_ii
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_ant_brc/tables/codigos_postales_mexico_ii' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cod_post_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cod_post_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cod_post_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#2 insumos_abandono_hipoteca_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_ant_brc/tables/insumos_abandono_hipoteca_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_ins_hipo_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_ins_hipo_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_ins_hipo_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#3 modelin
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_ant_brc/tables/modelin' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_modelin_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_modelin_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_modelin_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#4 altclienterelcuen_sas_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_cli_brc/tables/altclienterelcuen_sas_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclienterelcuen_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclienterelcuen_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclienterelcuen_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#5 altclientedim_sas_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_cli_brc/tables/altclientedim_sas_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclientedim_sas_opt_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclientedim_sas_opt_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclientedim_sas_opt_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#6 segmentos_clientes_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_cli_brc/tables/segmentos_clientes_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_seg_clien_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_seg_clien_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_seg_clien_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#7 altamira_fusiones_fin_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_cli_brc/tables/altamira_fusiones_fin_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_alt_fusi_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_alt_fusi_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_alt_fusi_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#8 altclientedim_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_dwh_cli_brc/tables/altclientedim_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclientedim_opt_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclientedim_opt_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_altclientedim_opt_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#9 segmentocliendim_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_dwh_cat_brc/tables/segmentocliendim_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_segmento_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_segmento_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_segmento_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#10 perf_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_col_brc/tables/perf_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_perf_opt_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_perf_opt_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_perf_opt_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#11 altchequesfact_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_dwh_cap_brc/tables/altchequesfact_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cheques_fact_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cheques_fact_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cheques_fact_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#12 crm_base_ingresos_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_rie_brc/tables/crm_base_ingresos_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_crm_base_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_crm_base_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_crm_base_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#13 ctasactnom_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-brc-pro/datasets/ds_b_cap_brc/tables/ctasactnom_opt' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cta_opt_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cta_opt_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_cta_opt_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}
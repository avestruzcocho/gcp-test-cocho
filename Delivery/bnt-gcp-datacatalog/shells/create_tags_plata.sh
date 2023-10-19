#!/bin/bash

project_temp=$(export project_id='bnt-lakehouse-gob-pro')

#1 codigos_postales_mexico_ii
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_ant_plt/tables/t_b_ant_codigos_postales' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_cod_post_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_cod_post_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_cod_post_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#2 insumos_abandono_hipoteca_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_ant_plt/tables/t_b_ant_ins_abn_hip_hist_vxx' --format="value(name)")


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_hip_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_hip_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_hip_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#3 modelin
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_ant_plt/tables/t_b_ant_modelin' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_modelin_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_modelin_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_modelin_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#4 altclienterelcuen_sas_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_cli_plt/tables/t_b_cli_productos' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_prod_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_prod_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_prod_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#5 altclientedim_sas_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_cli_plt/tables/t_b_cli_datos_complementarios' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_dat_comp_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_dat_comp_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_dat_comp_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#6 segmentos_clientes_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_cli_plt/tables/t_b_cli_segmentos' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_segm_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_segm_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_segm_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#7 altamira_fusiones_fin_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_cli_plt/tables/t_b_cli_fusiones' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_fusi_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_fusi_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cli_fusi_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#8 altclientedim_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_dwh_cli_plt/tables/t_b_dwh_cli_datos_basicos' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cli_dat_bas_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cli_dat_bas_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cli_dat_bas_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#9 segmentocliendim_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_dwh_cat_plt/tables/t_b_dwh_cat_segmentos' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cat_seg_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cat_seg_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cat_seg_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#10 perf_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_col_plt/tables/t_b_col_tdc_mensual' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_col_tdc_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_col_tdc_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_col_tdc_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}



#11 altchequesfact_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_dwh_cap_plt/tables/t_b_dwh_cap_saldo_vista' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cap_saldo_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cap_saldo_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cap_saldo_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#12 crm_base_ingresos_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_rie_plt/tables/t_b_rie_ingreso_cliente' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_rie_ingreso_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_rie_ingreso_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_rie_ingreso_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#13 ctasactnom_opt
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-plt-pro/datasets/ds_b_cap_plt/tables/t_b_cap_dispersion_nomina_m' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cap_disp_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cap_disp_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_cap_disp_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

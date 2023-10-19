#!/bin/bash

project_temp=$(export project_id='bnt-lakehouse-gob-pro')

#1 t_b_dwh_cli_datos_basicos
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_dwh_cli_oro/tables/t_b_dwh_cli_datos_basicos' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cli_dat_bas_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cli_dat_bas_oro_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cli_dat_bas_oro_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#2 t_b_dwh_cat_segmentos
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_dwh_cat_oro/tables/t_b_dwh_cat_segmentos' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cat_seg_oro_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cat_seg_oro_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cat_seg_oro_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#3 t_b_dwh_cap_saldo_vista
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_dwh_cap_oro/tables/t_b_dwh_cap_saldo_vista' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cap_saldo_oro_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cap_saldo_oro_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_dwh_cap_saldo_oro_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#4  t_b_ant_calif_prop_prod_vxx
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_calif_prop_prod_vxx' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_prop_prod_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_prop_prod_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_prop_prod_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#5  t_b_ant_calif_prop_prod_hist_vxx
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_calif_prop_prod_hist_vxx' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_prop_prod_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_prop_prod_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_prop_prod_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#6 t_b_ant_calif_abandono_hip_vxx
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_calif_abandono_hip_vxx' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_hip_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_hip_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_hip_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#7 t_b_ant_calif_abandono_hip_hist_vxx
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_calif_abandono_hip_hist_vxx' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_hip_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_hip_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_hip_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#8 t_b_ant_calif_abandono_total_vxx
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_calif_abandono_total_vxx' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_total_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_tot_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_total_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#9 t_b_ant_calif_abandono_total_hist_vxx
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_calif_abandono_total_hist_vxx' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_tot_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_tot_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_calif_abandono_tot_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#10 t_b_ant_ins_prop_prod_vxx
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_ins_prop_prod_vxx' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_prop_prod_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_prop_prod_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_prop_prod_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#11 t_b_ant_ins_abn_hip_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_ins_abn_hip_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_hip_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_hip_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_hip_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#12 t_b_ant_ins_abn_tot_vxx
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_ins_abn_tot_vxx' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_tot_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_tot_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_tot_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#13 t_b_ant_ins_prop_prod_hist

ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_ins_prop_prod_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_prop_prod_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_prop_prod_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_prop_prod_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#14 t_b_ant_ins_abn_tot_hist

ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_ins_abn_tot_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_tot_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_tot_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_ins_abn_tot_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}


#15 t_b_ant_metricas_prop_prod_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_metricas_prop_prod_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_prop_prod_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_prop_prod_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_prop_prod_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#16 t_b_ant_metricas_abandono_hipo_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_metricas_abandono_hipo_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_abandono_hipo_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_abandono_hipo_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_abandono_hipo_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#17 t_b_ant_metricas_abandono_total_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_metricas_abandono_total_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_aband_tot_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_aband_tot_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_met_aband_tot_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#18 t_b_ant_importancia_caracteristicas_propension_prod_tdc_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_importancia_caracteristicas_propension_prod_tdc_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_tdc_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_tdc_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_tdc_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#19 t_b_ant_importancia_caracteristicas_propension_prod_hipo_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_importancia_caracteristicas_propension_prod_hipo_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_hipo_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_hipo_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_hipo_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#20 t_b_ant_importancia_caracteristicas_propension_prod_fondos_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_importancia_caracteristicas_propension_prod_fondos_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_fon_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_fon_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_fon_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#21 t_b_ant_importancia_caracteristicas_propension_prod_cn_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_importancia_caracteristicas_propension_prod_cn_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_cn_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_cn_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_cn_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

#22 t_b_ant_importancia_caracteristicas_propension_prod_auto_hist
ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/bnt-lakehouse-oro-pro/datasets/ds_b_ant_oro/tables/t_b_ant_importancia_caracteristicas_propension_prod_auto_hist' --format="value(name)")

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_calidad_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_auto_hist_cd.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plantilla_figuras_gobierno \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_auto_hist_fg.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}

gcloud data-catalog tags create --entry=${ENTRY_NAME} \
--tag-template=plt_administracion_datos \
--tag-file=/home/a3989615/mvp/at0624-lakehouse-dev/at0624-lakehouse-core/bnt-gcp-datacatalog/jsons/tag_t_b_ant_imp_auto_hist_ad.json \
--tag-template-location=us-central1 \
--tag-template-project=${project_temp}
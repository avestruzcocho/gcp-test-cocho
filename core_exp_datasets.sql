#bnt-lakehouse-core-prod

CREATE SCHEMA `bnt-lakehouse-core-prod.bitacora`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');

CREATE SCHEMA `bnt-lakehouse-core-prod.ds_b_sp_core`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');


CREATE SCHEMA `bnt-lakehouse-core-prod.ds_bitacora`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');

CREATE SCHEMA `bnt-lakehouse-core-prod.ds_metricas`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');

CREATE SCHEMA `bnt-lakehouse-core-prod.fugas_pruebas`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');


#bnt-lakehouse-core-pro

CREATE SCHEMA `bnt-lakehouse-core-pro.bitacora`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');

CREATE SCHEMA `bnt-lakehouse-core-pro.ds_b_sp_core`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');


CREATE SCHEMA `bnt-lakehouse-core-pro.ds_bitacora`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');

CREATE SCHEMA `bnt-lakehouse-core-pro.ds_metricas`
  OPTIONS (
    description = 'DESCRIPTION',
    labels = [('ambiente','produccion')],
    location = 'us');


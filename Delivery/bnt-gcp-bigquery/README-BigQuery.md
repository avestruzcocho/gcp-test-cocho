# MVP Personalización BigQuery
Script que permitirá generación de todos los objetos de base de datos tanto en los 3 proyectos de negocio (Bronce, Plata y Oro), así como en el proyecto de control interno de bitácora de ejecuciones (Core). Los objetos de base de datos que se generarán son del tipo:
   1) Datasets
   2) Tablas
   3) Store Procedures

Nota. Este script contempla generación de estructuras y objetos vacíos, por lo que no se contará hasta este punto con información sensible o de corte productivo.

### 1. Iniciar sesion en google Cloud y activar el Cloud Shell de la consola
Ingresar a la consola de Google Cloud Platform en la ruta https://console.cloud.google.com/ utilizando las credenciales correspondientes.

![img_1.png](../imagenes/cloud_shell_url.png)

Dar click en el boton `Activate Cloud Shell` (Ubicado en la parte superior derecha)

![img_1.png](../imagenes/cloud_shell_icon.png)

Se abrirá una terminal en la parte inferior como se muestra en la imagen.

![img.png](../imagenes/cloud_shell_win.png)

### 2. Pre-requisitos para la instalación
Se requiere tener la siguiente información:

- Haber realizado los pasos como se describe en el **README-Global.md**, que se encuentra ubicado en el repo: https://lnxocpgit1.dev.ocp.banorte.com:5443/desarrollo-y-pruebas/banco-servicios-de-informaci-n/at00624-dataflow/at0624-lakehouse, y se muestra en la siguiente imagen:

![img.png](../imagenes/readme_global.png)

Para la ejecución de comandos se debe estar dentro de la terminal.

- Antes de comenzar
   - Selecciona un proyecto.
   - Asegúrate de que la API de BigQuery esté habilitada.

### 3. Habilitar API de Bigquery

Con el siguiente comando se habilita el servicio: 
```bash
gcloud services enable bigquery.googleapis.com
```

### 4. Entrar a la carpeta del repositorio: *DLL_PRO*
```bash
cd bnt-gcp-bigquery/DLL_PRO
```

### 5. Creación de Datasets en BigQuery para los diferentes proyectos
 
#### 5.1 Creación de Datasets para el proyecto: `bnt-lakehouse-core-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-core-pro 

bq query --use_legacy_sql=false < core_exp_datasets.sql
```
#### 5.2 Creación de Datasets para el proyecto: `bnt-lakehouse-brc-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-brc-pro 

bq query --use_legacy_sql=false < brc_exp_datasets.sql
```
#### 5.3 Creación de Datasets para el proyecto: `bnt-lakehouse-plt-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-plt-pro 

bq query --use_legacy_sql=false < plt_exp_datasets.sql

```
#### 5.4 Creación de Datasets para el proyecto: `bnt-lakehouse-oro-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-oro-pro 

bq query --use_legacy_sql=false < oro_exp_datasets.sql
```

### 6. Creación de tablas en BigQuery para los diferentes proyectos

#### 6.1 Creación de tablas para el proyecto: `bnt-lakehouse-core-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-core-pro 

bq query --use_legacy_sql=false < core_exp_tables.sql
```
#### 6.2 Creación de tablas para el proyecto: `bnt-lakehouse-brc-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-brc-pro 

bq query --use_legacy_sql=false < brc_exp_tables.sql
```
#### 6.3 Creación de tablas para el proyecto: `bnt-lakehouse-plt-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-plt-pro 

bq query --use_legacy_sql=false < plt_exp_tables.sql
```

#### 6.4 Creación de tablas para el proyecto: `bnt-lakehouse-oro-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-oro-pro 

bq query --use_legacy_sql=false < oro_exp_tables.sql
```



### 7. Creación de Procedimientos Almacenados para los diferentes proyectos

#### 7.1 Entrar a la carpeta del repositorio: *procesamiento_core*
```bash
cd bnt-gcp-bigquery/SP/procesamiento_core
```

#### 7.2 Creación de procedimientos almacenados para el proyecto: `bnt-lakehouse-core-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-core-pro 

bq query --use_legacy_sql=false < adquisiciones_productos_observadas_calificacion.sql
bq query --use_legacy_sql=false < adquisiciones_productos_observadas_plata.sql
bq query --use_legacy_sql=false < altamira_fusiones_fin_opt_plata.sql
bq query --use_legacy_sql=false < altchequesfact_opt_oro.sql
bq query --use_legacy_sql=false < altchequesfact_opt_plata.sql
bq query --use_legacy_sql=false < altclientedim_opt_oro.sql
bq query --use_legacy_sql=false < altclientedim_opt_plata.sql
bq query --use_legacy_sql=false < altclientedim_sas_opt_plata.sql
bq query --use_legacy_sql=false < altclienterelcuen_sas_opt_plata.sql
bq query --use_legacy_sql=false < codigos_postales_mexico_ii_plata.sql
bq query --use_legacy_sql=false < crm_base_ingresos_opt_plata.sql
bq query --use_legacy_sql=false < ctasactnom_opt_plata.sql
bq query --use_legacy_sql=false < fugas_hipotecario_observadas_calificacion.sql
bq query --use_legacy_sql=false < fugas_hipotecario_observadas_plata.sql
bq query --use_legacy_sql=false < fugas_total_personal_observadas_calificacion.sql
bq query --use_legacy_sql=false < fugas_total_personal_observadas_plata.sql
bq query --use_legacy_sql=false < insumos_abandono_hipoteca_hist_plata.sql
bq query --use_legacy_sql=false < modelin_plata.sql
bq query --use_legacy_sql=false < perf_opt_plata.sql
bq query --use_legacy_sql=false < segmentocliendim_opt_oro.sql
bq query --use_legacy_sql=false < segmentocliendim_opt_plata.sql
bq query --use_legacy_sql=false < segmentos_clientes_opt_plata.sql
```
#### 7.3 Entrar a la carpeta del repositorio: *pre-procesamiento_oro*
```bash
cd bnt-gcp-bigquery/SP/pre-procesamiento_oro
```
#### 7.4 Creación de procedimientos almacenados para el proyecto: `bnt-lakehouse-oro-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-oro-pro 

bq query --use_legacy_sql=false < sp_bq_abandono_hipoteca_calc.sql
bq query --use_legacy_sql=false < sp_bq_abandono_total_calc.sql
bq query --use_legacy_sql=false < sp_bq_propension_productos_calc.sql
```
### 8. Creación de Funciones Definidas por el Usuario de SQL (UDFs)

#### 8.1 Entrar a la carpeta del repositorio: *pre-procesamiento_oro*
```bash
cd bnt-gcp-bigquery/SP/pre-procesamiento_oro
```

#### 8.2 Creación de Funciones Definidas por el Usuario Servicios requeridos para proyecto: `bnt-lakehouse-oro-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-oro-pro 

bq query --use_legacy_sql=false < fn_months_between.sql
```
## Contributing

Minsait Company.




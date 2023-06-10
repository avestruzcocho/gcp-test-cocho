# MVP Personalizacion BigQuery
Readme para configurar e instalar BigQuery.

### 1.1 Iniciar sesion en google Cloud y activar el Cloud Shell de la consola
Ingresar a la consola de Google Cloud Platform en la ruta https://console.cloud.google.com/ utilizando las credenciales correspondientes.

![img_1.png](../imagenes/cloud_shell_url.png)

Dar click en el boton `Activate Cloud Shell` (Ubicado en la parte superior derecha)

![img_1.png](../imagenes/cloud_shell_icon.png)

Se abrirá una terminal en la parte inferior como se muestra en la imagen.

![img.png](../imagenes/cloud_shell_win.png)

### Pre-requisitos para la instalación
Se requiere tener la siguiente información:

1. Haber realizado la descarga del repositorio en la serie de pasos descritos en el **README.md** como se muestra en la siguiente imagen.

![img.png](../imagenes/readme_global.png)


Antes de comenzar
* Selecciona un proyecto.
* Asegúrate de que la API de BigQuery esté habilitada.

### 1.2 Habilita API Bigquery

1.Con el siguiente comando habilita el servicio: 
```bash
gcloud services enable bigquery.googleapis.com
```
## 2. Creación de Dataset BigQuery
 
### 2.1 Servicios requeridos para proyecto: `bnt-lakehouse-core-pro`
Ejecutar los siguientes comandos:
```bash
gcloud config set project bnt-lakehouse-core-pro 

bq query --use_legacy_sql=false < core_exp_datasets.sql
```
### 2.2 Servicios requeridos para proyecto: `bnt-lakehouse-brc-pro`

```bash
gcloud config set project bnt-lakehouse-brc-pro 

bq query --use_legacy_sql=false < brc_exp_datasets.sql
```
### 2.3 Servicios requeridos para proyecto: `bnt-lakehouse-plt-pro`

```bash
gcloud config set project bnt-lakehouse-plt-pro 

bq query --use_legacy_sql=false < plt_exp_datasets.sql

```
### 2.4 Servicios requeridos para proyecto: `bnt-lakehouse-oro-pro`

```bash
gcloud config set project bnt-lakehouse-oro-pro 

bq query --use_legacy_sql=false < oro_exp_datasets.sql
```

## 3. Creación de Tablas BigQuery

### 3.1 Servicios requeridos para proyecto: `bnt-lakehouse-core-pro`

```bash
gcloud config set project bnt-lakehouse-core-pro 

bq query --use_legacy_sql=false < core_exp_tables.sql
```
### 3.2 Servicios requeridos para proyecto: `bnt-lakehouse-brc-pro`

```bash
gcloud config set project bnt-lakehouse-brc-pro 

bq query --use_legacy_sql=false < brc_exp_tables.sql
```
### 3.3 Servicios requeridos para proyecto: `bnt-lakehouse-plt-pro`

```bash
gcloud config set project bnt-lakehouse-plt-pro 

bq query --use_legacy_sql=false < plt_exp_tables.sql
```

### 3.4 Servicios requeridos para proyecto: `bnt-lakehouse-oro-pro`

```bash
gcloud config set project bnt-lakehouse-oro-pro 

bq query --use_legacy_sql=false < oro_exp_tables.sql
```

## 4. Creacion de Funciones definida por el usuario (UDF)

```bash
gcloud config set project bnt-lakehouse-core-pro 

bq query --use_legacy_sql=false < fn_months_between.sql
```

## 5. Creacion de Procedimientos almacenados

### 5.1 Servicios requeridos para proyecto: `bnt-lakehouse-core-pro`

```bash
gcloud config set project bnt-lakehouse-core-pro 

bq query --use_legacy_sql=false < core_exp_sp.sql
```
### 5.2 Servicios requeridos para proyecto: `bnt-lakehouse-oro-pro`

```bash
gcloud config set project bnt-lakehouse-oro-pro 

bq query --use_legacy_sql=false < oro_exp_sp.sql
```

## Contributing

Minsait Company.




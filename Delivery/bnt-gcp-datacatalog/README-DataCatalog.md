# MVP Personalización Data Catalog
Script para la configuración de las plantillas y etiquetas de datos que serán utilizados por Gobierno de información para administrar la metadata de todas las estructuras creadas en el proyecto.

## Configuración de Data Catalog
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
   - Asegúrate de que la API de Data Catalog esté habilitada.

### 3. Habilitación de la API de Data Catalog
Con el siguiente comando habilita el servicio: 

```bash
gcloud services enable datacatalog.googleapis.com
```

### 4. Creación de Plantillas de Etiquetas
 
#### 4.1 Creación de plantillas para el proyecto: `bnt-lakehouse-gob-pro`
Ejecutar los siguientes comandos para crear las siguientes plantillas:

- **Plantilla Calidad Datos**
```bash
gcloud config set project bnt-lakehouse-gob-pro 

gcloud data-catalog tag-templates create plantilla_calidad_datos \
    --location=us-central1 \
    --display-name="plantilla calidad datos" \
    --field=id=nombre_tabla,display-name="Nombre Tabla",type=string,required=TRUE \
    --field=id=frecuencia_actualizacion,display-name="Frecuencia Actualizacion",type=string \
    --field=id=dia_carga,display-name="Dia Carga",type=string \
    --field=id=horario_max_carga,display-name="Horario Maximo Carga",type=string \
    --field=id=tipo_carga,display-name="Tipo Carga",type='enum(Incremental|Total)' \
    --field=id=politica_asociada,display-name="Politica Asociada",type=string
```
- **Plantilla Administracion Datos**

```bash
gcloud config set project bnt-lakehouse-gob-pro 

gcloud data-catalog tag-templates create plt_administracion_datos \
    --location=us-central1 \
    --display-name="Plantilla Administracion Datos" \
    --field=id=nombre_tabla,display-name="Nombre Tabla",type=string,required=TRUE \
    --field=id=fecha_creacion,display-name="Fecha Creacion",type=timestamp \
    --field=id=tipo_informacion,display-name="Tipo Informacion",type='enum(Transacciones|Saldos|Cat)' \
    --field=id=descripcion_tabla,display-name="Descripcion Tabla",type=string \
    --field=id=origen,display-name="Origen",type=string \
    --field=id=tipo_insumo,display-name="Tipo Insumo",type='enum(DataSet|Reporte|TXT)' \
    --field=id=usuario_creador,display-name="Usuario Creador",type=string 

```
- **Plantilla Figuras Gobierno**

```bash
gcloud config set project bnt-lakehouse-gob-pro 

gcloud data-catalog tag-templates create plantilla_figuras_gobierno \
    --location=us-central1 \
    --display-name="Plantilla Figuras Gobierno" \
    --field=id=nombre_tabla,display-name="Nombre Tabla",type=string,required=TRUE \
    --field=id=nombre_figura,display-name="Nombre Figura",type=string \
    --field=id=email,display-name="Email",type=string \
    --field=id=rol,display-name="Rol",type='enum(Data Stewardship|Data Owner|Data Steward|Data Custodian)'  
```
### 5. Creación de  Etiquetas 

#### 5.1 Entrar a la carpeta del repositorio
```bash
cd bnt-gcp-datacatalog/shells
```

#### 5.2 Creación de etiquetas para el proyecto: `bnt-lakehouse-brc-pro`
Ejecutar los siguientes comandos:


```bash
gcloud config set project bnt-lakehouse-gob-pro 

sh create_tags_bronce.sh
```

#### 5.3 Creación de etiquetas para el proyecto: `bnt-lakehouse-plt-pro`
Ejecutar los siguientes comandos:


```bash
gcloud config set project bnt-lakehouse-gob-pro 

sh create_tags_plata.sh
```

#### 5.4 Creación de etiquetas para el proyecto: `bnt-lakehouse-oro-pro`
Ejecutar los siguientes comandos:


```bash
gcloud config set project bnt-lakehouse-gob-pro 

sh create_tags_oro.sh
```


## Contributing

Minsait Company.

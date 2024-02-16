### 1. **Creacion de Rol personalizado:**

```bash

gcloud iam roles create custom.storageLister --project=YOUR_PROJECT_ID \
--title="Storage Lister" \
--description="Permite listar objetos en un bucket de Cloud Storage, pero no permite descargar el contenido de los objetos." \
--permissions=storage.objects.list,storage.objects.getIamPolicy

```

### 2. Luego, puedes asignar este rol a los usuarios o grupos de usuarios específicos en IAM para restringir su capacidad para descargar archivos desde el bucket de Cloud Storage. Por ejemplo:

```bash
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
--member=user:USER_EMAIL \
--role=projects/YOUR_PROJECT_ID/roles/custom.storageLister
```

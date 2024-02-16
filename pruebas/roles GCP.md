gcloud iam roles create custom.storageLister --project=YOUR_PROJECT_ID \
--title="Storage Lister" \
--description="Permite listar objetos en un bucket de Cloud Storage, pero no permite descargar el contenido de los objetos." \
--permissions=storage.objects.list,storage.objects.getIamPolicy



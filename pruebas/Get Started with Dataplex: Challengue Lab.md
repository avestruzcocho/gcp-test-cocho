# Get Started with Dataplex: Challenge Lab

```bash
gcloud services enable \
  dataplex.googleapis.com \
  datacatalog.googleapis.com
```
```bash
export REGION=us-east1
export PROJECT_ID=$(gcloud config get-value project)
gcloud config set compute/region $REGION
```

### **Task 1.Create a lake with a raw zone**

```bash
gsutil mb -c standard -l $REGION gs://$PROJECT_ID
gcloud dataplex lakes create customer-engagements \
   --location=$REGION \
   --display-name="Customer Engagements" \
   --description="Customer Engagements Domain"

gcloud dataplex zones create raw-event-data \
    --location=$REGION \
    --lake=customer-engagements \
    --display-name="Raw Event Data" \
    --resource-location-type=SINGLE_REGION \
    --type=RAW \
    --discovery-enabled \
    --discovery-schedule="0 * * * *"
```

### **Task 2.Create and attach a Cloud Storage bucket to the zone**

```bash
gcloud dataplex assets create raw-event-files \
--location=$REGION \
--lake=customer-engagements \
--zone=raw-event-data \
--display-name="Raw Event Files" \
--resource-type=STORAGE_BUCKET \
--resource-name=projects/$PROJECT_ID/buckets/$PROJECT_ID \
--discovery-enabled 
```
### **Task 3.Create and apply a tag template to a zone**

```bash
gcloud data-catalog tag-templates create protected_raw_data_template2 --field=id=protected_raw_data_flag,display-name=protected_raw_data_flag,type='enum(Y|N)' --location="us-east1"
```

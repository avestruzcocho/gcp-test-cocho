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

```

### **Task 2.Create and attach a Cloud Storage bucket to the zone**

```bash
t2
```
### **Task 3.Create and apply a tag template to a zone**

```bash
t3
```

### **Task 1. Create VPC Networks with Firewall Rules**

```bash
gcloud compute networks create managementnet --project=qwiklabs-gcp-04-10e0bfc4aa8f --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional --bgp-best-path-selection-mode=legacy
```
```bash
gcloud compute networks subnets create managementsubnet-1 --project=qwiklabs-gcp-04-10e0bfc4aa8f --description=subred --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=managementnet --region=us-west1
```
#### Create the privatenet network 

```bash
gcloud compute networks create privatenet --subnet-mode=custom

gcloud compute networks subnets create privatesubnet-1 --network=privatenet --region=us-west1 --range=172.16.0.0/24

gcloud compute networks subnets create privatesubnet-2 --network=privatenet --region=europe-west1 --range=172.20.0.0/20

gcloud compute --project=qwiklabs-gcp-04-10e0bfc4aa8f firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0
```


### **Task 2. Create VM Instances**

```bash
gcloud compute instances create managementnet-vm-1 --project=qwiklabs-gcp-04-10e0bfc4aa8f --zone=us-west1-a --machine-type=e2-micro --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=managementsubnet-1 --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=523646755633-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=managementnet-vm-1,image=projects/debian-cloud/global/images/debian-12-bookworm-v20241009,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

gcloud compute instances create privatenet-vm-1 --zone=us-west1-a --machine-type=e2-micro --subnet=privatesubnet-1

```

### **Task 3. Explore the connectivity between VM instances**
```bash
 ping -c 3 'Enter mynet-vm-2 external IP here'
 ping -c 3 'Enter managementnet-vm-1 external IP here'
 ping -c 3 'Enter privatenet-vm-1 external IP here'

```
### **Task 4. Create a VM instance with multiple network interfaces**


```bash
gcloud compute instances create vm-appliance --project=qwiklabs-gcp-04-10e0bfc4aa8f --zone=us-west1-a --machine-type=e2-standard-4 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=privatesubnet-1 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=managementsubnet-1 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=mynetwork --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=523646755633-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=vm-appliance,image=projects/debian-cloud/global/images/debian-12-bookworm-v20241009,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

```







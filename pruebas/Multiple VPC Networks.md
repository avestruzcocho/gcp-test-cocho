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

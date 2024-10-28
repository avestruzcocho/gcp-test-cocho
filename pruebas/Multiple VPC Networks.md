### **VPC Networks with Firewall Rules**

```bash
gcloud compute networks create managementnet --project=qwiklabs-gcp-04-10e0bfc4aa8f --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional --bgp-best-path-selection-mode=legacy
```
```bash
gcloud compute networks subnets create managementsubnet-1 --project=qwiklabs-gcp-04-10e0bfc4aa8f --description=subred --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=managementnet --region=us-west1
```

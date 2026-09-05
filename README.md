# Terraform-Azure
Terraform Infrastructure Projects for Azure

Day 1:
I deployed my first git push and PR with terraform. I created a resource group and a .gitignore.

Day 2:
I will be creating a mock network architecture of a healthcare clinic company. Here is the network architecture I have so far. I will plan out the entire landing zone before deploying with modular terraform files. It will have a hub and spoke topology. Here is the MOP so far for Day 2. I will update it will the VM's needed for each VNET for Day 3.

![Landing Zone Overview](./topology/azure_landing_zone_overview.png)

![Method of Procedure](./topology/Mock-Cloud-Infrastructure.png)

Day 3:
The main.tf and the variables.tf for my Hub vnet were written. It includes my VNet address space of 10.0.0.0/24 which is then subnetted into an AzureFirewall subnet(10.0.0.0/26), GatewaySubnet(10.0.0.64/27), Private DNS Resolver subnet (10.0.0.96/28) and AzureBastionSubnet (10.0.0.128/26). Subsequentially I updated my root main.tf as well as created a variables.tf and dev.tfvars so keep with my modular code theme.
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

Also added contributing.md so my CI/CD process can be written down and improved upon later.

Day 4:
I added Network Security Groups (NSGs) to the Hub VNet to secure inbound and outbound traffic. This involved creating a new NSG.tf file in my Hub module and configuring specific security rules for the Azure Bastion Subnet and the Private DNS Resolver Subnet. During validation, I caught and resolved a syntax issue regarding Terraform's case-sensitivity for protocol arguments (ensuring values like Tcp and Udp were formatted correctly). Finally, I successfully pushed the code through a PR, deployed the infrastructure to Azure, and updated contributing.md with a newly refined, standardized Git/Terraform deployment workflow for future feature branches.

Day 5: Added modules/Hub/outputs.tf, exposing two values so other modules can reference the hub without duplicating resource lookups:

vnet_id — the hub VNet's resource ID, used by spoke modules for VNet peering
vnet_name — the hub VNet's name
This unblocks the shared-services (and future site-spoke) modules from establishing peering back to the hub.

    Part 2:

    Added the variables.tf for the Shared-Services spoke VNet.


Day 6: I Deployed the Shared Services VNet. This will be for various mgmt and production related VMs such as the print servers, SSO, Clinical App servers, Disaster Recovery, etc.

Day 7:
Built out the full NSG.tf for the Shared-Services spoke, covering all six subnets: Identity, Data, Mgmt, Printer, Apps, and Disaster Recovery. Each NSG's rules were scoped to that subnet's actual role rather than a blanket allow, for example Data only accepts SQL traffic from Mgmt, Apps, and the App Gateway/Web subnets, and Mgmt only accepts RDP from the Bastion subnet.

Since several of these rules needed to reference subnets in modules that didn't exist yet (HQ, Annex, the two Clinics, the Public Website), I declared seven placeholder variables with hardcoded CIDR defaults and TODO comments, to be swapped for real cross-module outputs as those modules came online.

Also went back and fixed a recurring issue on the Hub's Private DNS Resolver subnet delegation. Terraform kept showing the same "1 to change" diff on every plan even after a successful apply, turned out Azure wasn't persisting one of the two delegation actions I'd specified. Removed it and the diff stopped reappearing.

Day 8:
Added two new spoke modules: Admin-Sites and Public-Website.

Admin-Sites is a reusable module representing an office-type site, three subnets (wired-devices, prod-wifi, guest-wifi) each with their own NSG. It's called twice from root, once for HQ and once for Annex, each with its own address space. HQ and Annex both pull their Identity and Data subnet CIDRs directly from Shared-Services' outputs rather than duplicating hardcoded values, so their NSG rules stay accurate if Shared-Services' addressing ever changes.

Public-Website has an Application Gateway subnet and a Web subnet, with NSGs enforcing that the Web subnet only accepts traffic from the App Gateway subnet, not the internet directly. The App Gateway subnet's NSG also allows the GatewayManager service tag on ports 65200-65535, which Application Gateway v2 requires for its own control plane traffic.

Wired both new modules into root main.tf and got a full plan and apply through cleanly across Hub, Shared-Services, Admin-Sites (HQ and Annex), and Public-Website.

Day 9:
Built the Clinic-Spoke module to represent the two-region clinical sites, five subnets per clinic: wired-computers (where the VDI thin clients live), wired-printers, wired-voip, prod-wifi, and guest-wifi. Called twice from root for Clinic Region 1 and Clinic Region 2, same reusable pattern as Admin-Sites.

The wired-computers NSG allows the VDI protocol (Blast Extreme, matching the VMware Horizon platform I administer at work) inbound only from the Bastion and Mgmt subnets, and allows outbound to Identity/Data for domain authentication. The printer subnet accepts print traffic from the clinic's own workstations plus Shared-Services' printer subnet, and the VoIP subnet accepts SIP/RTP from the Apps subnet where the PBX role lives.

Added three more outputs to Shared-Services (mgmt_cidr, apps_cidr, printer_cidr) so the Clinic modules could reference them the same way HQ and Annex reference Identity/Data.

Also cleaned up contributing.md, fixed a duplicated block between the deploy and commit steps, and standardized the whole workflow doc so it reads as one clean sequence from branch creation to cleanup.
# Proxmox VM cloning with Terraform

This configuration creates one or more VMs by making full clones of an existing Proxmox VM template. Each clone receives its own disks, independent of the template's disks. Keep the Terraform state and existing entries in `terraform.tfvars` so later runs add VMs without forgetting those already created.

## Prerequisites

- Terraform 1.5 or later.
- A Proxmox VM template that supports cloud-init if you want Terraform to set the hostname or IP configuration.
- A Proxmox API token available to Terraform. The `bpg/proxmox` provider expects the token ID and secret combined in `PROXMOX_VE_API_TOKEN` as `user@realm!token-name=secret`. Set it in your shell (do not commit it):

```sh
export PROXMOX_VE_API_TOKEN='terraform@pve!terraform=your-token-secret'
```

The token must have permissions to audit the node and clone, configure, and start VMs on the target node. The `bpg/proxmox` provider may also require SSH access to the Proxmox node for some operations; see the provider's [SSH setup guide](https://github.com/bpg/terraform-provider-proxmox/blob/main/docs/index.md).

## Create a VM

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and set the API endpoint, node name, and template VM ID.
2. Add the VM under `vms` with a unique map key. DHCP is the default. For a static IP, use a CIDR address and set its gateway.
3. Initialize and apply:

```sh
terraform init
terraform plan
terraform apply
```

For every later VM, add another map entry and run `terraform plan` and `terraform apply` again. Keep prior entries; removing an entry tells Terraform to destroy that VM. Terraform state is stored locally in this directory and is ignored by Git, so back it up securely and do not delete it between runs.

The VM disk, firmware, and network device are inherited from the template. Configure those settings on the template before cloning. The Proxmox VM name is set from `name`; the provider's cloud-init `initialization` block configures IP networking but does not accept a `hostname` argument. If your template does not use cloud-init, remove the `initialization` block from `main.tf` and configure guest networking in the template instead.

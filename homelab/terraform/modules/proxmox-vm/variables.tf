variable "proxmox_endpoint" {
  description = "Proxmox API endpoint, including port 8006 (for example https://pve.example:8006/)."
  type        = string
}

variable "proxmox_insecure_tls" {
  description = "Set true only when Proxmox uses a certificate Terraform cannot validate."
  type        = bool
  default     = false
}

variable "proxmox_node_name" {
  description = "Proxmox node where new VMs will be created."
  type        = string
}

variable "proxmox_template_vm_id" {
  description = "Numeric VM ID of the existing Proxmox template to clone."
  type        = number
}

variable "ssh_public_key" {
  description = "Required OpenSSH public key injected into cloned VMs through cloud-init."
  type        = string
}

variable "ssh_username" {
  description = "Required guest account name to receive ssh_public_key."
  type        = string
}

variable "vm_full_name" {
  default = ""
}

variable "vm_cpu_cores" {
  default = ""
}

variable "vm_memory_mb" {
  default = ""
}

variable "vm_ip_cidr" {
  default = ""
}

variable "vm_gateway" {
  description = "IPv4 default gateway for the VM."
  type        = string
}

variable "vm_disk_size_gb" {
  description = "Root disk size for the VM in GiB."
  type        = number
  default     = 128
}

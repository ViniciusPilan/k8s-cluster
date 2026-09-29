variable "proxmox_endpoint" {
  description = "Proxmox API endpoint, including port 8006 (for example https://pve.example:8006/)."
  type        = string
}

variable "proxmox_insecure_tls" {
  description = "Set true only when Proxmox uses a certificate Terraform cannot validate."
  type        = bool
  default     = false
}

variable "node_name" {
  description = "Proxmox node where new VMs will be created."
  type        = string
}

variable "template_vm_id" {
  description = "Numeric VM ID of the existing Proxmox template to clone."
  type        = number
}

variable "vms" {
  description = "VMs to manage. Add a new uniquely keyed entry for each VM you create."
  type = map(object({
    name       = string
    cores      = optional(number, 2)
    memory_mb  = optional(number, 2048)
    ipv4       = optional(string, "dhcp")
    gateway    = optional(string)
  }))

  validation {
    condition     = alltrue([for vm in values(var.vms) : vm.ipv4 == "dhcp" || (can(cidrhost(vm.ipv4, 0)) && can(cidrnetmask(vm.ipv4)))])
    error_message = "Each VM ipv4 must be 'dhcp' or a valid IPv4 CIDR, such as 192.168.1.50/24."
  }
}

module "controlplane01" {
    source = "../../modules/proxmox-vm"

    proxmox_endpoint       = local.proxmox_endpoint
    proxmox_node_name      = local.proxmox_node_name
    proxmox_template_vm_id = local.proxmox_template_vm_id

    ssh_public_key = local.ssh_public_key
    ssh_username   = local.ssh_username
    
    vm_full_name = "homelab-k8s-controlplane01"
    vm_cpu_cores = "2"
    vm_memory_mb = "6144"
    vm_ip_cidr   = "192.168.12.21/24"
    vm_gateway   = "192.168.12.1"
}


module "worker01" {
    source = "../../modules/proxmox-vm"

    proxmox_endpoint       = local.proxmox_endpoint
    proxmox_node_name      = local.proxmox_node_name
    proxmox_template_vm_id = local.proxmox_template_vm_id

    ssh_public_key = local.ssh_public_key
    ssh_username   = local.ssh_username
    
    vm_full_name = "homelab-k8s-worker01"
    vm_cpu_cores = "2"
    vm_memory_mb = "6144"
    vm_ip_cidr   = "192.168.12.22/24"
    vm_gateway   = "192.168.12.1"
}

locals {
    proxmox_endpoint         = "https://192.168.12.20:8006/"
    proxmox_node_name        = "heitor"
    proxmox_template_vm_id   = 9001

    ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2lNdBomYBZ40nd/HgUFpG1qFyR5h2bWZM0rk3Cz9YB Key pair used to connect via SSH the Homelab VMs."
    ssh_username   = "ubuntu"

}
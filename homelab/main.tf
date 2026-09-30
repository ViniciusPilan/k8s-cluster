resource "proxmox_virtual_environment_vm" "vm" {
  for_each = var.vms

  name      = each.value.name
  node_name = var.node_name
  started   = true

  clone {
    vm_id = var.template_vm_id
    full  = true
  }

  cpu {
    cores = each.value.cores
  }

  memory {
    dedicated = each.value.memory_mb
  }

  initialization {
    user_account {
      keys     = [var.ssh_public_key]
      username = var.ssh_username
    }

    ip_config {
      ipv4 {
        address = each.value.ipv4
        gateway = each.value.ipv4 == "dhcp" ? null : each.value.gateway
      }
    }
  }
}

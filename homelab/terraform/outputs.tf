output "vms" {
  description = "Created VM names and Proxmox-assigned IDs."
  value = {
    for key, vm in proxmox_virtual_environment_vm.vm : key => {
      name  = vm.name
      vm_id = vm.vm_id
    }
  }
}

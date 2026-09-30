output "vm" {
  description = "Created VM name"
  value = {
    name = proxmox_virtual_environment_vm.vm.name
    vm_id = proxmox_virtual_environment_vm.vm.vm_id
  }
}
output "master_ips" {
  description = "The IP addresses of the K3s Master server instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_master : regex("[0-9.]+", instance.ipconfig0)
  ])
}

output "worker_ips" {
  description = "The IP addresses of the K3s Worker server instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_worker : regex("[0-9.]+", instance.ipconfig0)
  ])
}

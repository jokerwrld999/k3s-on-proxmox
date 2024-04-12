output "server_ips" {
  description = "The IP addresses of the K3s Server instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_server : regex("[0-9.]+", instance.ipconfig0)
  ])
}

output "agent_ips" {
  description = "The IP addresses of the K3s Agent instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_agent : regex("[0-9.]+", instance.ipconfig0)
  ])
}

output "lb_ips" {
  description = "The IP addresses of the K3s LB instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_lb : regex("[0-9.]+", instance.ipconfig0)
  ])
}
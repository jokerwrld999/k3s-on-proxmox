output "server_ips" {
  description = "The IP addresses of the K3s Server instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_server_node : regex("[0-9.]+", instance.ipconfig0)
  ])
}

output "agent_ips" {
  description = "The IP addresses of the K3s Agent instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_agent_node : regex("[0-9.]+", instance.ipconfig0)
  ])
}

output "lb_ips" {
  description = "The IP addresses of the K3s LB instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_lb_node : regex("[0-9.]+", instance.ipconfig0)
  ])
}

output "rancher_ips" {
  description = "The IP addresses of the K3s Rancher instances."
  value = flatten([
    for instance in proxmox_vm_qemu.k3s_rancher_node : regex("[0-9.]+", instance.ipconfig0)
  ])
}
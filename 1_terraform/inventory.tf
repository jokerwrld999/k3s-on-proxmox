resource "local_file" "k3s_lb_node_ips" {
  filename = "../2_ansible/inventory/k3s_inventory.yml"
  content  = <<-EOF
k3s_lb_nodes:
  hosts:
  %{for ip in proxmox_vm_qemu.k3s_lb_node~}
  ${regex("[0-9.]+", ip.ipconfig0)}:
  %{endfor~}
vars:
    ansible_user: ${proxmox_vm_qemu.k3s_lb_node[0].ciuser}
k3s_server_nodes:
  hosts:
  %{for ip in proxmox_vm_qemu.k3s_server_node~}
  ${regex("[0-9.]+", ip.ipconfig0)}:
  %{endfor~}
vars:
    ansible_user: ${proxmox_vm_qemu.k3s_server_node[0].ciuser}
k3s_agent_nodes:
  hosts:
  %{for ip in proxmox_vm_qemu.k3s_agent_node~}
  ${regex("[0-9.]+", ip.ipconfig0)}:
  %{endfor~}
vars:
    ansible_user: ${proxmox_vm_qemu.k3s_agent_node[0].ciuser}
k3s_rancher_nodes:
  hosts:
  %{for ip in proxmox_vm_qemu.k3s_rancher_node~}
  ${regex("[0-9.]+", ip.ipconfig0)}:
  %{endfor~}
vars:
    ansible_user: ${proxmox_vm_qemu.k3s_rancher_node[0].ciuser}
EOF
}
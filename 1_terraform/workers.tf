resource "proxmox_vm_qemu" "k3s_worker" {
  # VM General Settings
  count       = 3
  target_node = "z640"
  vmid        = "60${count.index + 1}"
  name        = "k3s-worker-${count.index + 1}"
  desc        = "[Terrafrom] K3s Worker #${count.index + 1}"
  tags = "k3s-workers"

  # VM Advanced General Settings
  onboot   = true
  vm_state = "running"

  # VM OS Settings
  clone   = "ubuntu-cloud"
  qemu_os = "other"

  # VM System Settings
  # agent = 0

  # VM CPU Settings
  cores   = 1
  sockets = 1
  cpu     = "host"
  machine = "q35"

  # VM Memory Settings
  memory = 1024

  # VM Network Settings
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  scsihw = "virtio-scsi-single"
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 12
        }
      }
    }
  }

  # VM Cloud-Init Settings
  os_type                 = "cloud-init"
  cloudinit_cdrom_storage = "local-lvm"

  # (Optional) IP Address and Gateway
  ipconfig0  = "ip=10.10.10.6${count.index + 1}/24,gw=10.10.10.254"
  nameserver = "1.1.1.1"

  # (Optional) Default User
  ciuser = "jokerwrld"

  # (Optional) Add your SSH KEY
  sshkeys = <<-EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDytT6H5MCg3PZ55d+SmPJ5xUUKYyINFyeCst56c8wXInX895eNpNdmcaupDZRCacRQHIDRkOPj7rstolOXg8KgDc5tJ8JaGVEKGsnkY11P9JeTR7fWia7S7gwKSDQWPeTh/x5vxVFeuInErVBwPJFaebiV02MkA7OalFQ1DiHQvne4EtLYEp9/WTZdrDQw2sZfiUuh9KS9YSeWkB+TgK3mk8tmLGR7FO5WMLQbnZZu0nD7Q46i5xNQy3N5DOR1cVispfqfKZSAw1WubjqeZodknJkxWUZKjI3ebOKbYTT5fwHkOJu3jgN7kZXx6pq2cujKnseFEm0yPbSbXZVCl2I8RuvWo7hA/PdkPYzwTSbWEEeZaEfajUc1LAV4xMTYHdvsxCcMEuiZL+YxbfCWSlcg0xJpFf2hj+XiZTaRdpW9p1BYiYqcLQJYFNXV8s0YgpXDXz4oQPcXbzoJc5HZU3A3PnF1u8ElZmCyxRKxuoueb0fvFRD/mZ0cjJkJmA9e5Js=
  EOF
}

resource "local_file" "k3s_worker_nodes" {
  filename = "../2_ansible/inventory/k3s_worker_nodes"
  content = <<-EOF
    [k3s_worker_nodes]
    %{ for ip in proxmox_vm_qemu.k3s_worker ~}
    ${regex("[0-9.]+", ip.ipconfig0)}
    %{ endfor ~}
  EOF
}
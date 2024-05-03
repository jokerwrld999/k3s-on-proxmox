resource "proxmox_vm_qemu" "k3s_agent_node" {
  # VM General Settings
  count       = 3
  target_node = "z640"
  vmid        = "60${count.index + 1}"
  name        = "k3s-agent-${count.index + 1}"
  desc        = "[Terrafrom] K3s Agent #${count.index + 1}"
  tags        = "k3s-agent"

  # VM Advanced General Settings
  onboot   = true
  vm_state = "running"

  # VM OS Settings
  clone   = "ubuntu-cloud"
  qemu_os = "other"

  # VM System Settings
  # agent = 0

  # VM CPU Settings
  sockets = 1
  cores   = 2
  cpu     = "host"
  machine = "q35"

  # VM Memory Settings
  memory = 4096

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
  ciuser = "root"

  # (Optional) Add your SSH KEY
  sshkeys = <<-EOF
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJonXfGjkmIS7kLLpVKgvkPx7CKDKChFB+cnna2zWNG
  EOF
}
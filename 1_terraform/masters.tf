resource "proxmox_vm_qemu" "k3s_master" {
  # VM General Settings
  count       = 3
  target_node = "z640"
  vmid        = "50${count.index + 1}"
  name        = "k3s-master-${count.index + 1}"
  desc        = "[Terrafrom] K3s Master #${count.index + 1}"
  tags = "k3s-masters"

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
  ipconfig0  = "ip=10.10.10.5${count.index + 1}/24,gw=10.10.10.254"
  nameserver = "10.10.10.254"

  # (Optional) Default User
  ciuser = "jokerwrld"

  # (Optional) Add your SSH KEY
  sshkeys = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCz4DdmN/mKihH/76hXc6RAzb5Du0dE77PfHSOUbAcEqtstkZIhZpwJAOKo0H4yfVIRHZh8Tu83lCcNZ0ewQ+3aDgbpISSGqD0be5jazLMQCP304/iJr5Kz79scZSZc4h8vQg1gZrKyIUvbg84usYn3oai4U0eDQxgkDaRO/TS/u+wNjKSEmUkc+iytYF53jqhJApIJfDeATuO+o5AKa7ccO5LPp4RPa6XeKOX0BORxhuKS4y0i0jz2SgeXtCcQ1iLSFyaQeOL5dzxUDU5sRZf7BcQ/gVscPNCMTsT+e4in0ubdCvG9W4oeUK3RzypoFNzmby8jjbezci5XBsJm/SOg/ELjN9V4p4lxfVFQlhNkIgO0dDIvXD5CSsxE8Nhn9toc2YC6/7sPOKvQCTQOcNOKgBJR6jARQT5Ktfe3HA2yWHI4MOUOzr8d2tgKj14aPrj5kB7D6Jl7RG2kvCfmQrF82oAemguCI2qskxlX2nUDFuIjQOSs8pO/5llWQ9YJQA4M7Q2ypaPFg0DdMmwlShvjfIqAe58TRsoY/aHQ0/2NwbDiPMWl38v0lCKvk3kWNxca5/Nz9hfAEnQvQLSDqjgsXdbvaMtZWdnQf8DYmKVrXj8v/7k3B7tocEOCMA+xwH/gB8cSRHH7dAtB2CJIdIuxIj0PcBTNzJih+S5a2iH2+w==
  EOF
}
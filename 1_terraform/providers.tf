terraform {
  cloud {
    organization = "jokerwrld"

    workspaces {
      name = "k3s-homelab"
    }
  }
  required_version = ">= 0.13"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}


provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  # (Optional) Skip TLS Verification
  pm_tls_insecure = true

}
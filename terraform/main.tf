# https://registry.terraform.io/providers/bpg/proxmox/0.61.1/docs
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.61.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_host
  username = var.proxmox_user
  password = var.proxmox_password
  insecure = true
}

# https://registry.terraform.io/providers/bpg/proxmox/0.61.1/docs/resources/virtual_environment_vm
resource "proxmox_virtual_environment_vm" "kwc_k8s_nodes" {
  for_each    = { for node in var.kube_nodes : node.vm_name => node }
  name        = each.value.vm_name
  description = "Managed by Terraform"

  node_name = var.proxmox_node_name
  vm_id     = each.value.vm_id
  on_boot   = true
  started   = true
  clone {
    full      = true
    vm_id     = var.kubernetes_clone_image.id
    node_name = var.proxmox_node_name
  }

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = true
    type    = "virtio"
  }
  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  bios            = "seabios"
  cpu {
    architecture = "x86_64"
    cores        = each.value.cores
    sockets      = 1
  }

  memory {
    dedicated = each.value.memory
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  disk {
    datastore_id = "kwc-ceph"
    size         = each.value.disk_size
    interface    = "scsi0"
    backup = true
    ssd = false
    iothread = true
    discard = "on"
  }

vga {
  memory = 16
  type = "serial0"
}

  initialization {
    datastore_id = "kwc-ceph"

    ip_config {
      ipv4 {
        address = each.value.network_address
      }
      ipv6 {
        address = "dhcp"
      }
    }

    user_account {
      keys = [
        var.owner_ssh_key
      ]
      password = var.vm_default_root_password
      username = "ubuntu"
    }
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
    mtu    = 1
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "proxmox_virtual_environment_vm" "kwc_nodes" {
  for_each    = { for node in var.vm_nodes : node.vm_name => node }
  name        = each.value.vm_name
  description = "Managed by Terraform"

  node_name = var.proxmox_node_name
  vm_id     = each.value.vm_id
  on_boot   = true
  started   = true
  clone {
    full      = true
    vm_id     = var.ubuntu_clone_image.id
    node_name = var.proxmox_node_name
  }

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = true
    type    = "virtio"
  }
  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true
  bios            = "seabios"
  cpu {
    architecture = "x86_64"
    cores        = each.value.cores
    sockets      = 1
  }

  memory {
    dedicated = each.value.memory
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  disk {
    datastore_id = "kwc-ceph"
    size         = each.value.disk_size
    interface    = "scsi0"
    backup = true
    ssd = false
    discard = "on"
    iothread = false
  }

vga {
  memory = 16
  type = "serial0"
}

  initialization {
    datastore_id = "kwc-ceph"

    ip_config {
      ipv4 {
        address = each.value.network_address
      }
      ipv6 {
        address = "dhcp"
      }
    }

    user_account {
      keys = [
        var.owner_ssh_key
      ]
      password = var.vm_default_root_password
      username = "ubuntu"
    }
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
    mtu    = 1
  }
  lifecycle {
    create_before_destroy = true
  }
}
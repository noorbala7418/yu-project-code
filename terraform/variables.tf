variable "ubuntu_clone_image" {
  type = object({
    name = string
    id   = number
  })
  default = {
    id   = 900
    name = "ubuntu-22-template"
  }
}

variable "kubernetes_clone_image" {
  type = object({
    name = string
    id   = number
  })
  default = {
    id   = 901
    name = "k8s-ubuntu-template"
  }
}

variable "proxmox_password" {
  type      = string
  sensitive = true
  default   = "PROXMOX_PASSWORD"
}

variable "proxmox_user" {
  type    = string
  default = "PROXMOX_USER" # like terraform@pve
}

variable "proxmox_host" {
  type    = string
  default = "PROXMOX_ADDRESS" # like https://192.168.50.10:8006/api2/json
}

variable "proxmox_node_name" {
  type    = string
  default = "proxmox-0"
}

variable "owner_ssh_key" {
  type    = string
  default = "YOUR_PUBLIC_SSH_KEY"
}
variable "vm_default_root_password" {
  type    = string
  default = "hellowubuntu2204"
}

variable "kube_nodes" {
  type = list(object({
    vm_name   = string
    vm_id     = string
    cores     = number
    memory    = number
    disk_size = number
    network_address = string
  }))

  default = [
    {
      vm_name : "k8s-master-0"
      vm_id : 200
      cores : 2
      memory : 4096
      disk_size = 15
      network_address = "dhcp"
    },
    {
      vm_name : "k8s-node-0"
      vm_id : 250
      cores : 8
      memory : 8192
      disk_size = 25
      network_address = "dhcp"
    },
    {
      vm_name : "k8s-node-1"
      vm_id : 251
      cores : 8
      memory : 8192
      disk_size = 25
      network_address = "dhcp"
    },
    {
      vm_name : "k8s-node-2"
      vm_id : 252
      cores : 8
      memory : 8192
      disk_size = 25
      network_address = "dhcp"
    }
  ]
}

variable "vm_nodes" {
  type = list(object({
    vm_name   = string
    vm_id     = string
    cores     = number
    memory    = number
    disk_size = number
    network_address = string
  }))

  default = [
    {
      vm_name : "gw-0"
      vm_id : 190
      cores : 1
      memory : 1024
      disk_size = 25
      network_address = "dhcp"
    }
  ]
}
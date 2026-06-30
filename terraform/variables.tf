# OVH API  ================================================
variable "ovh_application_key" {
  description = "OVH API application key"
  type = string
  sensitive = true
}

variable "ovh_application_secret" {
  description = "OVH API application secret"
  type = string
  sensitive = true
}

variable "ovh_consumer_key" {
  description = "OVH API consumer key"
  type = string
  sensitive = true
}

# OpenStack  ================================================
variable "os_tenant_id" {
  description = "OpenStack tenant/project ID"
  type = string
}

variable "os_tenant_name" {
  description = "OpenStack tenant/project name"
  type = string
}

variable "os_username" {
  description = "OpenStack username"
  type = string
}

variable "os_password" {
  description = "OpenStack password"
  type = string
  sensitive = true
}

variable "os_region" {
  description = "OVH region (ex: RBX, GRA11)"
  type = string
}

# VMs  ================================================
variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "vm_image" {
  description = "OS image for VMs"
  type = string
  default = "Ubuntu 24.04"
}

variable "vm_flavor_k3s" {
  description = "Flavor for K3s server (ex: d2-4)"
  type = string
  default = "d2-4"
}

variable "vm_flavor_runner" {
  description = "Flavor for runner-build (ex: d2-2)"
  type = string
  default = "d2-2"
}
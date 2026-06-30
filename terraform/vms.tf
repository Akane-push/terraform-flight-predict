# VM 1 --> K3s + runner-test-kube  ================================================
resource "openstack_compute_instance_v2" "k3s_server" {
  name = "k3s-server"
  image_name = var.vm_image
  flavor_name = var.vm_flavor_k3s
  key_pair = openstack_compute_keypair_v2.keypair.name

  network {
    name = "Ext-Net"
  }
}

# VM 2 --> Docker + runner-build  ================================================
resource "openstack_compute_instance_v2" "runner_build" {
  name = "runner-build"
  image_name = var.vm_image
  flavor_name = var.vm_flavor_runner
  key_pair = openstack_compute_keypair_v2.keypair.name

  network {
    name = "Ext-Net"
  }
}
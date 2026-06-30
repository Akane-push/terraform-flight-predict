output "k3s_server_ip" {
  description = "IP K3s server"
  value = openstack_compute_instance_v2.k3s_server.access_ip_v4
}

output "server_build_ip" {
  description = "IP runner-build"
  value = openstack_compute_instance_v2.runner_build.access_ip_v4
}
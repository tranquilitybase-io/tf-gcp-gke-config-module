output "forward_proxy_name" {
  value = data.google_compute_instance_group.mig_instances.instances
}
output "security_group_id" {
  value = module.security.allow_tls_id
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "subnet_id" {
  value = module.networking.subnet_id
}

output "worker_nodes" {
  value       = module.compute.worker_nodes
}

output "controlplane_nodes" {
  value       = module.compute.controlplane_nodes
}

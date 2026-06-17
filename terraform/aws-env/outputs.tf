output "security_group_id" {
  value = module.security.allow_tls_id
}

output "control_plane_public_ip" {
  value       = module.compute.control_plane_public_ip
}

output "control_plane_private_ip" {
  value       = module.compute.control_plane_private_ip
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "subnet_id" {
  value = module.networking.subnet_id
}
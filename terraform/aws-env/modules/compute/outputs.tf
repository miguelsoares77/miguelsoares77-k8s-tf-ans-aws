output "control_plane_public_ip" {
  description = "Kubernetes Control plane Public ip"
  value       = aws_instance.controlplane-01.public_ip
}

output "control_plane_private_ip" {
  description = "Kubernetes Control plane Private ip"
  value       = aws_instance.controlplane-01.private_ip
}
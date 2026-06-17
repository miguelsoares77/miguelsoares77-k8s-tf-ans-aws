output "ssh_key_name" {
    value = aws_key_pair.k8s_cluster_key.key_name
}

output "allow_tls_id" {
  value = aws_security_group.allow_tls.id
}
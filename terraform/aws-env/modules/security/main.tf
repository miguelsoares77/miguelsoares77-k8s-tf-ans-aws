resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  # cidr_ipv4         = aws_vpc.mainvpc.cidr_block
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  # cidr_ipv4         = aws_vpc.mainvpc.cidr_block
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# K8S RULES

resource "aws_vpc_security_group_ingress_rule" "allow_k8s_api" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 6443
  to_port           = 6443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_kubelet" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 10250
  to_port           = 10250
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_etcd" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 2379
  to_port           = 2380
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_vxlan" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 8472
  to_port           = 8472
  ip_protocol       = "udp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_nodeports" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 30000
  to_port           = 32767
  ip_protocol       = "tcp"
}

#key pair
resource "aws_key_pair" "k8s_cluster_key" {
    key_name = var.public_key_name
    public_key = var.public_key
}
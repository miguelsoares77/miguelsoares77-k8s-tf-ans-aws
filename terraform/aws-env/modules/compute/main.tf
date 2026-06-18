variable "controlplane_count" {
  default = 0
}

variable "worker_count" {
  default = 0
}

resource "aws_instance" "controlplane" {
  count = var.controlplane_count
  ami           = "ami-042dc8681de073ac4"
  instance_type = "t2.nano"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.allow_tls_id]
  key_name = var.key_name
  tags = {
    Name = format("controlplane-%02d", count.index + 1)
  }
}

resource "aws_instance" "worker" {
  count = var.worker_count
  ami           = "ami-042dc8681de073ac4"
  instance_type = "t2.nano"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.allow_tls_id]
  key_name = var.key_name
  tags = {
    Name = format("worker-%02d", count.index + 1)
  }
}

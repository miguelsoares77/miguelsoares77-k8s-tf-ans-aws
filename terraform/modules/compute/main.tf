# # # VIRTUAL MACHINES
resource "aws_instance" "controlplane-01" {
  ami           = "ami-042dc8681de073ac4"
  instance_type = "t2.nano"
  subnet_id     = var.subnet_id
  # private_ip    = "10.0.1.101"
  vpc_security_group_ids = [var.allow_tls_id]
  key_name = var.key_name
  tags = {
    Name = "controlplane-01"
  }
}

## BUDGETS
resource "aws_budgets_budget" "pobre" {
  name                = "monthly-budget"
  budget_type         = "COST"
  limit_amount        = "5.0"
  limit_unit          = "USD"
  time_unit           = "MONTHLY"
  time_period_start   = "2026-06-16_00:01"
}




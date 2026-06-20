variable "region" {
  type        = string
  description = "AWS Infra Region"
}

# SECURITY MODULE
variable "public_key_name" {
  default = "ssh_key"
}

variable "public_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}
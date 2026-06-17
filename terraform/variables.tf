variable "region" {
  type        = string
  description = "AWS Infra Region"
  default     = "eu-central-1"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true

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
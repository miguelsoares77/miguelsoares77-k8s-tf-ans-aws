module "security" {
  source = "./modules/security"
  public_key_name = var.public_key_name
  public_key = var.public_key
  vpc_id = module.networking.vpc_id
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"
  subnet_id = module.networking.subnet_id
  key_name = module.security.ssh_key_name
  allow_tls_id = module.security.allow_tls_id
}

module "vpc" {
  source                = "../modules/default"
  var_region_name       = var.region
  var_env_name          = var.env_name
  var_network_self_link = module.vpc.vpc_self_link
  var_public_subnet     = var.public_subnet
  var_private_subnet    = var.private_subnet
}

output "vpc_self_link" {
  value = "${module.vpc.vpc_self_link}"
}

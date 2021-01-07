terraform {
  required_version = "=0.14.3"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=3.22"
    }
  }
}

provider "aws" {
  region = var.region
}

module "app_network" {
  source               = "../modules/network"
  stage                = var.stage
  region               = var.region
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = var.availability_zones
}

module "app_backend" {
  source                          = "../modules/backend"
  stage                           = var.stage
  region                          = var.region
  vpc_id                          = module.app_network.vpc_id
  elb_security_groups             = [module.app_network.http_security_group]
  launch_template_security_groups = [module.app_network.http_security_group]
  elb_subnets                     = module.app_network.public_subnets
  asg_subnets                     = module.app_network.public_subnets
  elb_protocol                    = var.elb_protocol
  elb_port                        = var.elb_port
  elb_is_internal                 = var.elb_is_internal
  elb_hc_path                     = var.elb_hc_path
  ami_names_to_filter             = var.ami_names_to_filter
  launch_template_name            = var.launch_template_name
  lt_instance_type                = var.lt_instance_type
  lt_key_pair_name                = var.lt_key_pair_name
}

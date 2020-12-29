terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  version = ">= 3.22"
  region  = var.region
}

module "app_network" {
  source = "../modules/network"
  stage  = var.stage
  region = var.region
}

module "app_frontend" {
  source = "../modules/frontend"
  stage  = var.stage
  region = var.region
}

module "app_backend" {
  source = "../modules/backend"
  stage  = var.stage
  region = var.region
}

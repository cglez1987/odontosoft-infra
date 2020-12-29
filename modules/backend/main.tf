
module "network" {
  source = "../network"
  region = var.region
  stage  = var.stage
}

resource "aws_lb" "app-elb" {
  load_balancer_type = "application"
  internal           = false
  security_groups    = [module.network.elb_sg_id]
  subnets            = [module.network.subnet1_id, module.network.subnet2_id]
  tags = {
    "stage" = var.stage
  }
}



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

data "aws_ami_ids" "amazon_linux" {

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "app_launch_template" {
  name = "foo"

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
    }
  }

  ebs_optimized = true

  iam_instance_profile {
    name = "test"
  }

  image_id = aws_ami_ids.amazon_linux.id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
  }

  vpc_security_group_ids = [module.network.ec2_sg_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      stage = var.stage
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}



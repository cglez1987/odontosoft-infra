
module "network" {
  source = "../network"
  region = var.region
  stage  = var.stage
}

resource "aws_lb" "app_elb" {
  load_balancer_type = "application"
  internal           = false
  security_groups    = [module.network.elb_sg_id]
  subnets            = module.network.subnets_id

  tags = {
    "stage" = var.stage
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}

resource "aws_lb_target_group" "app_target_group" {
  deregistration_delay = 30
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = module.network.vpc_id
}


data "aws_ami_ids" "amazon_linux" {
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "app_launch_template" {
  name = "app_backend"

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
    }
  }

  image_id = data.aws_ami_ids.amazon_linux.ids[0]

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  # vpc_security_group_ids = [module.network.ec2_sg_id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      stage = var.stage
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = [module.network.ava_zones[0], module.network.ava_zones[1]]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  target_group_arns = [aws_lb_target_group.app_target_group.arn]

  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }
}

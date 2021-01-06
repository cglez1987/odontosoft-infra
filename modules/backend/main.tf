
module "network" {
  source = "../network"
  region = var.region
  stage  = var.stage
}

resource "aws_lb" "app_elb" {
  load_balancer_type = "application"
  internal           = var.elb_is_internal
  security_groups    = [module.network.default_security_group_id]
  subnets            = module.network.public_subnets

  tags = {
    "stage" = var.stage
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_elb.arn
  port              = var.elb_port
  protocol          = var.elb_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}

resource "aws_lb_target_group" "app_target_group" {
  deregistration_delay = 30
  port                 = var.elb_port
  protocol             = var.elb_protocol
  vpc_id               = module.network.vpc_id
  health_check {
    path                = var.elb_hc_path
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}


data "aws_ami_ids" "amazon_linux" {
  owners = ["amazon"]
  filter {
    name   = "name"
    values = var.ami_names_to_filter
  }
}

resource "aws_launch_template" "app_launch_template" {
  name = var.launch_template_name

  image_id = data.aws_ami_ids.amazon_linux.ids[0]

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.lt_instance_type

  key_name = var.lt_key_pair_name

  vpc_security_group_ids = [module.network.default_security_group_id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      stage = var.stage
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}

resource "aws_autoscaling_group" "bar" {
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.app_target_group.arn]
  vpc_zone_identifier = module.network.public_subnets

  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }
}


resource "aws_lb" "app_elb" {
  load_balancer_type = "application"
  internal           = var.elb_is_internal
  security_groups    = var.elb_security_groups
  subnets            = var.elb_subnets

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
  vpc_id               = var.vpc_id
  health_check {
    path                = var.elb_hc_path
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}


data "aws_ami_ids" "app_ami" {
  owners = ["amazon"]
  filter {
    name   = "name"
    values = var.ami_names_to_filter
  }
}

resource "aws_launch_template" "app_launch_template" {
  name = var.launch_template_name

  image_id = data.aws_ami_ids.app_ami.ids[0]

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.lt_instance_type

  key_name = var.lt_key_pair_name

  vpc_security_group_ids = var.launch_template_security_groups

  tag_specifications {
    resource_type = "instance"
    tags = {
      stage = var.stage
    }
  }

  # user_data = filebase64("${path.module}/example.sh")
}

resource "aws_autoscaling_group" "app_asg" {
  desired_capacity    = var.asg_desired_instances
  max_size            = var.asg_max_instances
  min_size            = var.asg_min_instances
  target_group_arns   = [aws_lb_target_group.app_target_group.arn]
  vpc_zone_identifier = var.asg_subnets

  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }
}

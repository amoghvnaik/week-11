data "template_file" "setup" {
  template = var.file

}

resource "aws_launch_configuration" "main" {
  image_id               = var.image-id
  instance_type          = var.instance-type
  key_name               = var.pem-key
  security_groups = var.vpc_security_group_ids
  user_data = data.template_file.setup.rendered


  lifecycle {
    create_before_destroy = true
  }

  associate_public_ip_address = var.associate_public_ip_address

}

resource "aws_lb" "main" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets
  tags = {
    Name = "${var.environment}-${var.region}-Private"
  }
}

resource "aws_autoscaling_group" "main" {
  vpc_zone_identifier = var.vpc_zone_identifier
  desired_capacity   = 0
  max_size           = 0
  min_size           = 0
  launch_configuration = aws_launch_configuration.main.name

}

resource "aws_autoscaling_schedule" "main" {
  scheduled_action_name  = "main"
  min_size               = 1
  max_size               = 3
  desired_capacity       = 1
  recurrence             = var.recurrence_start
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_autoscaling_schedule" "main2" {
  scheduled_action_name  = "main2"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = var.recurrence_end
  autoscaling_group_name = aws_autoscaling_group.main.name
}

resource "aws_lb_target_group" "main" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name = aws_autoscaling_group.main.id
  alb_target_group_arn   = aws_lb_target_group.main.arn
}

resource "aws_launch_configuration" "main" {
  name                   = var.name
  image_id               = var.image-id
  instance_type          = var.instance-type
  key_name               = var.pem-key
  security_groups = var.vpc_security_group_ids
 

  lifecycle {
    create_before_destroy = true
  }

  associate_public_ip_address = var.associate_public_ip_address

}

  data "template_file" "setup" {
    template = var.file
}

resource "aws_lb" "main" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

}

resource "aws_autoscaling_group" "main" {
  vpc_zone_identifier = var.vpc_zone_identifier
  desired_capacity   = 1
  max_size           = 1
  min_size           = 2
  launch_configuration = aws_launch_configuration.main.name
  target_group_arns = [aws_lb.main.arn]
}



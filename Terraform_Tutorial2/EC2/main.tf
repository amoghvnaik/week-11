resource "aws_instance" "Instance" {
  ami                    = var.ami[0]
  instance_type          = var.instance-type
  key_name               = var.pem-key
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
 

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags

  associate_public_ip_address = var.associate_public_ip_address

}

  data "template_file" "setup" {
    template = var.file
}

resource "aws_instance" "Instance2" {
  ami                    = var.ami[1]
  instance_type          = var.instance-type
  key_name               = var.pem-key
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
 

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags

  associate_public_ip_address = var.associate_public_ip_address

}

provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
}

module "aws_vpc" {
  source = "./VPC"
}

module "aws_webserver_sg" {
  source        = "./SecurityGroups"
  name          = "WebServerSG"
  vpc_id        = module.aws_vpc.vpc_id
  ingress_ports = [22, 80]
}

module "webserver_node" {
  source                 = "./EC2"
  vpc_security_group_ids = module.aws_webserver_sg.aws_wsg_id
  associate_public_ip_address = true
  file = file("${path.module}/EC2/setup.sh")
  vpc_zone_identifier = [module.aws_vpc.public_subnetA_id, module.aws_vpc.public_subnetB_id]
  subnets =  [module.aws_vpc.public_subnetA_id, module.aws_vpc.public_subnetB_id]
  security_groups =  module.aws_webserver_sg.aws_wsg_id
 
}



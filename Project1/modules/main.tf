provider "aws" {
  version                 = "~> 2.0"
  region                  = "eu-west-2"
  shared_credentials_file = "~/.aws/credentials"
}

module "aws_vpc" {
  source = "./VPC"
  environment = var.environment
  region = var.region
}

module "aws_webserver_sg" {
  source        = "./SecurityGroups"
  name          = "WebServerSG"
  vpc_id        = module.aws_vpc.vpc_id
  ingress_ports = [22, 80]
  environment = var.environment
  region = var.region
}

module "webserver_node" {
  source                 = "./EC2"
  vpc_security_group_ids = module.aws_webserver_sg.aws_wsg_id
  associate_public_ip_address = true
  file = file("${path.module}/../modules/EC2/setup.sh")
  vpc_zone_identifier = [module.aws_vpc.public_subnetA_id, module.aws_vpc.public_subnetB_id]
  subnets =  [module.aws_vpc.public_subnetA_id, module.aws_vpc.public_subnetB_id]
  security_groups =  module.aws_webserver_sg.aws_wsg_id
  vpc_id = module.aws_vpc.vpc_id
  environment = var.environment
  region = var.region
  image-id = var.ami_id
  recurrence_start = var.recurrence_start
  recurrence_end = var.recurrence_end

}

module "lambda" {
  source = "./lambda"
  environment = var.environment
  region = var.region
  cloud = var.cloud
}
 

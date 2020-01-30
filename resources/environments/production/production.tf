variable "environment" {
}
variable "region" {
}
variable "ami_id" {
}

provider "aws" {
  region = var.region
}

module "infrastructure" {
  source = "../../modules"
  environment = var.environment
  region = var.region
  ami_id = var.ami_id
}


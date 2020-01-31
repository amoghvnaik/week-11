variable "environment" {
}
variable "region" {
}
variable "ami_id" {
}
variable "recurrence_start" {
}
variable "recurrence_end" {
}
variable "cloud" {
}


provider "aws" {
  region = var.region
}

module "infrastructure" {
  source = "../../modules"
  environment = var.environment
  region = var.region
  ami_id = var.ami_id
  recurrence_start = var.recurrence_start
  recurrence_end = var.recurrence_end
  cloud = var.cloud
}

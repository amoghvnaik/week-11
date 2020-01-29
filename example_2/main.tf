provider "aws" {
  region     = "eu-west-2"
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.type
}

variable "ami" {
  description = "machine image"
  default     = "ami-f976839e"
}

variable "type" {
  # instance type
  /*
        This will determine how many CPU and RAM will be assigned
    */
  default = "t2.micro"
}

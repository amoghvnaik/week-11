variable "ami-id" {
  description = "AMI ID of ubuntu 18.04LTS eu-west-1"
  default     = "ami-0be057a22c63962cb"
}

variable "instance-type" {
  description = "Free tier EC2 Instance type"
  default     = "t2.micro"
}

variable "pem-key" {
  description = "Associated Key to SSH into the EC2 Instance"
  default     = "example"
}

variable "ami" {
  type = list(string)
  description = "AMI"
  default     = ["ami-0be057a22c63962cb", "ami-00b3184b502428cd0"]
}

variable "instance-type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "pem-key" {
  description = "pem-key"
  default     = "example"
}

variable "subnet_id" {
  description = "subnet_id"
}

variable "vpc_security_group_ids" {
  description = "Security group ID"
}

variable "tags" {
}

variable "associate_public_ip_address" {
}

variable "file" {
}

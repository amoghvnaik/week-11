variable "name" {
  default = "main"
}

variable "image-id" {
  description = "Image ID"
  default     = "ami-079a2c0c2a67ddd4d"
}

variable "instance-type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "pem-key" {
  description = "pem-key"
  default     = "example"
}

variable "vpc_security_group_ids" {
  description = "Security group ID"
}

variable "associate_public_ip_address" {
}

variable "file" {
}

variable "vpc_zone_identifier" {
}

variable "subnets" {
}

variable "security_groups" {
}

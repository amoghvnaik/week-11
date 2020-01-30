variable "name" {
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "ingress_ports" {
  type        = list(number)
  description = "List of ingress ports"
  default     = [22]
}

variable "open-internet" {
  description = "The open internet"
  default     = "0.0.0.0/0"
}

variable "outbound-port" {
  description = "The outbound port"
  default     = "0"
}


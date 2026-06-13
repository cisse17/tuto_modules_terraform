variable "env" {
  type = string
  description = "Environnement (dev, staging, prod)"
  default = "dev"
}

variable "project_name" {
  type = string
  default = "bassirou"
}

variable "vpc_id" {
  type = string
  description = "ID de notre VPC"
}

variable "allowed_ssh_cidr"{
    type = list(string)
    default = [ "0.0.0.0/0" ]
}
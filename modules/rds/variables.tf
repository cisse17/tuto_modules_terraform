variable "env" {
  type = string
  description = "Environnement (dev, prod)"
  default = "dev"
}

variable "project_name" {
  type = string
  default = "bassirou"
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "subnet_ids"{
    type = list(string)
}

variable "db_name" {
  type = string
  default = "DBbassirou"
}

variable "db_username"{
    type = string
    default = "Admin"
}


variable "db_password"{
    type = string
    default = "Admin123"
    sensitive =true
}
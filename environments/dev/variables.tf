variable "project_name" {
  type        = string
  description = "Nom du projet"
}

variable "env" {
  type        = string
  description = "Environnement (dev, staging, prod)"

}


variable "aws_region" {
  type        = string
  description = "Region d'hebergement"
  default     = "eu-west-3"
}

variable "ami" {
  type    = string
  default = "ami-0e207c18bb303cc68"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Nom de la key pair pour l'instance ec2"
  default     = "terraformcloud"
}

variable "db_name" {
  type    = string
  default = "DBbassirou"
}

variable "db_username" {
  type    = string
  default = "Admin"
}

variable "db_password" {
  type      = string
  sensitive = true
}
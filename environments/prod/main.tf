terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
  }

  required_version = ">= 0.14"
}

provider "aws" {
  region = var.aws_region
}


module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  env          = var.env
}

module "security" {
  source       = "../../modules/security"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  env          = var.env
}

module "rds" {
  source            = "../../modules/rds"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security.rds_sg_id
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  project_name      = var.project_name
  env               = var.env
}

module "ec2_1" {
  source             = "../../modules/ec2"
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security.web_sg_id]
  project_name       = var.project_name
  env                = var.env

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo "<h1>EC2-1 - ${var.env}</h1>" > /var/www/html/index.html
              systemctl start nginx
              EOF

}
module "ec2_2" {
  source             = "../../modules/ec2"
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_id          = module.vpc.public_subnet_ids[1]
  security_group_ids = [module.security.web_sg_id]
  project_name       = var.project_name
  env                = var.env

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              echo "<h1>EC2-2 - ${var.env}</h1>" > /var/www/html/index.html
              systemctl start nginx
              EOF

}

module "alb" {
  source            = "../../modules/alb"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_id = module.security.alb_sg_id
  instance_ids      = [module.ec2_1.instance_id, module.ec2_2.instance_id]
  project_name      = var.project_name
  env               = var.env
}
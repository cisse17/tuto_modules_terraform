
# Security group pour l'instance web
resource "aws_security_group" "web"{
    name = "web-sg-${var.project_name}-${var.env}"
    description = "Security group pour notre instance web"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow SSH from anywhere"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.allowed_ssh_cidr 
    } 

    ingress {
        description = "Allow HTTP from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow HTTPS from anywhere"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        description = "Allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web-sg-${var.project_name}-${var.env}"
    }
}


# Security group pour database RDS
resource "aws_security_group" "rds"{
    name = "rds-sg-${var.project_name}-${var.env}"
    description = "Security group pour l'instance RDS"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow MySQL from web security group"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.web.id]
        
    }

    egress {
        description = "Allow all outbound traffic"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }


    tags = {
        Name = "rds-sg-${var.project_name}-${var.env}"
    }
}


# ALB Security Group
resource "aws_security_group" "alb" {
    name = "alb-sg-${var.project_name}-${var.env}"
    description = "Security group pour l'ALB"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow HTTP from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
         description = "Allow HTTPS from anywhere"
         from_port = 443
         to_port = 443
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "alb-sg-${var.project_name}-${var.env}"
    }
}


resource "aws_security_group_rule" "allow_alb_to_web"{
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_group_id = aws_security_group.web.id
    source_security_group_id = aws_security_group.alb.id
    description = " Allow HTTP/HTTPS traffic from ALB to web instance"
}
resource "aws_db_subnet_group" "main" {
    name = "db-subnet-group"
    subnet_ids = var.subnet_ids
    tags = {
        Name = "db-subnet-group-${var.project_name}-${var.env}"
    }
}

resource "aws_db_instance" "rds"{
    identifier = "rds-instance"

    # Type de base de données
    engine = "mysql"
    engine_version = "8.0"

    # Tailles
    instance_class = "db.t3.micro"
    allocated_storage = 20

    # Identifiants
    db_name = var.db_name
    username = var.db_username
    password = var.db_password

    # Réseau/security
    vpc_security_group_ids = [ var.security_group_id]
    db_subnet_group_name = aws_db_subnet_group.main.name
    publicly_accessible = false

    # économiques
    skip_final_snapshot = true
    backup_retention_period = 0
    multi_az = false
    deletion_protection = false

    tags = {
         Name = "rds-instance-${var.project_name}-${var.env}"
    }

}
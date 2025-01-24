#Define Subnet Group for RDS Service
resource "aws_db_subnet_group" "custom_rds_subnet_group" {
    name = "${var.ENVIRONMENT}-custom-rds-subnet-group"
    description = "Allowed subnet for DB cluster instances"
     subnet_ids    = [
      "${var.vpc_private_subnet1}",
      "${var.vpc_private_subnet2}",
    ]

    tags = {
      Name = "${var.ENVIRONMENT}-custom-rds-subnet-group"
    }
}


# Define Security Group for RDS Instance
resource "aws_security_group" "custom_rds_sg" {

    name = "${var.ENVIRONMENT}-custom-rds-sg"
    description = "Created by "
    vpc_id = var.vpc_id


    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.RDS_CIDR}"]
        }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }

    tags = {
      Name = "${var.ENVIRONMENT}-custom-rds-sg"
    }
}


# Define RDS Instance

resource "aws_db_instance" "custom_rds" {
    identifier = "${var.ENVIRONMENT}-custom-rds"
    allocated_storage = var.CUSTOM_RDS_ALLOCATED_STORAGE
    storage_type = "gp2"
    engine = var.CUSTOM_RDS_ENGINE
    engine_version = var.CUSTOM_RDS_ENGINE_VERSION
    instance_class = var.DB_INSTANCE_CLASS
    backup_retention_period = var.BACKUP_RETENTION_PERIOD
    publicly_accessible = var.PUBLICLY_ACCESSIBLE
    username = var.CUSTOM_RDS_USERNAME
    password = var.CUSTOM_RDS_PASSWORD
    vpc_security_group_ids = [aws_security_group.custom_rds_sg.id]
    db_subnet_group_name = aws_db_subnet_group.custom_rds_subnet_group.name
    multi_az = "false"
}

output "rds_prod_endpoint" {
    description = "RDS Prod Endpoint"
    value       = aws_db_instance.custom_rds.endpoint
  
}
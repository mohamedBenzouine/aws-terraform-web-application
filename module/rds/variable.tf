variable "AWS_REGION" {
    type        = string
    default     = "us-east-1"
}

variable "BACKUP_RETENTION_PERIOD" {
    default = "7"
}

variable "PUBLICLY_ACCESSIBLE" {
    default = "true"
}

variable "CUSTOM_RDS_USERNAME" {
    default = "admin"
}

variable "CUSTOM_RDS_PASSWORD" {
    default = "admin12345"
}

variable "CUSTOM_RDS_ALLOCATED_STORAGE" {
    type = string
    default = "20"
}

variable "CUSTOM_RDS_ENGINE" {
    type = string
    default = "mysql"
}

variable "CUSTOM_RDS_ENGINE_VERSION" {
    type = string
    default = "5.7.44"
}

variable "DB_INSTANCE_CLASS" {
    type = string
    default = "db.t2.micro"
}

variable "RDS_CIDR" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ENVIRONMENT" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "Development"
}


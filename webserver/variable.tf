variable "SSH_CIDR_WEB_SERVER" {
  description = "CIDR block for SSH access to web server"
  default     = "0.0.0.0/0"
  type        = string
}

variable "INSTANCE_TYPE" {
  description = "Instance type for web server"
  default     = "t2.micro"
}

variable "AMIS" {
  description = "AMI map for the region"
  type        = map
  default = {
    "us-east-1" = "ami-0b0ea68c435eb488d"
    "us-west-2" = "ami-ami-0688ba7eeeeefe3cd"
    "us-east-2" = "ami-ami-05803413c51f242b7"
    "us-west-1" = "ami-0454207e5367abf01"
  }
}

variable "AWS_REGION" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "ENVIRONMENT" {
  description = "AWS VPC Environment Name"
  default     = "Development"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key"
  default     = "C:/Users/ghait/.ssh/levelup_key.pub"

}


variable "vpc_private_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_private_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}


variable "vpc_public_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_public_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "ENVIRONMENT" {
  type    = string
  default = "development"
}

variable "AMI" {
  type = map
  default = {
    "us-east-1" = "ami-0b0ea68c435eb488d"
    "us-west-2" = "ami-0688ba7eeeeefe3cd"
    "us-east-2" = "ami-05803413c51f242b7"
    "us-west-1" = "ami-0454207e5367abf01"
  }
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
  
}

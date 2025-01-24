/*module "custom_vpc" {
  source      = "../module/vpc"
  ENVIRONMENT = var.ENVIRONMENT
  AWS_REGION  = var.AWS_REGION
} */

module "custom_rds" {
  source      = "../module/rds"
  ENVIRONMENT = var.ENVIRONMENT
  AWS_REGION  = var.AWS_REGION
  vpc_private_subnet1 = var.vpc_private_subnet1
  vpc_private_subnet2 = var.vpc_private_subnet2
  vpc_id = var.vpc_id
}


resource "aws_security_group" "custom_sg_webserver" {
  name        = "${var.ENVIRONMENT}-custom-webservers"
  description = "Custom sg for web server"
  vpc_id      = var.vpc_id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.SSH_CIDR_WEB_SERVER]
    self        = null
    description = "SSH access from the specified CIDR"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = null
    description = "HTTP access from the specified CIDR"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self        = null
    description = "HTTPS access from the specified CIDR"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = null
    description = "Allow all traffic out"
  }

  tags = {
    Name = "${var.ENVIRONMENT}-custom-webservers"
  }
}


#Resource key pair
resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.public_key_path)
}

resource "aws_launch_template" "lunch_template_webserver" {
  name                   = "launch-template-webserver"
  image_id               = lookup(var.AMIS, var.AWS_REGION)
  instance_type          = var.INSTANCE_TYPE
  user_data = base64encode("#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP: '$MYIP > /var/www/html/index.html")
  vpc_security_group_ids = [aws_security_group.custom_sg_webserver.id]
  key_name               = aws_key_pair.levelup_key.key_name

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp2"
    }
  }
}

resource "aws_autoscaling_group" "custom_webserver" {
  name                      = "custom_webservers"
  max_size                  = 2
  min_size                  = 1
  health_check_grace_period = 30
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_template {
    id      = aws_launch_template.lunch_template_webserver.id
    version = "$Latest"
  } 
  vpc_zone_identifier       = ["${var.vpc_public_subnet1}", "${var.vpc_public_subnet2}"]
  target_group_arns         = [aws_lb_target_group.custom_lb_target_group.arn]
}

#Application load balancer for app server
resource "aws_lb" "custom_load_balancer" {
  name               = "${var.ENVIRONMENT}-custom-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.custom_sg_webserver.id]
  subnets            = ["${var.vpc_public_subnet1}", "${var.vpc_public_subnet2}"]
}


# Add Target Group
resource "aws_lb_target_group" "custom_lb_target_group" {
  name     = "load-balancer-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Adding HTTP listener

resource "aws_lb_listener" "webserver_listner" {
  load_balancer_arn = aws_lb.custom_load_balancer.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.custom_lb_target_group.arn
    type = "forward"
  }
}

output "load_balancer_output" {
  value = aws_lb.custom_load_balancer.dns_name
}

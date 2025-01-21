# AWS-Terraform-Web-Application

This repository demonstrates a complete Infrastructure as Code (IaC) implementation for deploying a scalable and secure web application on AWS using Terraform. It showcases a practical architecture with key AWS components, adhering to best practices for high availability, security, and performance.

## **Architecture Overview**

The application consists of the following components:

1. **VPC**: Custom Virtual Private Cloud for isolating resources.
2. **RDS**: Managed relational database for storing application data.
3. **Web Server**: NGINX-based web server for serving web content.
4. **Auto Scaling Group (ASG)**: Automatically adjusts the number of web servers based on traffic.
5. **Launch Configuration**: Template for provisioning EC2 instances in the ASG.
6. **Load Balancer**: Distributes traffic evenly across the web servers.
7. **EC2 Instances**: Compute resources for hosting the web application.
8. **Security Groups**: Fine-grained network access controls for all resources.
9. **NAT Gateway & Internet Gateway**: Ensures secure internet access for private resources.

## **Features**

- Fully automated infrastructure provisioning using Terraform.
- High availability with Auto Scaling and Load Balancer.
- Secure network design with VPC and Security Groups.
- Modularized Terraform code for reusability and maintainability.
- Detailed tagging for cost tracking and resource identification.

## **Repository Structure**

```
aws-terraform-web-application/
├── modules/
│   ├── rds/
│   ├── vpc/
├── webserver/
├── main.tf
├── variables.tf
├── README.md
```

### **Modules**
- **VPC**: Configures subnets, route tables, and gateways.
- **RDS**: Provisions a managed database instance.
- **Web Server**: Configures NGINX on EC2 instances.
- **ASG**: Sets up Auto Scaling for web servers.
- **Load Balancer**: Provisions an Application Load Balancer.

## **Getting Started**

### **Prerequisites**

1. Install [Terraform](https://www.terraform.io/downloads.html).
2. Configure AWS credentials using the AWS CLI or environment variables.
3. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/aws-terraform-web-application.git
   ```

### **Usage**

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Review the execution plan:
   ```bash
   terraform plan
   ```

3. Apply the infrastructure configuration:
   ```bash
   terraform apply
   ```

4. Destroy the infrastructure when no longer needed:
   ```bash
   terraform destroy
   ```

## **Key Highlights**

- **Scalable Architecture**: Demonstrates the use of ASG and Load Balancer for handling varying traffic loads.
- **Security Best Practices**: Implements Security Groups and private subnets for RDS.
- **Professional Terraform Design**: Modular code structure for clean and reusable configurations.

## **Why This Project Matters**

This project is a real-world example of designing and provisioning a scalable, secure, and highly available web application on AWS. It highlights expertise in AWS services, Terraform automation, and DevOps best practices.

By showcasing this project, you demonstrate:
- Proficiency in Terraform for IaC.
- Deep understanding of AWS infrastructure and services.
- Ability to build scalable and production-ready architectures.

---

**Feel free to explore, fork, and contribute to this project.**

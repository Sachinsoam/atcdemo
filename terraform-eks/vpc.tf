# VPC module to create a Virtual Private Cloud with specified configurations
module "vpc" {
  # Source of the VPC module from the Terraform AWS Modules registry
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"

  # Name of the VPC
  name = "vpc-module-demo"
  # CIDR block for the VPC
  cidr = "10.0.0.0/16"

  # Availability Zones used for subnets, limited to the first two zones available
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  # IP ranges for private subnets
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  # IP ranges for public subnets
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]


  # Enable public IP auto-assignment for public subnets
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
  }

  # Disables NAT gateway creation
  enable_nat_gateway = false
  # Disables VPN gateway creation
  enable_vpn_gateway = false

  # Tags for identifying the VPC resources
  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

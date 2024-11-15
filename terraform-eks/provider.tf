# Configure the AWS provider to interact with AWS services
provider "aws" {
  access_key = var.AWS_ACCESS_KEY     # Your AWS Access Key
  secret_key = var.AWS_SECRET_KEY     # Your AWS Secret Key
  region     = var.aws_region         # Specify the AWS region for the provider
}

# Data source to get the current AWS region information
data "aws_region" "current" {
  # This data source fetches the metadata of the current region where resources are deployed
}

# Data source to get the list of available availability zones in the specified AWS region
data "aws_availability_zones" "available" {
  # Retrieves availability zones to use in multi-zone configurations for high availability
}

# HTTP provider for making HTTP requests to external services
provider "http" {
  # Enables interaction with HTTP endpoints, useful for accessing data from external APIs
}


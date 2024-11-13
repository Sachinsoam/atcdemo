# Configure the AWS provider to interact with AWS services
provider "aws" {
  # Specifies the AWS region to use, set via a variable for flexibility
  region = var.aws_region
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

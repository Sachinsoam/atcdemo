# Define a variable for the EKS cluster name
variable "cluster_name" {
  type    = string
  default = "levelup-tf-eks-demo"
}

# Define a variable for the AWS region
variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

# Define a variable for AWS access key (not recommended to store in plaintext)
variable "AWS_ACCESS_KEY" {
  description = "AWS Access Key ID"
  type        = string
}

# Define a variable for AWS secret key (not recommended to store in plaintext)
variable "AWS_SECRET_KEY" {
  description = "AWS Secret Access Key"
  type        = string
}
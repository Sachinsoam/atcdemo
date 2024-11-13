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

#Defining variable for access the 
variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

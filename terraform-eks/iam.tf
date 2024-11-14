# IAM role for EKS cluster, allowing the EKS service to assume this role
resource "aws_iam_role" "eks_cluster" {
  # Name of the IAM role
  name = "eks-cluster"

  # Assume role policy for EKS to assume this role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attach AmazonEKSClusterPolicy to the EKS cluster IAM role
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  # IAM role that this policy is attached to
  role       = aws_iam_role.eks_cluster.name
}

# Attach AmazonEKSServicePolicy to the EKS cluster IAM role for service-related permissions
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}

# IAM role for EKS node group, allowing EC2 instances to assume this role
resource "aws_iam_role" "eks_nodes" {
  # Name of the IAM role for worker nodes
  name = "eks-node-group-levelup"

  # Assume role policy for EC2 instances to assume this role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attach AmazonEKSWorkerNodePolicy to the node group IAM role for permissions to work within EKS
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

# Attach AmazonEKS_CNI_Policy to the node group IAM role for CNI plugin permissions
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

# Attach AmazonEC2ContainerRegistryReadOnly policy to allow nodes read-only access to ECR
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}



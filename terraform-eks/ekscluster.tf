# Resource block to define an Amazon EKS cluster
resource "aws_eks_cluster" "aws_eks" {
  # Name of the EKS cluster
  name     = "eks_cluster_levelup"
  # IAM role with permissions for the EKS cluster
  role_arn = aws_iam_role.eks_cluster.arn

  # VPC configuration for the cluster with public subnets
  vpc_config {
    subnet_ids = module.vpc.public_subnets
  }

  # Dependencies to ensure necessary IAM policies are attached before creating the EKS cluster
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,  
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  ]

  # Tags for identifying the EKS cluster resource
  tags = {
    Name = "EKS_Cluster_LevelUp"
  }
}

# Resource block to define an EKS node group for the cluster
resource "aws_eks_node_group" "node" {
  # Name of the EKS cluster where the node group will be created
  cluster_name    = aws_eks_cluster.aws_eks.name
  # Name of the node group
  node_group_name = "node_levelup"
  # IAM role with permissions for the EKS nodes
  node_role_arn   = aws_iam_role.eks_nodes.arn
  # VPC subnet IDs for the node group
  subnet_ids      = module.vpc.public_subnets

  # Scaling configuration for the node group
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Dependencies to ensure necessary IAM policies are attached for the worker nodes,
  # allowing access to EKS and necessary resources
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

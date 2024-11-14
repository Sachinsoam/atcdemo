# Define IAM policy document for AWS Load Balancer Controller (LBC)
data "aws_iam_policy_document" "aws_lbc" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

# Create IAM Role for AWS Load Balancer Controller
resource "aws_iam_role" "aws_lbc" {
  name               = "${aws_eks_cluster.aws_eks.name}-aws-lbc"
  assume_role_policy = data.aws_iam_policy_document.aws_lbc.json
}

# Create IAM Policy for AWS Load Balancer Controller
resource "aws_iam_policy" "aws_lbc" {
  policy = file("./AWSLoadBalancerController.json")
  name   = "AWSLoadBalancerController"
}

# Attach IAM Policy to Role
resource "aws_iam_role_policy_attachment" "aws_lbc" {
  policy_arn = aws_iam_policy.aws_lbc.arn
  role       = aws_iam_role.aws_lbc.name
}

# Associate IAM Role with AWS Load Balancer Controller Pod Identity
resource "aws_eks_pod_identity_association" "aws_lbc" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.aws_lbc.arn
}

# Helm Release for AWS Load Balancer Controller
resource "helm_release" "aws_lbc" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  version    = "1.7.2"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.aws_eks.name
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  # Removed the `depends_on` line
}

  # Define dependency on Cluster Autoscaler Helm release, if required
  #depends_on = [helm_release.cluster_autoscaler]


# Resource: aws_eks_cluster

resource "aws_eks_cluster" "eks" {
  name = "sprints-eks"

  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = [
      var.SUBNET_1,
      var.SUBNET_2
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}
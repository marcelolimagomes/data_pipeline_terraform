resource "aws_eks_cluster" "local_eks" {
  name     = "local-eks-cluster"
  role_arn = "arn:aws:iam::000000000000:role/mock-role"
  vpc_config {
    subnet_ids = ["subnet-12345678"]
  }
}

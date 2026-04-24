module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         =   "21.18.0"  #"20.8.4"  # used updated version 
  name    = local.cluster_name
  #version = var.kubernetes_version
  kubernetes_version  = var.kubernetes_version

  subnet_ids      = module.vpc.private_subnets

  enable_irsa = true

  tags = {
    cluster = "demo"
  }

  vpc_id = module.vpc.vpc_id

 # eks_managed_node_group = {
 #   ami_type               = "AL2_x86_64"
 #   instance_types         = ["t3.medium"]
  #  vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  #}

  #eks_managed_node_groups = {

    #node_group = {
     # min_size     = 2
      #max_size     = 3
      #desired_size = 2
    #}
  #}
  eks_managed_node_groups = {
    node_group = {
      min_size     = 2
      max_size     = 3
      desired_size = 2

      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
    }
  }
}

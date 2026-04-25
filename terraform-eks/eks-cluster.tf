module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.18.0"

  name               = local.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  enable_irsa = true

 # cluster_endpoint_public_access = true

  #AmazonEKSClusterAdminPolicy
  access_entries = {
    admin = {
      principal_arn = "arn:aws:iam::295220279949:root"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {
    node_group = {
      min_size       = 2
      max_size       = 3
      desired_size   = 2
      instance_types = ["t3.medium"]
      ami_type       = "AL2023_x86_64_STANDARD"
    #  vpc_security_group_ids = [
#  aws_security_group.all_worker_mgmt.id
#]

#attach_cluster_primary_security_group = true
    }
  }

  tags = {
    cluster = "demo"
  }
}

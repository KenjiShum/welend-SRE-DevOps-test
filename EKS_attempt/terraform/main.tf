provider "aws" {
  region = var.region
}

# Filter out local zones, which are not currently supported 
# with managed node groups
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "welend-vpc"

  cidr = var.vpc_cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  map_public_ip_on_launch = true

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/var.cluster_name" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/var.cluster_name" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.public_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = var.ami_type
  }

  cluster_addons = {
      coredns = {
      most_recent = true
      }
      kube-proxy = {
      most_recent = true
      }
      vpc-cni = {
      most_recent = true
      }
  }

  eks_managed_node_groups = {
    main = {
      name = "main-node-group"
      labels = {}

      instance_types = var.instance_types

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size
    }
  }
}

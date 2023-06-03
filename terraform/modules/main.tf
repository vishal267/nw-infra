terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
  }
}

/*
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
*/
#module to launch vpc with two  private and two public subnets
module "nw_vpc" {
  source = "./vpc"

  environment     = var.environment
  region_name     = var.region_name
  eks_cluster_name = var.eks_cluster_name

  vpc_cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

##Module to launch EKS cluster 
module "nw_cluster" {
  source = "./nw_cluster"

  eks_subnet_ids   = flatten([module.nw_vpc.priv_subnets])
  eks_cluster_name = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  cluster_role     = var.cluster_role

  depends_on = [
    module.nw_vpc
  ]
}
##Module for eks node group 
module "eks_node_group" {
  source = "./node_group"

  eks_subnet_ids    = flatten([module.nw_vpc.priv_subnets])
  eks_cluster_name  = module.nw_cluster.cluster_name
  eks_cluster_version  = var.eks_cluster_version
  node_group_name   = var.node_group_name
  node_role_name    = var.node_role_name
  nodegroup_keypair = var.nodegroup_keypair

  depends_on = [
    module.nw_cluster,
    module.nw_vpc
  ]
}


#module for k8s services to deployed on EKS cluster 
/*
module "k8s-manifests" {
  source = "./k8s-manifests"
}

*/
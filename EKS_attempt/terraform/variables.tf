variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "cluster_name" {
  description = "K8s cluster name"
  type        = string
  default     = "welend-cluster"
}

variable "cluster_version" {
  description = "K8s cluster version"
  type        = string
  default     = "1.27"
}

variable "ami_type" {
  description = "Type of Amazon Machine Image"
  type        = string
  default     = "AL2_x86_64"
}

variable "instance_types" {
  description = "Node instance types"
  type        = list(string)
  default     = ["t3.small"]
}

variable "min_size" {
  description = "Minimum size of the node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the node group"
  type        = number
  default     = 3
}

variable "desired_size" {
  description = "Desired size of the node group"
  type        = number
  default     = 1
}
variable "region" {
  type        = string
  default     = "eu-central-1"
}

variable "access_key" {
  description = "access_key of aws account"
}
variable "secret_key" {
  description = "secret of aws account"
}


variable "name" {
  default = "alionur-demo-vpc"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "cluster_name" {
  description = "k8s cluster name"
  default     = "alionur-demo-app-cluster"
}
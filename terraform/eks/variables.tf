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

variable "k8s_version" {
  description = "k8s cluster version"
  default     = "1.20"
}

variable "eks_cluster_name" {
  description = "k8s cluster name"
  default     = "alionur-demo-app-cluster"
}

variable "root_volume_type" {
  default     = "gp2"
}

variable "worker_groups_instance_type" {
  default     = "t2.micro"
}

variable "worker_groups_additional_userdata" {
  default     = "echo foo bar"
}

variable "worker-name-1" {
  default     = "alionur-demo-worker-group-1"
}

variable "worker-name-2" {
  default     = "alionur-demo-worker-group-2"
}
variable "worker-asg_desired_capacity-1" {
  default     = "1"
}
variable "worker-asg_desired_capacity-2" {
  default     = "2"
}

# variable worker_groups {
#   description = "worker_groups"
#   type = list(object({
#     name  = string
#     additional_security_group_ids  = string
#     asg_desired_capacity = string
#   }))
#   default = [{
#       name  = "alionur-demo-worker-group-1",
#       additional_security_group_ids = "data.terraform_remote_state.vpc.outputs.worker_group_mgmt_one"
#       asg_desired_capacity  = "1"
#     },
#     {
#       name  = "alionur-demo-worker-group-2",
#       additional_security_group_ids = "data.terraform_remote_state.vpc.outputs.worker_group_mgmt_two"
#       asg_desired_capacity  = "2"
#     }]
# }
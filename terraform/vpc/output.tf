output "vpc_id" {
  value = module.vpc.vpc_id
}

output "worker_group_mgmt_one" {
  value = aws_security_group.worker_group_mgmt_one.id
}

output "worker_group_mgmt_two" {
  value = aws_security_group.worker_group_mgmt_two.id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
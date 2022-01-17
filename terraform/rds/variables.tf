variable "region" {
  type        = string
  default     = "eu-central-1"
}

variable "db_password" {
  description = "RDS root user password"
  #sensitive   = true
  default = "alionur-demo-app"
}

variable "db_user" {
  description = "RDS root user"
  default = "postgres"
}


variable "access_key" {
  description = "access_key of aws account"
}
variable "secret_key" {
  description = "secret of aws account"
}
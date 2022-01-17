data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "alionur-demo-app"
    workspaces = {
      name = "alionur-demo-app"
    }
  }
}
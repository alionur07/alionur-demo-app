terraform {
  backend "remote" {
    organization = "alionur-demo-app"
    workspaces {
      name = "alionur-demo-app-eks"
    }
  }
}
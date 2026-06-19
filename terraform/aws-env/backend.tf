terraform {
  cloud {
    organization = "wukali"
    workspaces {
      name = "kubernetes-aws-cluster"
    }
  }
}
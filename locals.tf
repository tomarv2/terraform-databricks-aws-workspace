locals {
  region  = data.aws_region.current.name
  profile = var.profile_for_iam != null ? var.profile_for_iam : var.profile
}

data "aws_region" "current" {}

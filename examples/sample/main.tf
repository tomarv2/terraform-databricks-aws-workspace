terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 3.63"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "databricks_workspace" {
  source = "../../"

  # NOTE: One of the below is required:
  # - 'profile_for_iam' - for IAM creation (if none is provided 'default' is used)
  # - 'existing_role_name'
  profile_for_iam = "iam-admin"
  #existing_role_name         = "arn:aws:iam::123456789012:role/demo-role"
  aws_region                  = var.aws_region
  databricks_account_username = "example@example.com"
  databricks_account_password = "sample123!"
  databricks_account_id       = "1234567-1234-1234-1234-1234567"

  custom_tags = tomap(
    {
      "Dept"        = "data",
      "Application" = "demo"
    }
  )
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

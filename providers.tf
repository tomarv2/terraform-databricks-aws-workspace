terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 3.63"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.5.1"
    }
    random = {
      version = "~> 3.1"
    }
    time = {
      version = "~> 0.7"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "aws" {
  alias = "iam-management"

  region  = var.region
  profile = local.profile
}


# initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias = "mws"

  host     = var.databricks_hostname
  username = var.databricks_account_username
  password = var.databricks_account_password
}

# initialize provider in normal mode
provider "databricks" {
  # in normal scenario you won't have to give providers aliases
  alias = "created_workspace"

  host = databricks_mws_workspaces.this.workspace_name
}

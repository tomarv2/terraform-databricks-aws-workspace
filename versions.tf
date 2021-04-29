provider "aws" {
  region  = var.aws_region
  profile = var.profile_to_use
}

terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      version = "~> 3.30"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.3"
    }
    random = {
      version = "~> 3.1"
    }
    time = {
      version = "~> 0.7"
    }
  }
}

# initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  username = var.databricks_account_username
  password = var.databricks_account_password
}

# initialize provider in normal mode
provider "databricks" {
  # in normal scenario you won't have to give providers aliases
  alias = "created_workspace"
  host  = databricks_mws_workspaces.this.workspace_name
}

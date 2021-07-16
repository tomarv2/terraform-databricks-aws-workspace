terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 3.47"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.5"
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
  region  = var.aws_region
  profile = var.profile_to_use
  default_tags {
    tags = {
      Name    = "${var.teamid}-${var.prjid}"
      team    = var.teamid
      project = var.prjid
    }
  }
}

provider "aws" {
  alias   = "iam-management"
  region  = var.aws_region
  profile = local.profile_to_use
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

  host = databricks_mws_workspaces.this.workspace_name
}

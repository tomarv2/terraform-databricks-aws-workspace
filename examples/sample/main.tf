module "databricks_workspace" {
  source = "../../"

  # NOTE: One of the below is required:
  # - 'profile_for_iam' - for IAM creation (if none is provided 'default' is used)
  # - 'existing_role_name'
  profile_for_iam = "iam-admin"
  #existing_role_name          = "arn:aws:iam::123456789012:role/demo-role"
  aws_region                  = "us-east-1"
  databricks_account_username = "example@example.com"
  databricks_account_password = "sample123!"
  databricks_account_id       = "1234567-1234-1234-1234-1234567"
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "databricks_workspace" {
  source = "../../"

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

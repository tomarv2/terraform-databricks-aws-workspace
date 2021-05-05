module "databricks_workspace" {
  source = "git::git@github.com:tomarv2/terraform-databricks-aws-workspace.git?ref=v0.0.4"

  profile_for_iam             = "iam-admin"
  aws_region                  = "us-east-2"
  databricks_account_username = "example@example.com"
  databricks_account_password = "sample123!"
  databricks_account_id       = "1234567-1234-1234-1234-1234567"
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

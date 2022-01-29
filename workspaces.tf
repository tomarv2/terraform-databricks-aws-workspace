resource "databricks_mws_workspaces" "this" {
  provider = databricks.mws

  account_id      = var.databricks_account_id
  aws_region      = var.aws_region
  workspace_name  = "${var.teamid}-${var.prjid}"
  deployment_name = "${var.teamid}-${var.prjid}"

  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id
}

resource "time_sleep" "wait" {
  depends_on      = [module.iam_role]
  create_duration = "10s"
}

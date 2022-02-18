resource "databricks_token" "pat" {
  provider = databricks.created_workspace

  comment          = "Terraform managed: ${var.teamid}-${var.prjid}"
  lifetime_seconds = 86400
}

/* Create PAT token to provision entities within workspace
 https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/token
*/
/*
resource "databricks_token" "pat" {
  provider = databricks.created_workspace

  comment          = "Terraform managed: ${var.teamid}-${var.prjid}"
  lifetime_seconds = 86400
}
*/

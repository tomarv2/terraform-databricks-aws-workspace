resource "databricks_mws_networks" "this" {
  provider = databricks.mws

  account_id         = var.databricks_account_id
  network_name       = "${var.teamid}-${var.prjid}-${local.suffix}"
  security_group_ids = [module.vpc.default_security_group_id]
  subnet_ids         = module.vpc.private_subnets
  vpc_id             = module.vpc.vpc_id
}

resource "databricks_mws_credentials" "this" {
  provider = databricks.mws

  account_id       = var.databricks_account_id
  role_arn         = var.existing_role_name != null ? var.existing_role_name : join("", module.iam_role.*.iam_role_arn)
  credentials_name = "${var.teamid}-${var.prjid}-${local.suffix}"

  depends_on = [module.iam_role]
}

resource "databricks_mws_storage_configurations" "this" {
  provider = databricks.mws

  account_id                 = var.databricks_account_id
  bucket_name                = module.s3.bucket_name
  storage_configuration_name = "${var.teamid}-${var.prjid}-${local.suffix}"
}

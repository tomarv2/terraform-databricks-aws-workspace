data "databricks_aws_assume_role_policy" "this" {
  external_id = var.databricks_account_id
}

data "databricks_aws_crossaccount_policy" "cross_account_iam_policy" {}


data "databricks_aws_bucket_policy" "this" {
  bucket = module.s3.s3_bucket_name
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket     = module.s3.s3_bucket_id
  policy     = data.databricks_aws_bucket_policy.this.json
  depends_on = [databricks_mws_networks.this]
}

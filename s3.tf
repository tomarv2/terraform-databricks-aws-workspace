data "databricks_aws_bucket_policy" "this" {
  bucket = module.s3.bucket_name
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket     = module.s3.bucket_id
  policy     = data.databricks_aws_bucket_policy.this.json
  depends_on = [databricks_mws_networks.this]
}

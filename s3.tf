module "s3" {
  source = "git::git@github.com:tomarv2/terraform-aws-s3.git?ref=v0.0.8"

  custom_tags = var.custom_tags
  # -----------------------------------------
  # Do not change the teamid, prjid once set.
  teamid = var.teamid
  prjid  = "${var.prjid}-${local.suffix}"
}

data "databricks_aws_bucket_policy" "this" {
  bucket = module.s3.bucket_name
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket     = module.s3.bucket_id
  policy     = data.databricks_aws_bucket_policy.this.json
  depends_on = [databricks_mws_networks.this]
}

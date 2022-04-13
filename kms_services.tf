data "aws_iam_policy_document" "databricks_managed_services_cmk" {
  version = "2012-10-17"
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid    = "Allow Databricks to use KMS key for control plane managed services"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::414351767826:root"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt"
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "managed_services_customer_managed_key" {
  policy = data.aws_iam_policy_document.databricks_managed_services_cmk.json
}

resource "aws_kms_alias" "managed_services_customer_managed_key_alias" {
  name          = "alias/managed-services-customer-managed-key-alias"
  target_key_id = aws_kms_key.managed_services_customer_managed_key.key_id
}

resource "databricks_mws_customer_managed_keys" "managed_services" {
  account_id = var.databricks_account_id
  aws_key_info {
    key_arn   = aws_kms_key.managed_services_customer_managed_key.arn
    key_alias = aws_kms_alias.managed_services_customer_managed_key_alias.name
  }
  use_cases = ["MANAGED_SERVICES"]
}

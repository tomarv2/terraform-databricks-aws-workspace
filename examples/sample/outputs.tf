output "vpc_id" {
  description = "vpc id"
  value       = module.databricks_workspace.vpc_id
}

output "iam_role_arn" {
  description = "iam role arn"
  value       = module.databricks_workspace.iam_role_arn
}

output "s3_bucket_arn" {
  description = "s3 bucket arn"
  value       = module.databricks_workspace.s3_bucket_arn
}

output "databricks_mws_network_id" {
  description = "databricks mws network id"
  value       = module.databricks_workspace.databricks_mws_network_id
}

output "storage_configuration_id" {
  description = "databricks mws storage id"
  value       = module.databricks_workspace.databricks_mws_storage_id
  sensitive   = true
}

output "databricks_host" {
  description = "databricks workspace url"
  value       = module.databricks_workspace.workspace_url
  sensitive   = true
}

output "databricks_credentials_id" {
  description = "databricks credentials id"
  value       = module.databricks_workspace.databricks_credentials_id
}

output "databricks_deployment_name" {
  description = "databricks deployment name"
  value       = module.databricks_workspace.databricks_deployment_name
}

/*
output "pat_token" {
  description = "databricks pat"
  value       = module.databricks_workspace.pat_token
}


output "pat_token_duration" {
  description = "databricks pat"
  value       = module.databricks_workspace.pat_token_duration
}
*/

output "vpc_id" {
  description = "vpc id"
  value       = module.databricks_workspace.vpc_id
}

output "vpc_route_table_ids" {
  description = "list of VPC route tables IDs"
  value       = module.databricks_workspace.vpc_route_table_ids
}

output "vpc_security_group_id" {
  description = "VPC security group ID"
  value       = module.databricks_workspace.vpc_security_group_id
}
output "vpc_subnet_ids" {
  description = "list of subnet ids within VPC"
  value       = module.databricks_workspace.vpc_subnet_ids
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

output "sensitive_databricks_token" {
  description = "Value of the newly created token"
  value       = module.databricks_workspace.databricks_token
  sensitive   = true
}

output "databricks_token" {
  description = "Value of the newly created token (nonsensitive)"
  value       = module.databricks_workspace.nonsensitive_databricks_token
}

output "databricks_token_lifetime_hours" {
  description = "Token validity"
  value       = module.databricks_workspace.databricks_token_lifetime_hours
}

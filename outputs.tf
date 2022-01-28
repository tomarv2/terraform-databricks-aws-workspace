output "vpc_id" {
  description = "vpc id"
  value       = module.vpc.vpc_id
}

output "vpc_route_table_ids" {
  description = "list of VPC route tables IDs"
  value       = concat(module.vpc.private_route_table_ids, module.vpc.public_route_table_ids)
}

output "vpc_security_group_ids" {
  description = "list of VPC security group IDs"
  value       = [module.vpc.default_security_group_id]
}
output "vpc_subnet_ids" {
  description = "list of subnet ids within VPC"
  value       = concat(module.vpc.private_subnets, module.vpc.public_subnets)
}

output "iam_role_arn" {
  description = "iam role arn"
  value       = module.iam_role.*.iam_role_arn
}

output "inline_policy_id" {
  description = "inline policy id"
  value       = module.iam_policies.*.inline_policy_id
}

output "s3_bucket_name" {
  description = "s3 bucket name"
  value       = module.s3.s3_bucket_name
}

output "s3_bucket_arn" {
  description = "s3 bucket arn"
  value       = module.s3.s3_bucket_arn
}

output "s3_bucket_id" {
  description = "s3 bucket id"
  value       = module.s3.s3_bucket_id
}

output "databricks_mws_credentials_id" {
  description = "databricks mws credentials id"
  value       = databricks_mws_credentials.this
}

output "databricks_mws_network_id" {
  description = "databricks mws network id"
  value       = databricks_mws_networks.this.network_name
}

output "databricks_mws_storage_id" {
  description = "databricks mws storage id"
  value       = databricks_mws_storage_configurations.this
}

output "databricks_mws_storage_bucket_name" {
  description = "databricks mws storage bucket name"
  value       = databricks_mws_storage_configurations.this.bucket_name
}

output "databricks_host" {
  description = "databricks hostname"
  value       = databricks_mws_workspaces.this.workspace_name
}

output "databricks_credentials_id" {
  description = "databricks credentials id"
  value       = databricks_mws_workspaces.this.credentials_id
}

output "databricks_deployment_name" {
  description = "databricks deployment name"
  value       = databricks_mws_workspaces.this.deployment_name
}

output "storage_configuration_id" {
  description = "databricks storage configuration id"
  value       = databricks_mws_workspaces.this.storage_configuration_id
}

output "workspace_url" {
  description = "databricks workspace url"
  value       = databricks_mws_workspaces.this
}

/*
output "databricks_token" {
  description = "databricks token"
  value       = databricks_token.pat.id
  sensitive   = true
}


output "pat_token_duration" {
  description = "databricks pat"
  value       = databricks_token.pat.lifetime_seconds
}
*/

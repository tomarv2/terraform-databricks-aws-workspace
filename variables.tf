variable "teamid" {
  description = "Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "databricks_hostname" {
  description = "databricks hostname"
  type        = string
  default     = "https://accounts.cloud.databricks.com"
}

variable "databricks_account_username" {
  description = "databricks account username"
  type        = string
}

variable "databricks_account_password" {
  description = "databricks account password"
  type        = string
}

variable "databricks_account_id" {
  description = "External ID provided by third party."
  type        = string
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 3
}

locals {
  suffix = random_string.naming.result
}

variable "existing_role_name" {
  description = "If you want to use existing role name, else a new role will be created"
  default     = null
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.4.0.0/16"
  type        = string
}

variable "custom_tags" {
  type        = any
  description = "Extra custom tags"
  default     = null
}

variable "profile" {
  description = "profile to use for resource creation"
  default     = "default"
  type        = string
}

variable "profile_for_iam" {
  description = "profile to use for IAM"
  default     = null
  type        = string
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
